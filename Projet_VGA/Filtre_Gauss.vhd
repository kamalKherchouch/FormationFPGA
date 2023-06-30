library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.std_logic_arith.all;


entity Filtre_Gauss is
    port ( 
		clk   		    : in std_logic;
        resetn		    : in std_logic; 
		Position_H	    : in integer;
		Position_V	    : in integer;
		Rouge_Intensite : in std_logic_vector(3 downto 0);
		Vert_Intensite  : in std_logic_vector(3 downto 0);
		Bleu_Intensite  : in std_logic_vector(3 downto 0);
		Rouge			: out std_logic_vector(3 downto 0);
		Vert			: out std_logic_vector(3 downto 0);
		Bleu			: out std_logic_vector(3 downto 0);
		H_SYNCH_filtre	: out std_logic;
		V_SYNCH_filtre  : out std_logic
     );
end Filtre_Gauss;

architecture behavioral of Filtre_Gauss is

    signal Out_Registre_Fifo1 : std_logic_vector(11 downto 0);
    signal Out_Registre_Fifo2 : std_logic_vector(11 downto 0);
    signal Compteur_Fifo : integer := 0;
    signal Concatenation_Couleur : std_logic_vector (11 downto 0);
    signal Convolution_Bleu : std_logic_vector (7 downto 0);
    signal Convolution_Vert : std_logic_vector (7 downto 0);
    signal Convolution_Rouge : std_logic_vector (7 downto 0);
    signal activation_ecriture_fifo_1 : std_logic := '0';
    signal activation_ecriture_fifo_2 : std_logic := '0';
    signal activation_lecture_fifo_1 : std_logic := '0';
    signal activation_lecture_fifo_2 : std_logic := '0';
    
    signal Position_H_filtre : integer range 0 to 799 := 0;
	signal Position_V_filtre : integer range 0 to 524 := 0;
	signal Video_active_filtre : std_logic;
    
    signal reset : std_logic;
    
	-- Kernel du filtre Gaussien
	
	-----------------------------------------
	--                                     --
	--     -----------------------------   --
	--     | K1 = 1  | K2 = 2 | K3 = 1 |   --
	--     | K4 = 2  | K5 = 4 | K6 = 2 |   --
	--     | K7 = 1  | K8 = 2 | K9 = 1 |   --
	--     -----------------------------   --
	--                                     --
	-----------------------------------------	
	
	constant K1 : std_logic_vector(3 downto 0) := "0001";
	constant K2 : std_logic_vector(3 downto 0) := "0010";
	constant K3 : std_logic_vector(3 downto 0) := "0001";
	constant K4 : std_logic_vector(3 downto 0) := "0010";
	constant K5 : std_logic_vector(3 downto 0) := "0100"; 
	constant K6 : std_logic_vector(3 downto 0) := "0010"; 
	constant K7 : std_logic_vector(3 downto 0) := "0001";
	constant K8 : std_logic_vector(3 downto 0) := "0010";
	constant K9 : std_logic_vector(3 downto 0) := "0001";

	signal Reg1 : std_logic_vector (11 downto 0) := (others => '0'); 
	signal Reg2 : std_logic_vector (11 downto 0) := (others => '0'); 
	signal Reg3 : std_logic_vector (11 downto 0) := (others => '0'); 
	signal Reg4 : std_logic_vector (11 downto 0) := (others => '0'); 
	signal Reg5 : std_logic_vector (11 downto 0) := (others => '0'); 
	signal Reg6 : std_logic_vector (11 downto 0) := (others => '0'); 
	signal Reg7 : std_logic_vector (11 downto 0) := (others => '0'); 
	signal Reg8 : std_logic_vector (11 downto 0) := (others => '0'); 
	signal Reg9 : std_logic_vector (11 downto 0) := (others => '0'); 
	
	-- Variable d'intensité de couleur
	signal Intensite_faible : std_logic_vector (3 downto 0) := "0000";
	signal Intensite_Haute  : std_logic_vector (3 downto 0) := "1111";
	
    
    -- Composant Fifo_Ligne1
	component Fifo_Ligne1
            port (
                clk   : in std_logic;
                srst  : in std_logic;
                din   : in std_logic_vector(11 downto 0);
                wr_en : in std_logic;
                rd_en : in std_logic;
                dout  : out std_logic_vector(11 downto 0);
                full  : out std_logic;
                empty : out std_logic
            );
        end component;
        
        -- Composant Fifo_Ligne2
	    component Fifo_Ligne2
            port (
                clk   : in std_logic;
                srst  : in std_logic;
                din   : in std_logic_vector(11 downto 0);
                wr_en : in std_logic;
                rd_en : in std_logic;
                dout  : out std_logic_vector(11 downto 0);
                full  : out std_logic;
                empty : out std_logic
            );
        end component;
        
	begin	
	
	   -- On concatene les couleurs rouge, vert et bleu dans le signal Concatenation_Couleur
	   Concatenation_Couleur <= Rouge_Intensite & Vert_Intensite & Bleu_Intensite;
	    
	    reset <= resetn;
	    
	    Fifo_1 : Fifo_Ligne1
            port map (
                clk => clk,
                srst => reset,
                din => reg3,
                wr_en => activation_ecriture_fifo_1,
                rd_en => activation_lecture_fifo_1,
                dout => Out_Registre_Fifo1
            );
            
        Fifo_2 : Fifo_Ligne2
            port map (
                clk => clk,
                srst => reset,
                din => reg6,
                wr_en => activation_ecriture_fifo_2,
                rd_en => activation_lecture_fifo_2,
                dout => Out_Registre_Fifo2
            );
        
        -- Process de mise à jours des signaux de synchronisation
        process(clk,resetn)
        begin
            if(resetn = '1') then
                 H_SYNCH_filtre      <= '0';
                 V_SYNCH_filtre      <= '0';
                 Position_H_filtre   <= 0;
                 Position_V_filtre   <= 0;
                 Video_active_filtre <= '0';
            elsif (rising_edge(clk)) then
            
                -- On met à jour les compteurs Position_H & Position_V en fonction du décallage généré par le filtre.
                if(Position_H = 2) then
                   Position_H_filtre <= 0;
                   Position_V_filtre <= 0;

                   if(Position_V_filtre < 524) then   -- avc 523 le pattern bouge, pk?
                       Position_V_filtre <= Position_V_filtre+1;
                   else
                       Position_V_filtre <= 0;
                   end if;
                else 
                   Position_H_filtre <= Position_H_filtre+1;   
                end if;
                
                -- On génére la "Pulse" à '0' sur le signal H_SYNCH_filtre.
                if (Position_H_filtre > 655 and Position_H_filtre < 751) then
                    H_SYNCH_filtre <= '0';
                    
                else
                    H_SYNCH_filtre <= '1';				
                end if;	
                    
                -- On génére la "Pulse" à '0' sur le signal V_SYNCH_filtrer.
                if (Position_V_filtre > 489 and Position_V_filtre < 492) then
                    V_SYNCH_filtre <= '0';
                else
                    V_SYNCH_filtre <= '1';				
                end if;  
                
                -- Gestion signal vidéo active après filtre
                if( Position_H_filtre < 640 and Position_V_filtre < 480) then 
                    Video_active_filtre <= '1';
                else
                    Video_active_filtre <= '0';
                end if;
            end if;	
		end process;
		    	
		process(clk,resetn)
        begin
            if(resetn = '1') then
                -- Si reset activé, on éteint tout.
                activation_ecriture_fifo_1 <= '0';
                activation_ecriture_fifo_2 <= '0';
                Reg1 <= (others => '0'); 
                Reg2 <= (others => '0'); 
                Reg3 <= (others => '0'); 
                Reg4 <= (others => '0'); 
                Reg5 <= (others => '0'); 
                Reg6 <= (others => '0'); 
                Reg7 <= (others => '0'); 
                Reg8 <= (others => '0'); 
                Reg9 <= (others => '0'); 
                activation_lecture_fifo_1 <= '0';
                activation_lecture_fifo_2 <= '0';
            elsif (rising_edge(clk)) then
                -- on active l'écriture de la Fifo 1 et de la Fifo 2 (on prends aussi en compte le temps que les pixels passent par les registre 1 à 6).
                Compteur_Fifo <= Compteur_Fifo+1;
                if (Compteur_Fifo = 3) then --2
                    activation_ecriture_fifo_1 <= '1';
                elsif (Compteur_Fifo = 800) then 
                    activation_lecture_fifo_1 <= '1';  
                elsif (Compteur_Fifo = 803) then
                    activation_ecriture_fifo_2 <= '1';
                elsif (Compteur_Fifo = 1600 ) then
                    activation_lecture_fifo_2 <= '1';
                end if;
 
                -- On remplit Registre et fifo
                reg1 <= Concatenation_Couleur;
                reg2 <= reg1;
                reg3 <= reg2;
                reg4 <= Out_Registre_Fifo1;
                reg5 <= reg4;
                reg6 <= reg5;
                reg7 <= Out_Registre_Fifo2;
                reg8 <= reg7;
                reg9 <= reg8;  
                                
			end if;	
		end process;
		
		process(clk,resetn)
        begin
            if(resetn = '1') then
                Convolution_Bleu  <= (others => '0');
                Convolution_Vert  <= (others => '0');
                Convolution_Rouge <= (others => '0');
                Rouge <= Intensite_faible;
                Vert  <= Intensite_faible;
                Bleu  <= Intensite_faible;
            elsif (rising_edge(clk)) then
                if(position_H < 640 and position_V < 240) then
                    --Compteur_Fifo <= Compteur_Fifo+1;
                    Convolution_Bleu  <= (reg1(3 downto 0)*k1) + (reg2(3 downto 0)*k2) + (reg3(3 downto 0)*k3) + (reg4(3 downto 0)*k4) + (reg5(3 downto 0)*k5) + (reg6(3 downto 0)*k6) + (reg7(3 downto 0)*k7) + (reg8(3 downto 0)*k8) + (reg9(3 downto 0)*k9);
                    Convolution_Vert  <= (reg1(7 downto 4)*k1) + (reg2(7 downto 4)*k2) + (reg3(7 downto 4)*k3) + (reg4(7 downto 4)*k4) + (reg5(7 downto 4)*k5) + (reg6(7 downto 4)*k6) + (reg7(7 downto 4)*k7) + (reg8(7 downto 4)*k8) + (reg9(7 downto 4)*k9);
                    Convolution_Rouge <= (reg1(11 downto 8)*k1) + (reg2(11 downto 8)*k2) + (reg3(11 downto 8)*k3) + (reg4(11 downto 8)*k4) + (reg5(11 downto 8)*k5) + (reg6(11 downto 8)*k6) + (reg7(11 downto 8)*k7) + (reg8(11 downto 8)*k8) + (reg9(11 downto 8)*k9);
                    Bleu  <= Convolution_Bleu(7 downto 4);
                    Vert  <= Convolution_Vert(7 downto 4);
                    Rouge <= Convolution_Rouge(7 downto 4);
                elsif(position_H < 640 and position_V < 480) then
                    Bleu  <= reg5(3 downto 0);
                    Vert  <= reg5(7 downto 4);
                    Rouge <= reg5(11 downto 8);
                else
                    Rouge <= Intensite_faible;
                    Vert  <= Intensite_faible;
                    Bleu  <= Intensite_faible;
                end if;
          end if;
		end process;
		   
end behavioral;