library ieee;
use ieee.std_logic_1164.all;

entity tb_Synchro is
end tb_Synchro;

architecture behavioral of tb_Synchro is

    -- Valeur des Reset du projet. 
	signal clk         : std_logic := '0';
	signal resetn      : std_logic := '0';
	signal H_SYNCH			    : std_logic;
	signal V_SYNCH			    : std_logic;
	signal Position_Horizontal	: integer;
	signal Position_Vertical	: integer;
	
		
	-- Les constantes suivantes permette de definir la frequence de l'horloge à 25.175 MHz
	constant hp : time := 19.86 ns;      -- Demi periode de 19.86ns
	constant period : time := 2*hp;  -- Période de 39.72ns

	
	component Synchro
		port ( 
			clk         	: in std_logic;
	        resetn      	: in std_logic;
			H_SYNCH			    : out std_logic;
		    V_SYNCH			    : out std_logic;
		    Position_Horizontal	: out integer;
		    Position_Vertical	: out integer
		 );
	end component;
	
	begin
	dut: Synchro
        port map (
            clk         	    => clk, 
            resetn     		    => resetn,
			H_SYNCH			    => H_SYNCH,
			V_SYNCH			    => V_SYNCH,
		    Position_Horizontal	=> Position_Horizontal,
		    Position_Vertical	=> Position_Vertical
        );
	
	-- Process Gestion de la Clock
	process	
	   begin   
	       clk <= not clk;
	       wait for hp;
    end process;

    
    -- Process Gestion du resetn
	process	
	   begin   
--	       wait for 100*period;
--	       resetn <= not resetn;
--	       wait for 100000*period;
--	       resetn <= not resetn;
--	       wait for 755287*period;
    end process;
       

end behavioral;