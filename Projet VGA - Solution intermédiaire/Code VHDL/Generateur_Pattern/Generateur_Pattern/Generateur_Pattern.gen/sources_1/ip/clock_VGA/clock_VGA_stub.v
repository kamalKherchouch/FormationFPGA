// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Jun 12 14:54:20 2023
// Host        : DESKTOP-AD02GFS running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/utilisateur/Documents/TP/Projet VGA/Code
//               VHDL/Generateur_Pattern/Generateur_Pattern/Generateur_Pattern.gen/sources_1/ip/clock_VGA/clock_VGA_stub.v}
// Design      : clock_VGA
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clock_VGA(clk_25MHz, reset, locked, clk_125MHz)
/* synthesis syn_black_box black_box_pad_pin="clk_25MHz,reset,locked,clk_125MHz" */;
  output clk_25MHz;
  input reset;
  output locked;
  input clk_125MHz;
endmodule
