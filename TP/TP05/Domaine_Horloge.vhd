library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Domaine_Horloge is
    port ( 
		clk   		: in std_logic;
        resetn		: in std_logic; 
		LED0_Output : out std_logic_vector (2 downto 0);
		LED1_Output : out std_logic_vector (2 downto 0)
     );
end Domaine_Horloge;

architecture behavioral of Domaine_Horloge is
    
    -- Valeur des Reset du projet.
    Signal Reset_Value : std_logic := '0';
    Signal Locked_PLL_resetAuto : std_logic;
    
    -- Signaux pour clock
    Signal clka : std_logic;
    Signal clkb : std_logic;
    
    --Compteur stretch
    Signal Count_stretch : positive range 0 to 4;
    
    -- Signaux internes pour le Compteur 10 cycles
    --Signal Counter_End_Cycle : positive ;
    Signal Counter_End_Cycle : positive range 0 to 10;
    Signal Dix_Cycle : std_logic;
    Signal Data_End_Cycle : std_logic;
    Signal L0_Data_End_Cycle : std_logic;
    Signal L1_Data_End_Cycle : std_logic;
    
    signal Color_Code_projet  : std_logic_Vector (1 downto 0); 
    signal Update      : std_logic;
    signal Update_data : std_logic;
    signal End_Counter : std_logic;
    signal r1_Data_Update : std_logic;
--    signal r2_Data_Update : std_logic;
--    signal r3_Data_Update : std_logic;
    signal UpdateB : std_logic := '0';
    signal UpdateStretch : std_logic;
       
    -- Lié à la machine d'état.
    type state is (Etat_Init, Etat_Rouge, Etat_Vert, Etat_Bleu); 
    signal current_state : state;  -- Etat dans lequel on se trouve actuellement
    signal next_state : state;	   -- Etat dans lequel on passera au prochain coup d'horloge
    
    -- Signaux la gestion des Codes Couleurs 
    Signal Code_Rouge   : std_logic_Vector (1 downto 0) := "01";
    Signal Code_Vert    : std_logic_Vector (1 downto 0) := "10"; 
    Signal Code_Bleu    : std_logic_Vector (1 downto 0) := "11";
    Signal Code_Eteint  : std_logic_Vector (1 downto 0) := "00";
    	
	-- Composant LedDriver
    component LedDriver
		port ( 
		clk			: in std_logic; 
        resetn		: in std_logic; 
        Color_Code  : in std_logic_Vector (1 downto 0); 
		Update      : in std_logic; 
		LED_Output  : out std_logic_vector (2 downto 0);
		Data_End_Cycle : out std_logic
     );
    end component;
    
    -- Composant PLL
	component PLL_Clock
            port (
                clk_100MHz : in std_logic;
                reset      : in std_logic;
                clk_250MHz : out std_logic;
                clk_50MHz  : out std_logic;
                locked     : out std_logic
            );
        end component;
	
	
	begin
    --Affectation des signaux Pour les modules utilisés
	Led_Driver_Led0 : LedDriver
        port map (
            clk => clka, 
            resetn => resetn,
            Color_Code => Color_Code_projet,
            Update => Update,
            LED_Output => LED0_Output,
            Data_End_Cycle => L0_Data_End_Cycle
        );
    Led_Driver_Led1 : LedDriver
        port map (
            clk => clkb, 
            resetn => resetn,
            Color_Code => Color_Code_projet,
            Update => UpdateB,
            LED_Output => LED1_Output,
            Data_End_Cycle => L1_Data_End_Cycle
        );
     PLL : PLL_Clock
        port map (
            clk_100MHz => clk,
            reset      => resetn,
            clk_250MHz => clka,
            clk_50MHz  => clkb,
            locked     => Locked_PLL_resetAuto
        );
		
		-- ************** Gestion du reset ************** --
		process(Locked_PLL_resetAuto, clka) 
		begin
            if(Locked_PLL_resetAuto = Reset_Value) then
                -- Lors du reset on réinitialise la machine d'état.
                current_state <= Etat_Init; 
			elsif(rising_edge(clka)) then
			    -- On change d'état à chaque front montant de End_Counter.
			    current_state <= next_state;
			end if;       
		end process;
		-- **************-- Fin du reset **************** --
		
		-- ************** Début de process du signal Update **************** --
		process(clka) 
		begin
            if(rising_edge(clka)) then
			     Update <= Update_data;	         			  
			end if;       
		end process;
		-- ************** Fin de process du signal Update **************** --
		
		-- ************** Début Gestion du compteur de fin de cycle ************** --
		process(Locked_PLL_resetAuto, clka) 
		begin
            if(Locked_PLL_resetAuto = Reset_Value) then
                Counter_End_Cycle <= 0;           
			elsif(rising_edge(clka)) then
			     if (Dix_Cycle ='0') then 
			          if (L0_Data_End_Cycle = '1') then
			               Counter_End_Cycle <= Counter_End_Cycle + 1;
			          else
			              Counter_End_Cycle <= Counter_End_Cycle;
			          end if;	
			      else
                        Counter_End_Cycle <= 0;
			      end if;	         			  
			end if;       
		end process;
		-- **************** Fin de la gestion du compteur de fin de cycle **************** --
        -- ************** Début Partie combinatoire : Gestion du compteur de fin de cycle ************** --
        Dix_Cycle <= '1' when ( Counter_End_Cycle = 10) 
            else '0';       
        -- ************** Fin Partie combinatoire : Gestion du compteur de fin de cycle ************** --
        
        -- ************** Début de processe de la Machine d'états ************** --
		process(current_state, next_state,Dix_Cycle, L0_Data_End_Cycle ) -- Liste des signaux de sensibilité du processe
		begin 	
           case current_state is
                when Etat_Init =>
                    Color_Code_projet <= Code_Eteint;
                    if(L0_Data_End_Cycle = '1') then
                        next_state  <= Etat_Rouge;
                        Update_data <= '1';
                    else
                        next_state  <= Etat_Init;
                        Update_data <= '0';
                    end if;
                    
                when Etat_Rouge =>
                    Color_Code_projet <= Code_Rouge;
                    if(Dix_Cycle = '1') then
                        next_state  <= Etat_Bleu;
                        Update_data <= '1';
                    else
                        next_state  <= current_state;
                        Update_data <= '0';
                    end if; 
                    
				-- L'indicateur Led_Commande passe à 1.
                when Etat_Bleu =>
                    Color_Code_projet <= Code_Bleu;
                    if(Dix_Cycle = '1') then
                        next_state  <= Etat_Vert;
                        Update_data <= '1';
                    else
                        next_state  <= current_state;
                        Update_data <= '0';
                    end if; 
                    
                 when Etat_Vert =>
                    Color_Code_projet <= Code_Vert;
                    if(Dix_Cycle = '1') then
                        next_state  <= Etat_Rouge;
                        Update_data <= '1';
                    else
                        next_state  <= current_state;
                        Update_data <= '0';
                    end if; 
              end case;  
		end process;
		-- *************** FIN de processe de la Machine d'états *************** --
		
		-- Cross clock domaine solution
