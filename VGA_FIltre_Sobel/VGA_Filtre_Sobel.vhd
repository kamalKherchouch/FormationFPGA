library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.conv_std_logic_vector;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity VGA_filtre_Sobel is
	generic(
		PX_SIZE : integer := 8;        -- taille d'un pixel
		Seuil_Sobel : integer := 600   -- 850 pour le calcul ss racine et 600 pour la version avc racine
	);
	port(
		resetn	: in std_logic;
		clk		: in std_logic;
		input_data	        : in std_logic_vector(PX_SIZE-1 downto 0);
		input_data_valid	: in std_logic;
		output_data	        : out std_logic_vector(PX_SIZE-1 downto 0);
		output_data_valid	: out std_logic
	);
end VGA_filtre_Sobel;


architecture behavioral of VGA_filtre_Sobel is
    
    -- Signal pour inverser le reset.
    signal reset : std_logic;
    
    -- Permet de faire le calcul du produit de convolution du filtre de Gauss
    signal Calcule_Gauss : std_logic_vector (15 downto 0);
    signal Calcule_Sobel_H_Nat : natural;
    signal Calcule_Sobel_V_Nat : natural;
    signal Calcule_Sobel_H_Vect : std_logic_vector (11 downto 0);
    signal Calcule_Sobel_V_Vect : std_logic_vector (11 downto 0);
    signal Calcule_Gradiant_Sobel_real : real;
    signal Calcule_Gradiant_Sobel_Nat : natural;
    signal Calcule_Gradiant_Sobel_vector : std_logic_vector (7 downto 0);
    signal Calcule_Gradiant_Sobel_Nat_to_Vect : std_logic_vector (7 downto 0);
    
    
    -- Différents compteur
    signal Compteur_delay_Fifo : integer := 0;
    signal Compteur_projet : integer := 0;
    
    -- Signal permettant d'activer / désactiver l'écriture des FIFOs
    signal activation_ecriture_fifo_1 : std_logic := '0';
    signal activation_ecriture_fifo_2 : std_logic := '0';
    
    -- Signal permettant d'activer / désactiver la lecture des FIFOs
    signal activation_lecture_fifo_1 : std_logic := '0';
    signal activation_lecture_fifo_2 : std_logic := '0';
    
    -- Signal de sortie des FIFOs
    signal Out_Registre_Fifo1 : std_logic_vector(7 downto 0);
    signal Out_Registre_Fifo2 : std_logic_vector(7 downto 0);
    
    -- Registre utiles aux calcules des convolutions
    signal Reg1 : std_logic_vector (7 downto 0) := (others => '0'); 
	signal Reg2 : std_logic_vector (7 downto 0) := (others => '0'); 
	signal Reg3 : std_logic_vector (7 downto 0) := (others => '0'); 
	signal Reg4 : std_logic_vector (7 downto 0) := (others => '0'); 
	signal Reg5 : std_logic_vector (7 downto 0) := (others => '0'); 
	signal Reg6 : std_logic_vector (7 downto 0) := (others => '0'); 
	signal Reg7 : std_logic_vector (7 downto 0) := (others => '0'); 
	signal Reg8 : std_logic_vector (7 downto 0) := (others => '0'); 
	signal Reg9 : std_logic_vector (7 downto 0) := (others => '0');
	
	-- Kernel du filtre de Sobel
	--------------------------------------------
	--      Kernel en H du filtre de Gauss    --
	--     -------------------------------    --
	--     | K1 =  1  | K2 =  2 | K3 =  1 |   --
	--     | K4 =  2  | K5 =  4 | K6 =  2 |   --
	--     | K7 =  1  | K8 =  2 | K9 =  1 |   --
	--     -------------------------------    --
	--------------------------------------------
	--      Kernel en H du filtre de Sobel    --
	--     -------------------------------    --
	--     | K1 = -1  | K2 =  0 | K3 =  1 |   --
	--     | K4 = -2  | K5 =  0 | K6 =  2 |   --
	--     | K7 = -1  | K8 =  0 | K9 =  1 |   --
	--     -------------------------------    --
	--------------------------------------------
	--      Kernel en V du filtre de Sobel    --
	--     -------------------------------    --
	--     | K1 =  1  | K2 =  2 | K3 =  1 |   --
	--     | K4 =  0  | K5 =  0 | K6 =  0 |   --
	--     | K7 = -1  | K8 = -2 | K9 = -1 |   --
	--     -------------------------------    --
	--------------------------------------------	
	
	constant K1_Gauss : std_logic_vector(7 downto 0) := "00000001";
	constant K2_Gauss : std_logic_vector(7 downto 0) := "00000010";
	constant K3_Gauss : std_logic_vector(7 downto 0) := "00000001";
	constant K4_Gauss : std_logic_vector(7 downto 0) := "00000010";
	constant K5_Gauss : std_logic_vector(7 downto 0) := "00000100"; 
	constant K6_Gauss : std_logic_vector(7 downto 0) := "00000010"; 
	constant K7_Gauss : std_logic_vector(7 downto 0) := "00000001";
	constant K8_Gauss : std_logic_vector(7 downto 0) := "00000010";
	constant K9_Gauss : std_logic_vector(7 downto 0) := "00000001";
	
	constant K1_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(-1,4);
	constant K2_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(0,4);
	constant K3_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(1,4);
	constant K4_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(-2,4);
	constant K5_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(0,4); 
	constant K6_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(2,4); 
	constant K7_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(-1,4);
	constant K8_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(0,4);
	constant K9_H : std_logic_vector(3 downto 0) := conv_std_logic_vector(1,4);
	
	constant K1_H_Nat : integer := -1;
	constant K2_H_Nat : integer := 0;
	constant K3_H_Nat : integer := 1;
	constant K4_H_Nat : integer := -2;
	constant K5_H_Nat : integer := 0;
	constant K6_H_Nat : integer := 2;
	constant K7_H_Nat : integer := -1;
	constant K8_H_Nat : integer := 0;
	constant K9_H_Nat : integer := 1;
	
	constant K1_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(1,4);
	constant K2_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(2,4);
	constant K3_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(1,4);
	constant K4_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(0,4);
	constant K5_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(0,4); 
	constant K6_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(0,4); 
	constant K7_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(-1,4);
	constant K8_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(-2,4);
	constant K9_V : std_logic_vector(3 downto 0) := conv_std_logic_vector(-1,4);
	
	constant K1_V_Nat : integer := 1;
	constant K2_V_Nat : integer := 2;
	constant K3_V_Nat : integer := 1;
	constant K4_V_Nat : integer := 0;
	constant K5_V_Nat : integer := 0;
	constant K6_V_Nat : integer := 0;
	constant K7_V_Nat : integer := -1;
	constant K8_V_Nat : integer := -2;
	constant K9_V_Nat : integer := -1;
    
    -- Composant Fifo_Ligne1
	component Fifo_ligne_1
	   port (
	       clk   : in std_logic;
           srst  : in std_logic;
           din   : in std_logic_vector(7 downto 0);
           wr_en : in std_logic;
           rd_en : in std_logic;
           dout  : out std_logic_vector(7 downto 0);
           full  : out std_logic;
           empty : out std_logic
	   );
	end component;

    -- Composant Fifo_Ligne2
	component Fifo_ligne_2
	   port (
	       clk   : in std_logic;
           srst  : in std_logic;
           din   : in std_logic_vector(7 downto 0);
           wr_en : in std_logic;
           rd_en : in std_logic;
           dout  : out std_logic_vector(7 downto 0);
           full  : out std_logic;
           empty : out std_logic
	   );
	end component;

        
