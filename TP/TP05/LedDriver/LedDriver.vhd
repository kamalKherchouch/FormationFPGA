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
    
    -- signal lié au reset
    signal Reset_Value : std_logic := '1';
    
    -- Lié au Compteur.
    signal End_Counter  : std_logic;
    
    -- Signaux interne
    signal S_LED_Output      : std_logic_vector (2 downto 0);
    signal Code_Couleur      : std_logic_vector (2 downto 0); -- Signal de sortie du multiplexeur vers la bascule
    signal Data_Code_Couleur : std_logic_vector (2 downto 0); -- Signal de sortie de la bascule
    
	 -- Composant Counter_Unit
    component Counter_unit 
		port ( 
			clk         : in std_logic; 
            resetn      : in std_logic; 
            End_Counter : out std_logic
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
		
		-- ************** Gestion du reset ************** --
		process(resetn, clk) 
		begin
            if(resetn = Reset_Value) then
                -- Lors du reset on réinitialise la machine d'état.
                current_state <= Etat_Eteint; 
			elsif(rising_edge(clk)) then
			    -- On change d'état à chaque front montant de End_Counter.
			    current_state <= next_state;
			end if;       
		end process;
		-- **************-- Fin du reset **************** --

        -- ************** Début de processe de la Machine d'états ************** --
		process(current_state, next_state, END_Counter) -- Liste des signaux de sensibilité du processe
		begin 	
           case current_state is
                -- L'indicateur Led_Commande passe à 0.
                when Etat_Eteint =>
                    LED_Commande_Fsm <= "000";
                    if(rising_edge(END_Counter)) then
                        next_state <= Etat_Allume; 
                    end if; 
                    
				-- L'indicateur Led_Commande passe à 1.
                when Etat_Allume =>
                    LED_Commande_Fsm <= "111";
                if(rising_edge(END_Counter)) then
                        next_state <= Etat_Eteint; 
                    end if; 

              end case;  
		end process;
		-- *************** FIN de processe de la Machine d'états *************** --
        
        -- ************** Début de processe de la gestion du Code Couleur ************** --
        process(resetn, clk) 
		begin
            if(resetn = Reset_Value) then
                -- Lors du reset on réinitialise les signaux lié au Code Couleur.
                Data_Code_Couleur   <= "000";
			elsif(rising_edge(clk)) then
			    -- On change d'état à chaque front montant de End_Counter.
			    if(update = '1') then
			        Data_Code_Couleur <= Code_Couleur;
			    else 
			        Data_Code_Couleur <= Data_Code_Couleur;
			    end if;
			end if;       
		end process;
        -- ************** Fin de processe de la gestion du Code Couleur ************** --
        
        -- ************** Partie combinatoire de la gestion du Code Couleur ************** --        
        Code_Couleur <= "000" when (Color_Code = "00")
            else "001" when (Color_Code = "01")
               else "010" when (Color_Code = "10")
                  else "100" when (Color_Code = "11")
                    else "000";
        -- ************** Fin combinatoire de la gestion du Code Couleur ************** --

        -- ************** DEB Partie process de la gestion de END_CYCLE ************** -- 
        process(resetn, clk) 
		begin
            if(resetn = Reset_Value) then
                -- Lors du reset on réinitialise les signaux lié au Code Couleur.
                --End_Cycle   <= '0';
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
            if(resetn = Reset_Value) then
                -- Lors du reset on réinitialise les signaux lié au Code Couleur.
                S_Data_End_Cycle <= '0';
			elsif(rising_edge(clk)) then
			    S_Data_End_Cycle <= End_Cycle;
			--else
			    --S_Data_End_Cycle <= S_Data_End_Cycle;
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