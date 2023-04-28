library ieee;
use ieee.std_logic_1164.all;


entity full_adder is

	Port ( 
		-- Entrées du Full_Adder
		A 	: in std_logic;
		B	: in std_logic;
		Cin : in std_logic;
		
		-- Sorties du Full_Adder
		S	: out std_logic;
		Cout	: out std_logic
	);

end full_adder;

 

architecture behavior of full_adder is
 
begin

    S <= A XOR B XOR Cin;  -- Description de l'équation logique de la sortie S.
	Cout <= (Cin AND (A OR B)) OR (A AND B); -- Description de l'équation logique de la sortie Cout.

end behavior;

