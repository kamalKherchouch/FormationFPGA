library ieee;
use ieee.std_logic_1164.all;

entity tb_PilotageLED_Avec_Module_LedDriver is
end tb_PilotageLED_Avec_Module_LedDriver;

architecture behavioral of tb_PilotageLED_Avec_Module_LedDriver is

	signal clk                 : std_logic := '0';
	signal resetn              : std_logic := '0';
	signal Bouton_Color_Code   : std_logic := '0';
	signal Buton_Update        : std_logic := '0';
	signal LED_Output          : std_logic_vector (2 downto 0) := "000";
		
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
	
	component PilotageLED_Avec_Module_LedDriver
		port ( 
			clk                 : in std_logic;
	        resetn              : in std_logic;
	        Bouton_Color_Code   : in std_logic;
	        Buton_Update        : in std_logic;
	        LED_Output          : out std_logic_vector (2 downto 0)
		 );
	end component;
	
	begin
	dut: PilotageLED_Avec_Module_LedDriver
        port map (
            clk               => clk, 
            resetn            => resetn,
            Bouton_Color_Code => Bouton_Color_Code,
			Buton_Update      => Buton_Update,
			LED_Output        => LED_Output
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
	       resetn <= '1';
	       wait for 4000*period;
	       resetn <= '0';
	       wait for 4000*period;
    end process;
    
    -- Process Gestion du Bouton_1 : Code Couleur
	process	
	   begin   
	       for i in 1 to 4 loop
	           wait for 800*period;
	           Bouton_Color_Code <= not Bouton_Color_Code;
	       end loop;
    end process;
    
    -- Process Gestion du Bouton_0 : Update
	process	
	   begin   
	       for i in 1 to 3 loop
	           wait for 1200*period;
	           Buton_Update <= not Buton_Update;
	       end loop;
    end process;
	
end behavioral;