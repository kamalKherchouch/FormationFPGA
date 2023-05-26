library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.ALL;

entity counter_unit is
	generic ( Cst : positive := 100000000); -- Pour le réel : 100000000 et pour la simu : 100
    port ( 
        clk         : in std_logic; 
        resetn      : in std_logic; 
        End_Counter : out std_logic
     );
end counter_unit;

architecture behavioral of counter_unit is

    --Declaration des signaux internes
    signal D_out : positive range 0 to Cst; -- Pour la synthèse
    --signal D_out : positive ; -- Pour la simu
    Signal Cmd   : std_logic := '0';
    
    begin
        --Partie sequentielle
        process(clk,resetn)
        begin
            if(resetn = '1') then
                D_out <= 0;
                elsif(rising_edge(clk)) then
                    D_out <= D_out + 1 ;
                    if (Cmd = '1') then
                        D_out <= 0;
                    end if;
            end if;
    end process;

    --Partie combinatoire
    Cmd <= '1'  when (D_out = Cst-1 )
            else '0';
    End_Counter <= Cmd;
    
end behavioral;