-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Mon Jun 12 14:54:20 2023
-- Host        : DESKTOP-AD02GFS running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/utilisateur/Documents/TP/Projet VGA/Code
--               VHDL/Generateur_Pattern/Generateur_Pattern/Generateur_Pattern.gen/sources_1/ip/clock_VGA/clock_VGA_stub.vhdl}
-- Design      : clock_VGA
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_VGA is
  Port ( 
    clk_25MHz : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_125MHz : in STD_LOGIC
  );

end clock_VGA;

architecture stub of clock_VGA is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_25MHz,reset,locked,clk_125MHz";
begin
end;
