library ieee;
use ieee.std_logic_1164.all;

entity tb_tp_fsm is
end tb_tp_fsm;

architecture behavioral of tb_tp_fsm is

	signal resetn      : std_logic := '1';
	signal clk         : std_logic := '0';
	--a completer 
	signal Restart      : std_logic := '0';
	signal Output_On_Off : std_logic := '0';
	signal LED_OUT : std_logic_vector( 2 downto 0) := "000";
	
	--constant nb_loop   : positive := 100;
	signal D_out_1 : positive := 0;
	
	
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
	constant Nb_Cycle : positive := 3; 
	constant Nb_loop : positive := 250;
	signal Indice : std_logic := '0';
	
	component tp_fsm
		port ( 
			clk			: in std_logic; 
			resetn		: in std_logic;
			Restart     : in std_logic;
			--a completer
			Output_On_Off : out std_logic;
		    LED_OUT : out std_logic_vector( 2 downto 0)
		 );
	end component;
	
	begin
	dut: tp_fsm
        port map (
            clk => clk, 
            resetn => resetn,
            Restart => Restart,
			--a completer
			Output_On_Off => Output_On_Off,
			LED_OUT => LED_OUT
        );
	
--	process	
--	begin 
	        
--	  -- Test avec Reset non active
--	   resetn <= '0';
--	   for i in 1 to 2 loop
--	       for i in 1 to nb_loop loop
--			 clk <= not clk;
--			 wait for hp;
--			 if (D_out_1 = Nb_Cycle-1) then
--			     assert Output_On_Off = '0'
--		         report "Output_On_Off : test failed, il devrait etre a  0" severity failure;
--		      end if;
--		   end loop;
--		end loop; 
--	   -- Test avec Reset active
--	   resetn <= '0';
--	   for i in 1 to 10 loop
--	       if (i > 5 and i < 8) then 
--	           resetn <= '1';
--	       else 
--	           resetn <= '0';
--	       end if;
--	       for i in 1 to nb_loop loop
--		      clk <= not clk;
--			  wait for hp;
--			  if (D_out_1 = Nb_Cycle-1) then
--			     assert Output_On_Off = '1'
--		         report "Output_On_Off : test failed, il devrait etre a  1" severity failure;
--		      end if;
--		    end loop;
--		end loop;	
--	end process;	
	
	process	
	begin 
	    
	     
	for i in 1 to 200000 loop
	   clk <= not clk;
	   wait for hp;
	   if(i>0 and i<1000) then
	       resetn <= '1';
	       restart <= '1';
	   elsif (i>=90000 and i<100000) then
	       resetn <= '1';
	       restart <= '0';
	   elsif (i>=100000 and i<160000) then
	       resetn <= '0';
	       restart <= '0';
	   elsif (i>=160000 and i<170000) then
	       resetn <= '0';
	       restart <= '1';
	   else
	       resetn <= '0';
	       restart <= '0';
	   end if;	       
	end loop; 
  
    end process;
	
end behavioral;