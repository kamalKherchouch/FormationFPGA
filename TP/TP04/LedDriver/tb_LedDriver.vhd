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
    --signal Data_Code_Couleur : std_logic_vector (2 downto 0) := "000";
    
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
	
	component LedDriver
		port ( 
		    signal clk         : in std_logic;
			signal resetn      : in std_logic;
            signal Color_Code  : in std_logic_vector (1 downto 0);
            signal Update      : in std_logic;
            signal LED_Output  : out std_logic_vector (2 downto 0)
		 );
	end component;
	
	begin
	dut: LedDriver
        port map (
            clk         =>   clk,
            resetn      =>   resetn,
            Color_Code  =>   Color_Code, 
            Update      =>   Update,
            LED_Output  =>   LED_Output 
        );
	
	process	
	begin 
	    
	     
	for i in 1 to 10000 loop
	   clk <= not clk;
	   wait for hp;
	   if(i>0 and i<1000) then
	      resetn <= '1';
	      Color_Code <= "00";
	   elsif (i>=1000 and i<2000) then
	       resetn <= '0';
	   elsif (i>=2000 and i<3000) then
	       Update <= '0';
	   elsif (i>=3000 and i<3500) then    
	       Update <= '0';
	   elsif (i>=3000 and i<4000) then
	       Update <= '1';
	       Color_Code <= "01";
	   elsif (i>=5000 and i<6000) then
	       Update <= '0';
	       Color_Code <= "11";  
	   elsif (i>=6000 and i<7000) then
	       Update <= '0';
	       Color_Code <= "10";    
	   else
	       Update <= '1';
	   end if;	       
	end loop; 
  
    end process;
	
end behavioral;