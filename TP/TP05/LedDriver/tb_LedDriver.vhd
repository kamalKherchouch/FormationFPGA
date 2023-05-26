library ieee;
use ieee.std_logic_1164.all;

entity tb_LedDriver is
end tb_LedDriver;

architecture behavioral of tb_LedDriver is
		
	signal clk         : std_logic := '0';	
	signal resetn      : std_logic := '1';
	signal Color_Code  : std_logic_vector (1 downto 0) := "00";
	signal Update      : std_logic := '0';
	signal LED_Output  : std_logic_vector (2 downto 0) := "000";
	signal Data_End_Cycle : std_logic := '0';
    --signal Data_Code_Couleur : std_logic_vector (2 downto 0) := "000";
    
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
	
	component LedDriver
		port ( 
		    signal clk            : in std_logic;
			signal resetn         : in std_logic;
            signal Color_Code     : in std_logic_vector (1 downto 0);
            signal Update         : in std_logic;
            signal LED_Output     : out std_logic_vector (2 downto 0);
            signal Data_End_Cycle : out std_logic
		 );
	end component;
	
	begin
	dut: LedDriver
        port map (
            clk            =>   clk,
            resetn         =>   resetn,
            Color_Code     =>   Color_Code, 
            Update         =>   Update,
            LED_Output     =>   LED_Output,
            Data_End_Cycle => Data_End_Cycle
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
	       wait for 10*period;
	       resetn <= '1';
	       wait for 100*period;
	       resetn <= '0';
	       wait for 10000*period;
    end process;
    
    -- Process Gestion du signal Color_Code
	process	
	   begin   
	      wait for 500*period;
	      Color_Code <= "00"; 
	      wait for 500*period;
	      Color_Code <= "01";
	      wait for 500*period; 
	      Color_Code <= "10";
	      wait for 500*period; 
	      Color_Code <= "11";
	      wait for 500*period; 
    end process;
    
    -- Process Gestion du signal Update
	process	
	   begin   
	      wait for 700*period;
	      Update <= not Update;  
    end process;
    

	
end behavioral;