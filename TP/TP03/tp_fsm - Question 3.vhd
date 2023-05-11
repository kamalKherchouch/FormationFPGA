library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity tp_fsm is
    generic (
        --vous pouvez ajouter des parameres generics ici
        constant Nb_Cycle : positive := 5 
    );
    port ( 
		clk			: in std_logic; 
        resetn		: in std_logic;
		--a completer
		Output_On_Off : out std_logic
     );
end tp_fsm;

architecture behavioral of tp_fsm is

    --type state is (idle, state1, state2); --a modifier avec vos etats
    
    --signal current_state : state;  --etat dans lequel on se trouve actuellement
    --signal next_state : state;	   --etat dans lequel on passera au prochain coup d'horloge
    
    signal End_Counter  : std_logic;
    signal D_out_1 : positive := 0; -- Pour la simulation !!!!
    signal RAZ        : std_logic;
    
   
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
		
	
		process(clk,resetn)
		begin
            if(resetn = '1') then
                D_out_1 <= 0;
                --current_state <= idle;   
			elsif(rising_edge(clk)) then
			     
				--current_state <= next_state;
				
				--a completer avec votre compteur de cycles
				if(RAZ = '0') then 
				    if(End_counter = '1') then 
				        D_out_1 <= D_out_1 + 1;
                    elsif(End_counter = '0') then
                        D_out_1 <= D_out_1;
                    end if;
                 else 
                    D_out_1 <= 0;
                 end if;
            end if;
		end process;
		
		--Partie combinatoire
    RAZ <= '1'  when (D_out_1 = Nb_Cycle-1 and End_Counter = '1')
            else '0';
    Output_On_Off <= RAZ;

end behavioral;