--        process (clka) is
--        begin
--          if rising_edge(clka) then
--            -- r1_Data is METASTABLE, r2_Data and r3_Data are STABLE
--            r1_Data_Update <= Update;
--            r2_Data_Update <= r1_Data_Update;
--            r3_Data_Update <= r2_Data_Update;
         
--            if r3_Data_Update = '0' and r2_Data_Update = '1' then
--              -- Positive Edge Condition
--              UpdateB <= '1';
--            end if;
--          end if;
--        end process;

-----------Début process synchronisation des clock A et B----------------------
        process (clka) is
        begin
        if (rising_edge (clka)) then
            if ( Update_data ='1') then 
                Count_stretch <= 4;
            elsif Count_stretch > 0 then  -- Evite l'overflow
                Count_stretch <= Count_stretch-1;            
            end if;
        end if;
        end process;
        
-----------Fin process synchronisation des clock A et B----------------------   

-----------Début combinatoire synchronisation des clock A et B---------------------- 
    UpdateB <= '1' when Count_stretch > 0
        else '0';
-----------fin combinatoire synchronisation des clock A et B---------------------- 
--		-- Cross clock domaine solution
--        process (clkb) is
--        begin
--          if rising_edge(clkb) then
--            -- r1_Data is METASTABLE, r2_Data and r3_Data are STABLE
--            r1_Data_Update <= UpdateStretch ;
--            UpdateB <= r1_Data_Update;
--          end if;
--        end process;

end behavioral;