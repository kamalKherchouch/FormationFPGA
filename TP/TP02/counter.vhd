library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.ALL;

entity counter_unit is
    port ( 
        clk         : in std_logic; 
        resetn      : in std_logic; 
        restart     : in std_logic;
        End_Counter : out std_logic;
        LED_Output  : out std_logic
     );
end counter_unit;

architecture behavioral of counter_unit is

    --Declaration des signaux internes
    constant Cst : positive := 200000000; --pratique = 200000000 Simulation = 200
    signal D_out : positive range 0 to Cst ; -- pour la synthèse !!!!
    --signal D_out : positive := 0; -- Pour la simulation !!!!
    Signal Cmd   : std_logic := '0';
    Signal s_LED_Output : std_logic := '0';
    
    begin

        --Partie sequentielle
        process(clk,resetn, restart)
        begin
            if(resetn = '1') then
                D_out <= 0;
                s_LED_Output <= '0';
                 elsif(rising_edge(clk)) then
                    if (restart = '1') then 
                        D_out <= 0;
                        s_LED_Output <= '0';
                    else
                        D_out <= D_out + 1 ;
                        if (Cmd = '1') then
                            D_out <= 0;
                            s_LED_Output <= not(s_LED_Output);
                        end if;
                     end if;
            end if;
    end process;

    --Partie combinatoire
    Cmd <= '1'  when (D_out = Cst-1 )
            else '0';
    End_Counter <= Cmd;
    
    LED_Output <= s_LED_Output;
    
end behavioral;