begin
    -- Inversion du signal reset pour l'utilisation des FIFOs
    reset <= resetn;
    
    -- Affectation des signaux pour l'utilisation de la FIFO 1
    Fifo_L1 : Fifo_ligne_1
        port map (
            clk => clk,
            srst => reset,
            din => reg3,
            wr_en => activation_ecriture_fifo_1,
            rd_en => activation_lecture_fifo_1,
            dout => Out_Registre_Fifo1
        );
    
    -- Affectation des signaux pour l'utilisation de la FIFO 2       
    Fifo_L2 : Fifo_ligne_2
        port map (
            clk => clk,
            srst => reset,
            din => reg6,
            wr_en => activation_ecriture_fifo_2,
            rd_en => activation_lecture_fifo_2,
            dout => Out_Registre_Fifo2
        );
    
-- ######## Process du passe plat... ######## --  
--	process(clk, resetn)
--	begin
--		if(resetn='1') then
--			output_data <= (others => '0');
--			output_data_valid <= '0';
--		elsif(rising_edge(clk)) then 
--		    if(input_data_valid = '1') then
--			   output_data <= input_data;
--			   output_data_valid <= '1';
--			end if;
--		end if;
--	end process;
-- ########################################## --  

-- ######## Process du Sliding Window without synchro update ######## -- 
--	process(clk, resetn)
--	begin
--		if(resetn='1') then
--			output_data <= (others => '0');
--			output_data_valid <= '0';
--			activation_ecriture_fifo_1 <= '0';
--            activation_ecriture_fifo_2 <= '0';
--            Reg1 <= (others => '0'); 
--            Reg2 <= (others => '0'); 
--            Reg3 <= (others => '0'); 
--            Reg4 <= (others => '0'); 
--            Reg5 <= (others => '0'); 
--            Reg6 <= (others => '0'); 
--            Reg7 <= (others => '0'); 
--            Reg8 <= (others => '0'); 
--            Reg9 <= (others => '0'); 
--            activation_lecture_fifo_1 <= '0';
--            activation_lecture_fifo_2 <= '0';
--		elsif(rising_edge(clk)) then 
--		    if(input_data_valid = '1') then
		    
