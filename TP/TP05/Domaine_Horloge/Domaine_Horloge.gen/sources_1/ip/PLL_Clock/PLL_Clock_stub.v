// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Thu May 25 16:19:13 2023
// Host        : LAPTOP-RHNTID5O running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top PLL_Clock -prefix
//               PLL_Clock_ PLL_Clock_stub.v
// Design      : PLL_Clock
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module PLL_Clock(clk_250MHz, clk_50MHZ, reset, locked, clk_100MHz)
/* synthesis syn_black_box black_box_pad_pin="clk_250MHz,clk_50MHZ,reset,locked,clk_100MHz" */;
  output clk_250MHz;
  output clk_50MHZ;
  input reset;
  output locked;
  input clk_100MHz;
endmodule
