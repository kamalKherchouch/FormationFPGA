// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clock_VGA(clk_25MHz, reset, locked, clk_95MHz);
  output clk_25MHz;
  input reset;
  output locked;
  input clk_95MHz;
endmodule
