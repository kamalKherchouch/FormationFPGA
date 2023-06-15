library ieee;
use ieee.std_logic_1164.all;

entity tb_Generateur_Pattern is
end tb_Generateur_Pattern;

architecture behavioral of tb_Generateur_Pattern is

    -- Valeur des Reset du projet. 
	signal clk         : std_logic := '0';
	signal resetn      : std_logic := '1';
	signal H_SYNCH	   : std_logic;
	signal V_SYNCH 	   : std_logic;
	signal Rouge_Intensite : std_logic_vector (3 downto 0) := "0000";
	signal Vert_Intensite  : std_logic_vector (3 downto 0) := "0000";
	signal Bleu_Intensite  : std_logic_vector (3 downto 0) := "0000";
	
		
	-- Les constantes suivantes permette de definir la frequence de l'horloge à 125 MHz
	constant hp : time := 4 ns;      -- Demi periode de 4 ns
	constant period : time := 2*hp;      -- Période de 8 ns

	
	component Generateur_Pattern
		port ( 
			clk         	: in std_logic;
	        resetn      	: in std_logic;
			H_SYNCH	        : out std_logic;
			V_SYNCH	   		: out std_logic;
		    Rouge_Intensite : out std_logic_vector (3 downto 0);
			Vert_Intensite  : out std_logic_vector (3 downto 0);
		    Bleu_Intensite  : out std_logic_vector (3 downto 0)
		 );
	end component;
	
	begin
	dut: Generateur_Pattern
        port map (
            clk         	=> clk, 
            resetn     		=> resetn,
			H_SYNCH			=> H_SYNCH,
			V_SYNCH			=> V_SYNCH,
			Rouge_Intensite => Rouge_Intensite,
			Vert_Intensite  => Vert_Intensite,
			Bleu_Intensite  => Bleu_Intensite
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
	       wait for 100*period;
	       resetn <= not resetn;
	       wait for 4325100*period;
	       resetn <= not resetn;
	       wait for 5000*period;
	end process;

end behavioral;