library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity tp_fsm is
    generic (
        --vous pouvez ajouter des parameres generics ici
        constant Nb_Cycle : positive := 3
    );
    port ( 
		clk			: in std_logic; 
        resetn		: in std_logic;
		--a completer
		Restart      : in std_logic;
		Output_On_Off : out std_logic;
		LED_OUT : out std_logic_vector( 2 downto 0)
     );
end tp_fsm;

architecture behavioral of tp_fsm is

    type state is (Etat_Init, Etat_Rouge, Etat_Bleu, Etat_Vert); --a modifier avec vos etats
    
    signal current_state : state;  --etat dans lequel on se trouve actuellement
    signal next_state : state;	   --etat dans lequel on passera au prochain coup d'horloge
    
    signal End_Counter  : std_logic;
    --signal D_out_1 : positive := 0; -- Pour la simulation !!!!
    signal D_out_1 : positive range 0 to Nb_Cycle ; -- Pour la synth�se
    signal RAZ     : std_logic;
    signal S_LED_OUT : std_logic_vector(2 downto 0) := "000";
    
    -- Pour la validation du compteur de Clignotement
    signal Validation_Clignotement : std_logic;
    -- signal Compteur_CLignotement : positive := 0; -- Pour la simulation
    signal Compteur_CLignotement : positive range 0 to Nb_Cycle*2 ;  -- Pour la synth�se
     
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
		
		-- processe pour le comptage
		process(clk,resetn,Restart) -- Liste des signaux de sensibilit� du processe
		begin
            if(resetn = '1' or Restart = '1') then
                D_out_1 <= 0;
                current_state <= Etat_Init;
                Compteur_CLignotement <= 0;   
			elsif(rising_edge(clk)) then
			    current_state <= next_state;
				
				-- Comptage pour D_out_1
				if(RAZ = '0') then 
				    if(End_counter = '1') then 
				        D_out_1 <= D_out_1 + 1;
                    elsif(End_counter = '0') then
                        D_out_1 <= D_out_1;
                    end if;
                 else 
                    D_out_1 <= 0;
                 end if;
				 
				 -- Comptage du compteur de clignotement
                 if(D_out_1 = Nb_Cycle-1 and End_Counter = '1') then
                    Compteur_CLignotement <= Compteur_CLignotement+1; 
                    else if (Validation_Clignotement ='1') then
                        Compteur_CLignotement <= 0;                 
                    else
                        Compteur_CLignotement <= Compteur_CLignotement;
                    end if;
                 end if;
            end if;       
		end process;
		
		--Partie combinatoire
        RAZ <= '1' when (D_out_1 = Nb_Cycle-1 and End_Counter = '1') -- Fin de comptage pour D_out_1
                else '0';
        Output_On_Off <= RAZ; -- on affecte RAZ � Output_On_Off
        LED_OUT <= S_LED_OUT; -- on affecte S_LED_OUT � LED_OUT
        
        Validation_Clignotement <= '1' when (Compteur_CLignotement = (Nb_Cycle*2) and End_Counter = '1') -- on passe Validation_Clignotement � 1 pour indiquer le changement d'�tat de notre machine
                else '0';


        -- processe de la machine d'�tats
		process(current_state,Restart,Validation_Clignotement,Compteur_CLignotement,RAZ ) -- Liste des signaux de sensibilit� du processe
		begin 	
           case current_state is
              when Etat_Init =>
                if(Restart = '0') then -- Restart non activ�
                       if (Validation_Clignotement = '0') then -- Validation_clignotement permet de connaitre le nombre de clignotement par �tat
                            if(Compteur_CLignotement mod 2 = 0 ) then -- si Compteur_CLignotement est impaire on �teint les leds sinon on les actives
                                S_LED_OUT <= "000"; -- On �teint les LEDS
                            else
                                S_LED_OUT <= "111"; -- on active la couleur blanche
                            end if; -- on passe � l'�tat initialisation
                            next_state <= Etat_Init; 
                        else       -- On passe � l'�tat suivant         
                            next_state <= Etat_Rouge; 
                        end if;    
                else -- Restart activ�
                    next_state <= Etat_Init; 
                    S_LED_OUT <= "000";   
                end if;
                
				-- M�me logique de commantaire pour les autres �tats...
                when Etat_Rouge =>
                  if(Restart = '0') then 
                       if (Validation_Clignotement = '0') then
                            if(Compteur_CLignotement mod 2 = 0 ) then 
                                S_LED_OUT <= "000";
                            else
                                S_LED_OUT <= "001";
                            end if;
                        next_state <= Etat_Rouge; 
                        else                  
                            next_state <= Etat_Bleu; 
                        end if;    
                 else 
                     next_state <= Etat_Init;
                     S_LED_OUT <= "000";
                 end if;
                 
                when Etat_Bleu =>
                   if(Restart = '0') then 
                         if (Validation_Clignotement = '0') then
                            if(Compteur_CLignotement mod 2 = 0 ) then 
                                S_LED_OUT <= "000";
                            else
                                S_LED_OUT <= "100";
                            end if;
                            next_state <= Etat_Bleu; 
                        else                  
                            next_state <= Etat_Vert; 
                        end if;    
                    else 
                         next_state <= Etat_Init; 
                         S_LED_OUT <= "000";
                     end if;  

               when Etat_Vert =>
                 if(Restart = '0') then 
                       if (Validation_Clignotement = '0') then
                            if(Compteur_CLignotement mod 2 = 0 ) then 
                                S_LED_OUT <= "000";
                            else
                                S_LED_OUT <= "010";
                            end if;
                            next_state <= Etat_Vert;                             
                        else                  
                            next_state <= Etat_Rouge; 
                        end if;    
                 else 
                    next_state <= Etat_Init;
                    S_LED_OUT <= "000";
                 end if;  
                
              When OTHERS =>
                next_state <= Etat_Init;
                S_LED_OUT <= "000";
              end case;  
		end process;
    
end behavioral;