library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package Librairie_Perso is
    procedure Rectangle (
        signal Curseur_x  : in integer;
        signal Curseur_y  : in integer;
        signal Position_x : in integer;
        signal Position_y : in integer;
        signal Couleur    : out std_logic_vector (3 downto 0);
        signal Dessin     : out std_logic
        );   
end Librairie_Perso;

package body Librairie_Perso is
    procedure Rectangle (
        signal Curseur_x  : in integer;
        signal Curseur_y  : in integer;
        signal Position_x : in integer;
        signal Position_y : in integer;
        signal Couleur    : out std_logic_vector (3 downto 0);
        signal Dessin     : out std_logic
        ) is
        
    begin
    
    if ((Curseur_x > Position_x and Curseur_x < (Position_x+128)) and (Curseur_y > Position_y and Curseur_y < (Position_y+120))) then
        Couleur <= "1111";
        Dessin  <= '1';
    else
        Dessin  <= '0';
    end if;
    
    end Rectangle;
end Librairie_Perso;