--		       Compteur_projet <= Compteur_projet+1;
--               if (Compteur_projet = 3) then 
--                   activation_ecriture_fifo_1 <= '1';
--               elsif (Compteur_projet = 640) then 
--                   activation_lecture_fifo_1 <= '1';  
--               elsif (Compteur_projet = 643) then
--                   activation_ecriture_fifo_2 <= '1';
--               elsif (Compteur_projet = 1280 ) then
--                   activation_lecture_fifo_2 <= '1';
--               end if;
               
--               -- On remplit Registre et fifo
--               reg1 <= input_data;
--               reg2 <= reg1;
--               reg3 <= reg2;
--               reg4 <= Out_Registre_Fifo1;
--               reg5 <= reg4;
--               reg6 <= reg5;
--               reg7 <= Out_Registre_Fifo2;
--               reg8 <= reg7;
--               reg9 <= reg8;
                
--			   output_data <= reg5;
--			   output_data_valid <= '1';
--			end if;
--		end if;
--	end process;
-- ################################################################## -- 

-- ######## Process du Sliding Window with synchro update ######## --
--	process(clk, resetn)
--	begin
--		if(resetn='1') then
--			output_data <= (others => '0');
--			output_data_valid <= '0';
--			activation_ecriture_fifo_1 <= '0';
--            activation_ecriture_fifo_2 <= '0';
--            Reg1 <= (others => '0'); 
--            Reg2 <= (others => '0'); 
--            Reg3 <= (others => '0'); 
--            Reg4 <= (others => '0'); 
--            Reg5 <= (others => '0'); 
--            Reg6 <= (others => '0'); 
--            Reg7 <= (others => '0'); 
--            Reg8 <= (others => '0'); 
--            Reg9 <= (others => '0'); 
--            activation_lecture_fifo_1 <= '0';
--            activation_lecture_fifo_2 <= '0';
--            Calcule_Gauss <= (others => '0');
--		elsif(rising_edge(clk)) then 
--		    if(input_data_valid = '1') then
		    
--		       Compteur_projet <= Compteur_projet+1;
--               if (Compteur_projet = 3) then 
--                   activation_ecriture_fifo_1 <= '1';
--               elsif (Compteur_projet = 640) then 
--                   activation_lecture_fifo_1 <= '1';  
--               elsif (Compteur_projet = 643) then
--                   activation_ecriture_fifo_2 <= '1';
--               elsif (Compteur_projet = 1280 ) then
--                   activation_lecture_fifo_2 <= '1';
--               end if;
               
