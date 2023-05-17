library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity PilotageLED_Avec_Module_LedDriver is
    port ( 
		clk			: in std_logic; 
        resetn		: in std_logic; 
        Bouton_Color_Code   : in std_logic; 
		Buton_Update        : in std_logic; 
		LED_Output          : out std_logic_vector (2 downto 0)
     );
end PilotageLED_Avec_Module_LedDriver;

architecture behavioral of PilotageLED_Avec_Module_LedDriver is
    
    signal Color_Code  : std_logic_Vector (1 downto 0); 
    signal Update      : std_logic;
    signal End_Counter  : std_logic;
    
    -- Signaux pour la gestion du Bouton_0
    signal Update_Registre1 : std_logic;
    signal Update_Registre2 : std_logic;
    
    -- Signaux la gestion des Codes Couleurs 
    Signal Code_Rouge   : std_logic_Vector (1 downto 0) := "01";
    Signal Code_Vert    : std_logic_Vector (1 downto 0) := "10"; 
    Signal Code_Bleu    : std_logic_Vector (1 downto 0) := "11";
    Signal Code_Eteint  : std_logic_Vector (1 downto 0) := "00";
    	
	-- Composant LedDriver
    component LedDriver 
		port ( 
		clk			: in std_logic; 
        resetn		: in std_logic; 
        Color_Code  : in std_logic_Vector (1 downto 0); 
		Update      : in std_logic; 
		LED_Output  : out std_logic_vector (2 downto 0)
     );
    end component;
	
	begin
    --Affectation des signaux du testbench avec ceux de l'entite a tester
	Compteur : LedDriver
        port map (
            clk => clk, 
            resetn => resetn,
            Color_Code => Color_Code,
            Update => Update,
            LED_Output => LED_Output
        );
		
		-- ** Début de processe Gestion du signal Update ** --
        process(resetn, clk) 
        begin
            if(resetn = '0') then
                -- On réinitialise les registres
                Update_Registre1 <= '0';
                Update_Registre2 <= '0';
                Color_Code <= Code_Eteint;
            elsif(rising_edge(clk)) then
                Update_Registre1 <= Buton_Update;
                Update_Registre2 <= Update_Registre1;
                
                if(Bouton_Color_Code = '0') then
                    Color_Code <= Code_Bleu; 
                else
                    Color_Code <= Code_Vert;
                end if;
                
            end if;
        end process;
        -- ** Fin de processe Gestion du signal Update ** --
        -- ** Partie combinatoire du processe Gestion du signal Update ** --
        Update <= Buton_Update and not(Update_Registre2);
        -- ** Fin Partie combinatoire du processe Gestion du signal Update ** --
    
end behavioral;