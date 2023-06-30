library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Use ieee.numeric_std.all;

entity Pattern_VGA2 is
    port ( 
		clk   		    : in std_logic;
        resetn		    : in std_logic; 
		Position_H	    : in integer;
		Position_V	    : in integer;
		Rouge_Intensite : out std_logic_vector(3 downto 0);
		Vert_Intensite  : out std_logic_vector(3 downto 0);
		Bleu_Intensite  : out std_logic_vector(3 downto 0)
     );
end Pattern_VGA2;

architecture behavioral of Pattern_VGA2 is
	signal Intensite_faible : std_logic_vector (3 downto 0) := "0000";
	signal Intensite_Haute  : std_logic_vector (3 downto 0) := "1111";
	signal Compteur : integer := 0;
	
	begin		
		process(clk,resetn)
        begin
            if(resetn = '1') then
                -- Si reset activé, on éteint tout.
                Rouge_Intensite <= Intensite_faible;
                Vert_Intensite  <= Intensite_faible;
                Bleu_Intensite  <= Intensite_faible;
                --Compteur <= 0;
            elsif (rising_edge(clk)) then
                --Compteur <= Compteur+1;
                -- La partie invisible du pattern VGA est fixée à une intensité faible.
                if ((Position_H > 639 and Position_H < 799) or (Position_V > 479 and Position_V < 524)) then
                    Rouge_Intensite <= Intensite_faible;
                    Vert_Intensite  <= Intensite_faible;
                    Bleu_Intensite  <= Intensite_faible;
                end if;
                if((Position_H mod 2 = 0 and Position_V mod 2 = 1) or (Position_H mod 2 = 1 and Position_V mod 2 = 0)) then
                    --Rouge_Intensite <= std_logic_vector(to_signed(Compteur,4));
                    Rouge_Intensite <= Intensite_Haute;
                    Vert_Intensite  <= Intensite_Haute;
                    Bleu_Intensite  <= Intensite_Haute;
                else 
                    Rouge_Intensite <= Intensite_faible;
                    Vert_Intensite  <= Intensite_faible;
                    Bleu_Intensite  <= Intensite_faible;
                end if;
			end if;
		end process;
		
end behavioral;