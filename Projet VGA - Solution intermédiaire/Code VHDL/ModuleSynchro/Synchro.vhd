library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Synchro is
    port ( 
		clk   		        : in std_logic;
        resetn		        : in std_logic; 
		H_SYNCH			    : out std_logic;
		V_SYNCH			    : out std_logic;
		Position_Horizontal	: out integer;
		Position_Vertical	: out integer
     );
end Synchro;

architecture behavioral of Synchro is
	-- On créer les signaux de positionnement (horizontal et vertical)
	signal S_Position_Horizontal : integer range 0 to 799 := 0;
	signal S_Position_Vertical   : integer range 0 to 524 := 0;
	
	begin		
		process(clk,resetn)
        begin
            if(resetn = '1') then
                H_SYNCH <= '0';
                V_SYNCH <= '0';
                S_Position_Horizontal <= 0;
                S_Position_Vertical <= 0;
            elsif (rising_edge(clk)) then
            
                --	On génére le dimensionnement de notre fenêtre (lignes + colonnes)
                if(S_Position_Horizontal < 799) then
                    S_Position_Horizontal <= S_Position_Horizontal+1;
                else
                    S_Position_Horizontal <= 0;
                    if(S_Position_Vertical < 524) then
                        S_Position_Vertical <= S_Position_Vertical+1;
                    else
                        S_Position_Vertical <= 0;
                    end if;
                end if;	
                
                -- On génére la "Pulse" à '0' sur le signal H_SYNCH.
                if (S_Position_Horizontal > 655 and S_Position_Horizontal < 751) then
                    H_SYNCH <= '0';
                else
                    H_SYNCH <= '1';				
                end if;	
                    
                -- On génére la "Pulse" à '0' sur le signal V_SYNCH.
                if (S_Position_Vertical > 489 and S_Position_Vertical < 492) then
                    V_SYNCH <= '0';
                else
                    V_SYNCH <= '1';				
                end if;  
			end if;
		end process;
		
		Position_Horizontal <= S_Position_Horizontal;
		Position_Vertical   <= S_Position_Vertical;
end behavioral;