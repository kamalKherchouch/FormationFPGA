library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity LedDriver is
    port ( 
		clk			: in std_logic; 
        resetn		: in std_logic; 
        Color_Code  : in std_logic_Vector (1 downto 0); 
		Update      : in std_logic; 
		LED_Output  : out std_logic_vector (2 downto 0);
		Data_End_Cycle : out std_logic
     );
end LedDriver;

architecture behavioral of LedDriver is

    -- Lié à la machine d'état.
    type state is (Etat_Eteint, Etat_Allume); 
    signal current_state : state;  -- Etat dans lequel on se trouve actuellement
    signal next_state : state;	   -- Etat dans lequel on passera au prochain coup d'horloge
    signal LED_Commande_Fsm : std_logic_vector (2 downto 0); -- Signal indiquant le status de notre FSM (Leds ON ou Leds OFF)
    signal LED_Commande_Fsm_D0 : std_logic;
    signal End_Cycle : std_logic;
    signal S_Data_End_Cycle : std_logic;
    
    
    signal RESET : std_logic;
    
    -- Lié au Compteur.
    signal End_Counter  : std_logic;
    
    -- Signaux interne
    signal S_LED_Output      : std_logic_vector (2 downto 0); -- Signal de sortie porte AND entre la FIFO et FSM
    
    -- Signal lié à Update
    signal Update_data       : std_logic;
    signal S_Update_data     : std_logic;
    signal Update_Validation : std_logic;
    
    -- Signal lié à Code couleur
    signal Code_Couleur      : std_logic_vector (1 downto 0); -- Signal de sortie de la Fifo sur 2 bits.
    signal Data_Code_Couleur : std_logic_vector (2 downto 0); -- traduction de Code_Couleur sur 3 bits.
    
	 -- Composant Counter_Unit
    component Counter_unit 
		port ( 
			clk         : in std_logic; 
            resetn      : in std_logic; 
            End_Counter : out std_logic
		 );
	end component;
	-- Composant FIFO_Code_Couleur
	component FIFO_Code_Couleur
            port (
                clk   : in std_logic;
                srst  : in std_logic;
                din   : in std_logic_vector(1 downto 0);
                wr_en : in std_logic;
                rd_en : in std_logic;
                dout  : out std_logic_vector(1 downto 0);
                full  : out std_logic;
                empty : out std_logic
            );
        end component;
	
	begin
    --Affectation des signaux du testbench avec ceux de l'entite a tester
    
	Compteur : Counter_unit
        port map (
            clk => clk, 
            resetn => resetn,
            End_Counter => End_Counter
        );
    Fifo : FIFO_Code_Couleur
            port map (
                clk => clk,
                srst => RESET,
                din => Color_Code,
                wr_en => Update_Validation,
                rd_en => End_Cycle,
                dout => Code_Couleur
            );
		
		RESET <= not resetn;
		-- ************** Gestion du reset ************** --
		process(resetn, clk) 
		begin
            if(resetn = '0') then
                -- Lors du reset on réinitialise la machine d'état.
                current_state <= Etat_Eteint; 
			elsif(rising_edge(clk)) then
			    -- On change d'état à chaque front montant de End_Counter.
			    current_state <= next_state;
			end if;       
		end process;
		-- **************** Fin du reset **************** --
    
        -- **************  Début Process detection de front sur le signal Update **************** --
        process(resetn, clk) 
		begin
            if(resetn = '0') then
                Update_data <= '0';
                S_Update_data <= '0';
			elsif(rising_edge(clk)) then
			    S_Update_data <= Update;
                Update_data <= S_Update_data;  
			end if;     
		end process;
        -- **************  Fin Process detection de front sur le signal Update **************** --
        Update_Validation <= not (Update_data) and S_Update_data;

        -- ************** Début de processe de la Machine d'états ************** --
		process(current_state, next_state, END_Counter) -- Liste des signaux de sensibilité du processe
		begin 	
           case current_state is
                -- L'indicateur Led_Commande passe à 0.
                when Etat_Eteint =>
                    LED_Commande_Fsm <= "000";
                    if(END_Counter = '1') then
                        next_state <= Etat_Allume; 
                    else 
                        next_state <= current_state;
                    end if; 
                    
				-- L'indicateur Led_Commande passe à 1.
                when Etat_Allume =>
                    LED_Commande_Fsm <= "111";
                    if(END_Counter = '1') then
                        next_state <= Etat_Eteint; 
                    else 
                        next_state <= current_state;
                    end if; 

              end case;  
		end process;
		-- *************** FIN de processe de la Machine d'états *************** --
        
        -- ************** Partie combinatoire de la gestion de la traduction 2 bits vers 3 bits ************** --        
        Data_Code_Couleur <= "000" when (Code_Couleur = "00")
            else "001" when (Code_Couleur = "01")
               else "010" when (Code_Couleur = "10")
                  else "100" when (Code_Couleur = "11")
                    else "000";
        -- ************** Fin combinatoire de la gestion de la traduction 2 bits vers 3 bits ************** --
        
        -- ************** DEB Partie process de la gestion de END_CYCLE ************** -- 
        process(resetn, clk) 
		begin
            if(resetn = '0') then
                LED_Commande_Fsm_D0 <= '0';
			elsif(rising_edge(clk)) then
			    -- On change d'état à chaque front montant de End_Counter.
			    if(LED_Commande_Fsm(0) = '1') then
			        LED_Commande_Fsm_D0 <= LED_Commande_Fsm(0);
			    else 
			        LED_Commande_Fsm_D0 <= '0';
			    end if;
			end if;       
		end process;
		-- ************** FIN Partie process de la gestion de END_CYCLE ************** -- 
        -- ************** DEB Partie Combinatoire de la gestion de END_CYCLE ************** --
        End_cycle <= not(LED_Commande_Fsm_D0) and LED_Commande_Fsm(0);
        -- ************** DEB Partie Combinatoire de la gestion de END_CYCLE ************** --
        
        -- ************** DEB Partie process de la gestion de DATA_END_CYCLE ************** -- 
        process(resetn, clk) 
		begin
            if(resetn = '0') then
                -- Lors du reset on réinitialise les signaux lié au Code Couleur.
                S_Data_End_Cycle <= '0';
			elsif(rising_edge(clk)) then
			    S_Data_End_Cycle <= End_Cycle;
			end if;       
		end process;
		-- ************** FIN Partie process de la gestion de DATA_END_CYCLE ************** -- 
		Data_End_Cycle <= S_Data_End_Cycle;
		
        -- ************** Partie Combinatoire entre Fsm et Code Couleur ************** -- 
		S_LED_Output <= Data_Code_Couleur and LED_Commande_Fsm;
		-- Signal de sortie prends le signal interne.      
        LED_Output <= S_LED_Output;
        -- ************** Fin Combinatoire entre Fsm et Code Couleur ************** -- 
        
end behavioral;