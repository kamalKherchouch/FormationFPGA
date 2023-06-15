library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Generateur_Pattern is
    port ( 
		clk   		: in std_logic;
        resetn		: in std_logic; 
		H_SYNCH			: out std_logic;
		V_SYNCH			: out std_logic;
		Rouge_Intensite : out std_logic_vector (3 downto 0);
		Vert_Intensite  : out std_logic_vector (3 downto 0);
		Bleu_Intensite  : out std_logic_vector (3 downto 0)
     );
end Generateur_Pattern;

architecture behavioral of Generateur_Pattern is
	
	-- Valeur des Reset du projet.
	signal activation_synchro : std_logic;
    Signal Locked_PLL_resetAuto : std_logic;
    
    -- On créer les signaux de positionnement (horizontal et vertical)
	signal Position_H   : integer range 0 to 799 := 0;
	signal Position_V   : integer range 0 to 524 := 0;
	
    -- Signal pour la clk_Vga
    Signal clk_Vga : std_logic;
    
	-- Composant PLL
	component clock_VGA
            port (
                clk_125MHz  : in std_logic;
                reset       : in std_logic;
                clk_25MHz   : out std_logic;
                locked      : out std_logic
            );
     end component;
        
	-- Composant Synchro
    component Synchro
	port ( 
		clk   		        : in std_logic;
        resetn		        : in std_logic; 
		H_SYNCH			    : out std_logic;
		V_SYNCH			    : out std_logic;
		Position_Horizontal	: out integer;
		Position_Vertical	: out integer
     );
    end component;
    
    -- Composant Pattern_VGA
    component Pattern_VGA
	port ( 
		clk   		    : in std_logic;
        resetn		    : in std_logic; 
		Position_H	    : in integer;
		Position_V	    : in integer;
		Rouge_Intensite : out std_logic_vector(3 downto 0);
		Vert_Intensite  : out std_logic_vector(3 downto 0);
		Bleu_Intensite  : out std_logic_vector(3 downto 0)
     );
    end component;
    
	begin
	
	--Affectation des signaux Pour le module Synchro
	clock_VGA0 : clock_VGA
        port map (
            clk_125MHz => clk,
            reset     => resetn,
            clk_25MHz => clk_Vga,
            locked    => Locked_PLL_resetAuto
        );
        
	--Affectation des signaux Pour le module Synchro
	Synchro0 : Synchro
        port map (
            clk                 => clk_Vga, 
            resetn              => activation_synchro,
            H_SYNCH             => H_SYNCH,
            V_SYNCH             => V_SYNCH,
            Position_Horizontal => Position_H,
            Position_Vertical   => Position_V
        );	
        
    --Affectation des signaux Pour le module Synchro
	Pattern_Damier : Pattern_VGA
        port map (
            clk             => clk_Vga, 
            resetn          => activation_synchro,
            Position_H      => Position_H,
            Position_V      => Position_V,
            Rouge_Intensite => Rouge_Intensite,
            Vert_Intensite  => Vert_Intensite,
            Bleu_Intensite  => Bleu_Intensite
        );
        
        process(Locked_PLL_resetAuto) 
		begin
		  if(Locked_PLL_resetAuto = '1') then
		      activation_synchro <= '0';
		  else
		      activation_synchro <= '1';
		  end if;
            
        end process;	
end behavioral;