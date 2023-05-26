-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Thu May 25 16:19:13 2023
-- Host        : LAPTOP-RHNTID5O running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top PLL_Clock -prefix
--               PLL_Clock_ PLL_Clock_stub.vhdl
-- Design      : PLL_Clock
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PLL_Clock is
  Port ( 
    clk_250MHz : out STD_LOGIC;
    clk_50MHZ : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_100MHz : in STD_LOGIC
  );

end PLL_Clock;

architecture stub of PLL_Clock is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_250MHz,clk_50MHZ,reset,locked,clk_100MHz";
begin
end;