--               -- On remplit Registre et fifo
--               reg1 <= input_data;
--               reg2 <= reg1;
--               reg3 <= reg2;
--               reg4 <= Out_Registre_Fifo1;
--               reg5 <= reg4;
--               reg6 <= reg5;
--               reg7 <= Out_Registre_Fifo2;
--               reg8 <= reg7;
--               reg9 <= reg8;			   
			  
--               if(Compteur_projet > 643) then 
--                   output_data <= reg5;
--                   output_data_valid <= '1';
--               else
--                   output_data_valid <= '0';
--			   end if;
--			end if;
--		end if;
--	end process;
-- ############################################################### --

-- ######## Process avec signaux update et filtre de Gauss ######## --
--	process(clk, resetn)
--	begin
--		if(resetn='1') then
--			output_data <= (others => '0');
--			output_data_valid <= '0';
--			activation_ecriture_fifo_1 <= '0';
--            activation_ecriture_fifo_2 <= '0';
--            Reg1 <= (others => '0'); 
--            Reg2 <= (others => '0'); 
--            Reg3 <= (others => '0'); 
--            Reg4 <= (others => '0'); 
--            Reg5 <= (others => '0'); 
--            Reg6 <= (others => '0'); 
--            Reg7 <= (others => '0'); 
--            Reg8 <= (others => '0'); 
--            Reg9 <= (others => '0'); 
--            activation_lecture_fifo_1 <= '0';
--            activation_lecture_fifo_2 <= '0';
--            Calcule_Gauss <= (others => '0');
--		elsif(rising_edge(clk)) then 
--		    if(input_data_valid = '1') then
		    
--		       Compteur_projet <= Compteur_projet+1;
--               if (Compteur_projet = 3) then 
--                   activation_ecriture_fifo_1 <= '1';
--               elsif (Compteur_projet = 640) then 
--                   activation_lecture_fifo_1 <= '1';  
--               elsif (Compteur_projet = 643) then
--                   activation_ecriture_fifo_2 <= '1';
--               elsif (Compteur_projet = 1280 ) then
--                   activation_lecture_fifo_2 <= '1';
--               end if;
               
--               -- On remplit Registre et fifo
--               reg1 <= input_data;
--               reg2 <= reg1;
--               reg3 <= reg2;
--               reg4 <= Out_Registre_Fifo1;
--               reg5 <= reg4;
--               reg6 <= reg5;
--               reg7 <= Out_Registre_Fifo2;
--               reg8 <= reg7;
--               reg9 <= reg8;			   
			  
--               if(Compteur_projet > 643) then
--                   Calcule_Gauss <= (reg1*K1_Gauss) + (reg2*K2_Gauss) + (reg3*K3_Gauss) + (reg4*K4_Gauss) + (reg5*K5_Gauss) + (reg6*K6_Gauss) + (reg7*K7_Gauss) + (reg8*K8_Gauss) + (reg9*K9_Gauss);        
--                   output_data <= Calcule_Gauss(15 downto 8);
--                   output_data_valid <= '1';
--               else
--                   output_data_valid <= '0';
--			   end if;
--			end if;
--		end if;
--	end process;
-- ################################################################ --

-- ################# Process filtre de Sobel en H ################# --
--	process(clk, resetn)
--	begin
--		if(resetn='1') then
--			output_data <= (others => '0');
--			output_data_valid <= '0';
--			activation_ecriture_fifo_1 <= '0';
--            activation_ecriture_fifo_2 <= '0';
--            Reg1 <= (others => '0'); 
--            Reg2 <= (others => '0'); 
--            Reg3 <= (others => '0'); 
--            Reg4 <= (others => '0'); 
--            Reg5 <= (others => '0'); 
--            Reg6 <= (others => '0'); 
--            Reg7 <= (others => '0'); 
--            Reg8 <= (others => '0'); 
--            Reg9 <= (others => '0'); 
--            activation_lecture_fifo_1 <= '0';
--            activation_lecture_fifo_2 <= '0';
--            Calcule_Sobel_H_Nat <= 0;
--		elsif(rising_edge(clk)) then 
--		    if(input_data_valid = '1') then
		    
