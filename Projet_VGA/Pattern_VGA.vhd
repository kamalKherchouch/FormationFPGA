library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.Librairie_Perso.all;

entity Pattern_VGA is
    port ( 
		clk   		    : in std_logic;
        resetn		    : in std_logic; 
		Position_H	    : in integer;
		Position_V	    : in integer;
		Rouge_Intensite : out std_logic_vector(3 downto 0);
		Vert_Intensite  : out std_logic_vector(3 downto 0);
		Bleu_Intensite  : out std_logic_vector(3 downto 0)
     );
end Pattern_VGA;

architecture behavioral of Pattern_VGA is
	signal Intensite_faible : std_logic_vector (3 downto 0) := "0000";
	signal Intensite_Haute  : std_logic_vector (3 downto 0) := "1111";
	begin		
		process(clk,resetn)
        begin
            if(resetn = '1') then
                -- Si reset activé, on éteint tout.
                Rouge_Intensite <= Intensite_faible;
                Vert_Intensite  <= Intensite_faible;
                Bleu_Intensite  <= Intensite_faible;
            elsif (rising_edge(clk)) then
                -- La partie invisible du pattern VGA est fixée à une intensité faible.
                if ((Position_H > 639 and Position_H < 799) or (Position_V > 479 and Position_V < 524)) then
                    Rouge_Intensite <= Intensite_faible;
                    Vert_Intensite  <= Intensite_faible;
                    Bleu_Intensite  <= Intensite_faible;
                end if;
                
                if((position_H = 0 and position_V = 0) or (position_H = 639 and position_V = 479) or (position_H = 0 and position_V = 479) or (position_H = 639 and position_V = 0)) then
                    Rouge_Intensite <= Intensite_haute;
                    Vert_Intensite  <= Intensite_faible;
                    Bleu_Intensite  <= Intensite_faible;
                    
                -- On place les carrés blancs sur la 1ère ligne de notre damier
                elsif(((Position_H > 127 and Position_H < 256 and Position_V < 120)) or ((Position_H > 383 and Position_H < 512 and Position_V < 120))) then
                    Rouge_Intensite <= Intensite_Haute;
                    Vert_Intensite  <= Intensite_Haute;
                    Bleu_Intensite  <= Intensite_Haute;
                -- On place les carrés blancs sur la 2ème ligne de notre damier
                elsif ((Position_H < 128 and (Position_V > 119 and Position_V < 240)) or ((Position_H > 255 and Position_H < 384) and (Position_V > 119 and Position_V < 240)) or ((Position_H > 511 and Position_H < 640) and (Position_V > 119 and Position_V < 240))) then
                    Rouge_Intensite <= Intensite_Haute;
                    Vert_Intensite  <= Intensite_Haute;
                    Bleu_Intensite  <= Intensite_Haute;
                -- On place les carrés blancs sur la 3ème ligne de notre damier
                elsif(((Position_H > 127 and Position_H < 256 and (Position_V > 239 and Position_V < 360))) or ((Position_H > 383 and Position_H < 512 and (Position_V > 239 and Position_V < 360)))) then
                    Rouge_Intensite <= Intensite_Haute;
                    Vert_Intensite  <= Intensite_Haute;
                    Bleu_Intensite  <= Intensite_Haute;  
                -- On place les carrés blancs sur la 4ème ligne de notre damier
                elsif ((Position_H < 128 and (Position_V > 359 and Position_V < 480)) or ((Position_H > 255 and Position_H < 384) and (Position_V > 359 and Position_V < 480)) or ((Position_H > 511 and Position_H < 640) and (Position_V > 359 and Position_V < 480))) then
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