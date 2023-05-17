library ieee;
use ieee.std_logic_1164.all;

entity tb_PilotageLED_Memoire is
end tb_PilotageLED_Memoire;

architecture behavioral of tb_PilotageLED_Memoire is

	signal resetn      : std_logic := '1';
	signal clk         : std_logic := '0';
	signal Bouton_0    : std_logic := '0';
	signal LED_0       : std_logic_vector (1 downto 0) := "00";

    
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
	
	component PilotageLED_Memoire
		port ( 
			clk			: in std_logic; 
			resetn		: in std_logic;
			Bouton_0     : in std_logic;
		    LED_0 : out std_logic_vector (1 downto 0)
		 );
	end component;
	
	begin
	dut: PilotageLED_Memoire
        port map (
            clk => clk, 
            resetn => resetn,
            Bouton_0 => Bouton_0,
			LED_0 => LED_0
        );
	
	process	
	begin 
	    
	     
	for i in 1 to 5000 loop
	   clk <= not clk;
	   wait for hp;
	   if(i>0 and i<1000) then
	      resetn <= '1';
	      Bouton_0 <= '0';
	   elsif (i>=1000 and i<2000) then
	       resetn <= '0';
	       Bouton_0 <= '0';
	   elsif (i>=2000 and i<3000) then
	       resetn <= '0';
	       Bouton_0 <= '1';
	   else
	       resetn <= '1';
	   end if;	       
	end loop; 
  
    end process;
	
end behavioral;