--		       Compteur_projet <= Compteur_projet+1;
--               if (Compteur_projet = 3) then 
--                   activation_ecriture_fifo_1 <= '1';
--               elsif (Compteur_projet = 640) then 
--                   activation_lecture_fifo_1 <= '1';  
--               elsif (Compteur_projet = 643) then
--                   activation_ecriture_fifo_2 <= '1';
--               elsif (Compteur_projet = 1280 ) then
--                   activation_lecture_fifo_2 <= '1';
--               end if;
               
--               -- On remplit Registre et fifo
--               reg1 <= input_data;
--               reg2 <= reg1;
--               reg3 <= reg2;
--               reg4 <= Out_Registre_Fifo1;
--               reg5 <= reg4;
--               reg6 <= reg5;
--               reg7 <= Out_Registre_Fifo2;
--               reg8 <= reg7;
--               reg9 <= reg8;			   
			  
--               if(Compteur_projet > 643) then
--                   Calcule_Sobel_H_Nat <= to_integer(signed(reg1))*K1_H_Nat + to_integer(signed(reg2))*K2_H_Nat + to_integer(signed(reg3))*K3_H_Nat + to_integer(signed(reg4))*K4_H_Nat + to_integer(signed(reg5))*K5_H_Nat + to_integer(signed(reg6))*K6_H_Nat + to_integer(signed(reg7))*K7_H_Nat + to_integer(signed(reg8))*K8_H_Nat + to_integer(signed(reg9))*K9_H_Nat ;
--                   output_data <= std_logic_vector(to_unsigned(integer(Calcule_Sobel_H_Nat), 8));
--                   output_data_valid <= '1';
--               else
--                   output_data_valid <= '0';
--			   end if;
--			end if;
--		end if;
--	end process;
-- ################################################################ --

-- ################# Process filtre de Sobel en V ################# --
--	process(clk, resetn)
--	begin
--		if(resetn='1') then
--			output_data <= (others => '0');
--			output_data_valid <= '0';
--			activation_ecriture_fifo_1 <= '0';
--            activation_ecriture_fifo_2 <= '0';
--            Reg1 <= (others => '0'); 
--            Reg2 <= (others => '0'); 
--            Reg3 <= (others => '0'); 
--            Reg4 <= (others => '0'); 
--            Reg5 <= (others => '0'); 
--            Reg6 <= (others => '0'); 
--            Reg7 <= (others => '0'); 
--            Reg8 <= (others => '0'); 
--            Reg9 <= (others => '0'); 
--            activation_lecture_fifo_1 <= '0';
--            activation_lecture_fifo_2 <= '0';
--            Calcule_Sobel_V_Nat <= 0;
--		elsif(rising_edge(clk)) then 
--		    if(input_data_valid = '1') then
		    
--		       Compteur_projet <= Compteur_projet+1;
--               if (Compteur_projet = 3) then 
--                   activation_ecriture_fifo_1 <= '1';
--               elsif (Compteur_projet = 640) then 
--                   activation_lecture_fifo_1 <= '1';  
--               elsif (Compteur_projet = 643) then
--                   activation_ecriture_fifo_2 <= '1';
--               elsif (Compteur_projet = 1280 ) then
--                   activation_lecture_fifo_2 <= '1';
--               end if;
               
--               -- On remplit Registre et fifo
--               reg1 <= input_data;
--               reg2 <= reg1;
--               reg3 <= reg2;
--               reg4 <= Out_Registre_Fifo1;
--               reg5 <= reg4;
--               reg6 <= reg5;
--               reg7 <= Out_Registre_Fifo2;
--               reg8 <= reg7;
--               reg9 <= reg8;			   
			  
