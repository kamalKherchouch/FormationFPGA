library ieee;
use ieee.std_logic_1164.all;

entity tb_Domaine_Horloge is
end tb_Domaine_Horloge;

architecture behavioral of tb_Domaine_Horloge is

    -- Valeur des Reset du projet.
    Signal Reset_Value : std_logic := '1';
    
	signal clk         : std_logic := '0';
--	signal clka         : std_logic := '0';
--	signal clkb         : std_logic := '0';
	signal resetn      : std_logic := '1';
	signal LED0_Output : std_logic_vector (2 downto 0) := "000";
	signal LED1_Output : std_logic_vector (2 downto 0) := "000";
	signal Update      : std_logic := '0' ;
	signal Color_Code  : std_logic_vector (1 downto 0) := "01";
	
		
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
--	constant hpA : time := 2 ns;      --demi periode de 2ns
--	constant periodA : time := 2*hpA;  --periode de 4ns, soit une frequence de 250MHz
--	constant hpB : time := 10 ns;      --demi periode de 10ns
--	constant periodB : time := 2*hpB;  --periode de 20ns, soit une frequence de 50MHz
	
	component Domaine_Horloge
		port ( 
			clk         : in std_logic;
	        resetn      : in std_logic;
		    LED0_Output : out std_logic_vector (2 downto 0);
		    LED1_Output : out std_logic_vector (2 downto 0)
		 );
	end component;
	
	begin
	dut: Domaine_Horloge
        port map (
            clk         => clk, 
            resetn      => resetn,
			LED0_Output => LED0_Output,
			LED1_Output => LED1_Output
        );
	
	-- Process Gestion de la Clock
	process	
	   begin   
	       clk <= not clk;
	       wait for hp;
    end process;
    
    -- Process Gestion de la Clock B
--	process	
--	   begin   
--	       clkb <= not clkb;
--	       wait for hpB;
--    end process;
    
    -- Process Gestion du resetn
	process	
	   begin   
	       wait for 100*period;
	       resetn <= not Reset_Value;
    end process;
       

end behavioral;