--               if(Compteur_projet > 643) then
--                   Calcule_Sobel_V_Nat <= to_integer(signed(reg1))*K1_V_Nat + to_integer(signed(reg2))*K2_V_Nat + to_integer(signed(reg3))*K3_V_Nat + to_integer(signed(reg4))*K4_V_Nat + to_integer(signed(reg5))*K5_V_Nat + to_integer(signed(reg6))*K6_V_Nat + to_integer(signed(reg7))*K7_V_Nat + to_integer(signed(reg8))*K8_V_Nat + to_integer(signed(reg9))*K9_V_Nat ;
--                   output_data <= std_logic_vector(to_unsigned(integer(Calcule_Sobel_V_Nat), 8));
--                   --output_data <= std_logic_vector(to_signed((to_integer(signed(Calcule_Sobel_V))/4),8));
--                   output_data_valid <= '1';
--               else
--                   output_data_valid <= '0';
--			   end if;
--			end if;
--		end if;
--	end process;
-- ################################################################ --

-- ############### Process filtre de Sobel en H etV ############### --
	process(clk, resetn)
	begin
		if(resetn='1') then
			output_data <= (others => '0');
			output_data_valid <= '0';
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
            --Calcule_Sobel_H_Vect <= (others => '0');
            Calcule_Sobel_H_Nat <= 0;
            --Calcule_Sobel_V_Vect <= (others => '0');
            Calcule_Sobel_V_Nat <= 0;
            --Calcule_Gradiant_Sobel_real <= 0.0;
            Calcule_Gradiant_Sobel_Nat <= 0;
            --Calcule_Gradiant_Sobel_vector <= (others => '0');
            --Calcule_Gradiant_Sobel_Nat_to_Vect <= (others => '0');
		elsif(rising_edge(clk)) then 
		    if(input_data_valid = '1') then
		    
		       Compteur_projet <= Compteur_projet+1;
               if (Compteur_projet = 3) then 
                   activation_ecriture_fifo_1 <= '1';
               elsif (Compteur_projet = 640) then 
                   activation_lecture_fifo_1 <= '1';  
               elsif (Compteur_projet = 643) then
                   activation_ecriture_fifo_2 <= '1';
               elsif (Compteur_projet = 1280 ) then
                   activation_lecture_fifo_2 <= '1';
               end if;
               
               -- On remplit Registre et fifo
               reg1 <= input_data;
               reg2 <= reg1;
               reg3 <= reg2;
               reg4 <= Out_Registre_Fifo1;
               reg5 <= reg4;
               reg6 <= reg5;
               reg7 <= Out_Registre_Fifo2;
               reg8 <= reg7;
               reg9 <= reg8;			   
			  
               if(Compteur_projet > 642) then
                   --Calcule_Sobel_H_Vect <= (reg1*K1_H) + (reg2*K2_H) + (reg3*K3_H) + (reg4*K4_H) + (reg5*K5_H) + (reg6*K6_H) + (reg7*K7_H) + (reg8*K8_H) + (reg9*K9_H);        
                   Calcule_Sobel_H_Nat <= to_integer(signed(reg1))*K1_H_Nat + to_integer(signed(reg2))*K2_H_Nat + to_integer(signed(reg3))*K3_H_Nat + to_integer(signed(reg4))*K4_H_Nat + to_integer(signed(reg5))*K5_H_Nat + to_integer(signed(reg6))*K6_H_Nat + to_integer(signed(reg7))*K7_H_Nat + to_integer(signed(reg8))*K8_H_Nat + to_integer(signed(reg9))*K9_H_Nat ;
                   
                   --Calcule_Sobel_V_Vect <= (reg1*K1_V) + (reg2*K2_V) + (reg3*K3_V) + (reg4*K4_V) + (reg5*K5_V) + (reg6*K6_V) + (reg7*K7_V) + (reg8*K8_V) + (reg9*K9_V);        
                   Calcule_Sobel_V_Nat <= to_integer(signed(reg1))*K1_V_Nat + to_integer(signed(reg2))*K2_V_Nat + to_integer(signed(reg3))*K3_V_Nat + to_integer(signed(reg4))*K4_V_Nat + to_integer(signed(reg5))*K5_V_Nat + to_integer(signed(reg6))*K6_V_Nat + to_integer(signed(reg7))*K7_V_Nat + to_integer(signed(reg8))*K8_V_Nat + to_integer(signed(reg9))*K9_V_Nat ;
                   
                   --Calcule_Gradiant_Sobel_real <= SQRT((real(to_integer(signed(Calcule_Sobel_H_Vect)))*real(to_integer(signed(Calcule_Sobel_H_Vect)))) + (real(to_integer(signed(Calcule_Sobel_V_Vect)))*real(to_integer(signed(Calcule_Sobel_V_Vect)))));
                   Calcule_Gradiant_Sobel_Nat <= abs(Calcule_Sobel_H_Nat) + abs(Calcule_Sobel_V_Nat);
                   --Calcule_Gradiant_Sobel_Nat <= integer(SQRT(real(Calcule_Sobel_H_Nat)*real(Calcule_Sobel_H_Nat) + real(Calcule_Sobel_V_Nat)*real(Calcule_Sobel_V_Nat)));
                   
                   --Calcule_Gradiant_Sobel_vector <= std_logic_vector(to_unsigned(integer(Calcule_Gradiant_Sobel_real), 8));
                   --Calcule_Gradiant_Sobel_Nat_to_Vect <= std_logic_vector(to_unsigned(integer(Calcule_Gradiant_Sobel_Nat), 8));
                   
                   if(Calcule_Gradiant_Sobel_Nat > Seuil_Sobel) then
                        output_data <= (others => '1');
                   else
                        output_data <= (others => '0');
                        --output_data <= reg5;
                   end if;
                   output_data_valid <= '1';
               else
                   output_data_valid <= '0';
			   end if;
			end if;
		end if;
	end process;
-- ################################################################ --

--	process(clk, resetn)
--	begin
--		if(resetn='1') then
--			output_data <= (others => '0');
--			output_data_valid <= '0';
--			activation_ecriture_fifo_1 <= '0';
--            activation_ecriture_fifo_2 <= '0';
--            Reg1 <= (others => '0'); 
--            Reg2 <= (others => '0'); 
--            Reg3 <= (others => '0'); 
--            Reg4 <= (others => '0'); 
--            Reg5 <= (others => '0'); 
--            Reg6 <= (others => '0'); 
--            Reg7 <= (others => '0'); 
--            Reg8 <= (others => '0'); 
--            Reg9 <= (others => '0'); 
--            activation_lecture_fifo_1 <= '0';
--            activation_lecture_fifo_2 <= '0';
--            Calcule_Gauss <= (others => '0');
--            Compteur_projet <= 0;
--		elsif(rising_edge(clk)) then 
--		    if(input_data_valid = '1') then
		    
--		       Compteur_projet <= Compteur_projet+1;
		       
--               if (Compteur_projet = 3) then 
--                   activation_ecriture_fifo_1 <= '1';
--               elsif (Compteur_projet = 640) then 
--                   activation_lecture_fifo_1 <= '1';  
--               elsif (Compteur_projet = 643) then
--                   activation_ecriture_fifo_2 <= '1';
--               elsif (Compteur_projet = 1280 ) then
--                   activation_lecture_fifo_2 <= '1';
--               end if;
               
--               -- On remplit Registre et fifo
--               reg1 <= input_data;
--               reg2 <= reg1;
--               reg3 <= reg2;
--               reg4 <= Out_Registre_Fifo1;
--               reg5 <= reg4;
--               reg6 <= reg5;
--               reg7 <= Out_Registre_Fifo2;
--               reg8 <= reg7;
--               reg9 <= reg8;			   
			  
--               if(Compteur_projet > 643) then
--                   Calcule_Gauss <= (reg1*K1_Gauss) + (reg2*K2_Gauss) + (reg3*K3_Gauss) + (reg4*K4_Gauss) + (reg5*K5_Gauss) + (reg6*K6_Gauss) + (reg7*K7_Gauss) + (reg8*K8_Gauss) + (reg9*K9_Gauss);        
--			   end if;
			   
--			   if(Compteur_projet > 643) then
                   
--                   if (Compteur_projet mod 2 = 1) then
--                       output_data <= Calcule_Gauss(15 downto 8);
--                       output_data_valid <= '1';
--                    else
--                        output_data_valid <= '0';
--                   end if;
--			   end if;
--			end if;
--		end if;
--	end process;

end architecture;