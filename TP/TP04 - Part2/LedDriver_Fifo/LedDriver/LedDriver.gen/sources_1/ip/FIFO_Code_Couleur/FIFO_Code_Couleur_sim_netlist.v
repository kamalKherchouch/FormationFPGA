// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon May 22 15:08:12 2023
// Host        : DESKTOP-AD02GFS running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {c:/Users/utilisateur/Documents/TP/TP04 -
//               Part2/LedDriver_Fifo/LedDriver/LedDriver.gen/sources_1/ip/FIFO_Code_Couleur/FIFO_Code_Couleur_sim_netlist.v}
// Design      : FIFO_Code_Couleur
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "FIFO_Code_Couleur,fifo_generator_v13_2_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v13_2_5,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module FIFO_Code_Couleur
   (clk,
    rst,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty,
    wr_rst_busy,
    rd_rst_busy);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 core_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME core_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input clk;
  input rst;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *) input [1:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *) output [1:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;
  output wr_rst_busy;
  output rd_rst_busy;

  wire clk;
  wire [1:0]din;
  wire [1:0]dout;
  wire empty;
  wire full;
  wire rd_en;
  wire rd_rst_busy;
  wire rst;
  wire wr_en;
  wire wr_rst_busy;
  wire NLW_U0_almost_empty_UNCONNECTED;
  wire NLW_U0_almost_full_UNCONNECTED;
  wire NLW_U0_axi_ar_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_overflow_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_full_UNCONNECTED;
  wire NLW_U0_axi_ar_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_underflow_UNCONNECTED;
  wire NLW_U0_axi_aw_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_overflow_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_full_UNCONNECTED;
  wire NLW_U0_axi_aw_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_underflow_UNCONNECTED;
  wire NLW_U0_axi_b_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_overflow_UNCONNECTED;
  wire NLW_U0_axi_b_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_b_prog_full_UNCONNECTED;
  wire NLW_U0_axi_b_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_underflow_UNCONNECTED;
  wire NLW_U0_axi_r_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_overflow_UNCONNECTED;
  wire NLW_U0_axi_r_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_r_prog_full_UNCONNECTED;
  wire NLW_U0_axi_r_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_underflow_UNCONNECTED;
  wire NLW_U0_axi_w_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_overflow_UNCONNECTED;
  wire NLW_U0_axi_w_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_w_prog_full_UNCONNECTED;
  wire NLW_U0_axi_w_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_underflow_UNCONNECTED;
  wire NLW_U0_axis_dbiterr_UNCONNECTED;
  wire NLW_U0_axis_overflow_UNCONNECTED;
  wire NLW_U0_axis_prog_empty_UNCONNECTED;
  wire NLW_U0_axis_prog_full_UNCONNECTED;
  wire NLW_U0_axis_sbiterr_UNCONNECTED;
  wire NLW_U0_axis_underflow_UNCONNECTED;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_m_axi_arvalid_UNCONNECTED;
  wire NLW_U0_m_axi_awvalid_UNCONNECTED;
  wire NLW_U0_m_axi_bready_UNCONNECTED;
  wire NLW_U0_m_axi_rready_UNCONNECTED;
  wire NLW_U0_m_axi_wlast_UNCONNECTED;
  wire NLW_U0_m_axi_wvalid_UNCONNECTED;
  wire NLW_U0_m_axis_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_tvalid_UNCONNECTED;
  wire NLW_U0_overflow_UNCONNECTED;
  wire NLW_U0_prog_empty_UNCONNECTED;
  wire NLW_U0_prog_full_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_s_axis_tready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire NLW_U0_underflow_UNCONNECTED;
  wire NLW_U0_valid_UNCONNECTED;
  wire NLW_U0_wr_ack_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_wr_data_count_UNCONNECTED;
  wire [9:0]NLW_U0_data_count_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_araddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_arburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_arlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_aruser_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_awaddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_awburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_awlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awuser_UNCONNECTED;
  wire [63:0]NLW_U0_m_axi_wdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_wstrb_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wuser_UNCONNECTED;
  wire [7:0]NLW_U0_m_axis_tdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tid_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tkeep_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tstrb_UNCONNECTED;
  wire [3:0]NLW_U0_m_axis_tuser_UNCONNECTED;
  wire [9:0]NLW_U0_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;
  wire [9:0]NLW_U0_wr_data_count_UNCONNECTED;

  (* C_ADD_NGC_CONSTRAINT = "0" *) 
  (* C_APPLICATION_TYPE_AXIS = "0" *) 
  (* C_APPLICATION_TYPE_RACH = "0" *) 
  (* C_APPLICATION_TYPE_RDCH = "0" *) 
  (* C_APPLICATION_TYPE_WACH = "0" *) 
  (* C_APPLICATION_TYPE_WDCH = "0" *) 
  (* C_APPLICATION_TYPE_WRCH = "0" *) 
  (* C_AXIS_TDATA_WIDTH = "8" *) 
  (* C_AXIS_TDEST_WIDTH = "1" *) 
  (* C_AXIS_TID_WIDTH = "1" *) 
  (* C_AXIS_TKEEP_WIDTH = "1" *) 
  (* C_AXIS_TSTRB_WIDTH = "1" *) 
  (* C_AXIS_TUSER_WIDTH = "4" *) 
  (* C_AXIS_TYPE = "0" *) 
  (* C_AXI_ADDR_WIDTH = "32" *) 
  (* C_AXI_ARUSER_WIDTH = "1" *) 
  (* C_AXI_AWUSER_WIDTH = "1" *) 
  (* C_AXI_BUSER_WIDTH = "1" *) 
  (* C_AXI_DATA_WIDTH = "64" *) 
  (* C_AXI_ID_WIDTH = "1" *) 
  (* C_AXI_LEN_WIDTH = "8" *) 
  (* C_AXI_LOCK_WIDTH = "1" *) 
  (* C_AXI_RUSER_WIDTH = "1" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_AXI_WUSER_WIDTH = "1" *) 
  (* C_COMMON_CLOCK = "1" *) 
  (* C_COUNT_TYPE = "0" *) 
  (* C_DATA_COUNT_WIDTH = "10" *) 
  (* C_DEFAULT_VALUE = "BlankString" *) 
  (* C_DIN_WIDTH = "2" *) 
  (* C_DIN_WIDTH_AXIS = "1" *) 
  (* C_DIN_WIDTH_RACH = "32" *) 
  (* C_DIN_WIDTH_RDCH = "64" *) 
  (* C_DIN_WIDTH_WACH = "1" *) 
  (* C_DIN_WIDTH_WDCH = "64" *) 
  (* C_DIN_WIDTH_WRCH = "2" *) 
  (* C_DOUT_RST_VAL = "0" *) 
  (* C_DOUT_WIDTH = "2" *) 
  (* C_ENABLE_RLOCS = "0" *) 
  (* C_ENABLE_RST_SYNC = "1" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_ERROR_INJECTION_TYPE = "0" *) 
  (* C_ERROR_INJECTION_TYPE_AXIS = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_FULL_FLAGS_RST_VAL = "0" *) 
  (* C_HAS_ALMOST_EMPTY = "0" *) 
  (* C_HAS_ALMOST_FULL = "0" *) 
  (* C_HAS_AXIS_TDATA = "1" *) 
  (* C_HAS_AXIS_TDEST = "0" *) 
  (* C_HAS_AXIS_TID = "0" *) 
  (* C_HAS_AXIS_TKEEP = "0" *) 
  (* C_HAS_AXIS_TLAST = "0" *) 
  (* C_HAS_AXIS_TREADY = "1" *) 
  (* C_HAS_AXIS_TSTRB = "0" *) 
  (* C_HAS_AXIS_TUSER = "1" *) 
  (* C_HAS_AXI_ARUSER = "0" *) 
  (* C_HAS_AXI_AWUSER = "0" *) 
  (* C_HAS_AXI_BUSER = "0" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_AXI_RD_CHANNEL = "1" *) 
  (* C_HAS_AXI_RUSER = "0" *) 
  (* C_HAS_AXI_WR_CHANNEL = "1" *) 
  (* C_HAS_AXI_WUSER = "0" *) 
  (* C_HAS_BACKUP = "0" *) 
  (* C_HAS_DATA_COUNT = "0" *) 
  (* C_HAS_DATA_COUNTS_AXIS = "0" *) 
  (* C_HAS_DATA_COUNTS_RACH = "0" *) 
  (* C_HAS_DATA_COUNTS_RDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WACH = "0" *) 
  (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WRCH = "0" *) 
  (* C_HAS_INT_CLK = "0" *) 
  (* C_HAS_MASTER_CE = "0" *) 
  (* C_HAS_MEMINIT_FILE = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
  (* C_HAS_PROG_FLAGS_RACH = "0" *) 
  (* C_HAS_PROG_FLAGS_RDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WACH = "0" *) 
  (* C_HAS_PROG_FLAGS_WDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WRCH = "0" *) 
  (* C_HAS_RD_DATA_COUNT = "0" *) 
  (* C_HAS_RD_RST = "0" *) 
  (* C_HAS_RST = "1" *) 
  (* C_HAS_SLAVE_CE = "0" *) 
  (* C_HAS_SRST = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_HAS_VALID = "0" *) 
  (* C_HAS_WR_ACK = "0" *) 
  (* C_HAS_WR_DATA_COUNT = "0" *) 
  (* C_HAS_WR_RST = "0" *) 
  (* C_IMPLEMENTATION_TYPE = "0" *) 
  (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WRCH = "1" *) 
  (* C_INIT_WR_PNTR_VAL = "0" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_MEMORY_TYPE = "1" *) 
  (* C_MIF_FILE_NAME = "BlankString" *) 
  (* C_MSGON_VAL = "1" *) 
  (* C_OPTIMIZATION_MODE = "0" *) 
  (* C_OVERFLOW_LOW = "0" *) 
  (* C_POWER_SAVING_MODE = "0" *) 
  (* C_PRELOAD_LATENCY = "1" *) 
  (* C_PRELOAD_REGS = "0" *) 
  (* C_PRIM_FIFO_TYPE = "1kx18" *) 
  (* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) 
  (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL = "2" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "3" *) 
  (* C_PROG_EMPTY_TYPE = "0" *) 
  (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
  (* C_PROG_EMPTY_TYPE_RACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL = "1022" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
  (* C_PROG_FULL_THRESH_NEGATE_VAL = "1021" *) 
  (* C_PROG_FULL_TYPE = "0" *) 
  (* C_PROG_FULL_TYPE_AXIS = "0" *) 
  (* C_PROG_FULL_TYPE_RACH = "0" *) 
  (* C_PROG_FULL_TYPE_RDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WACH = "0" *) 
  (* C_PROG_FULL_TYPE_WDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WRCH = "0" *) 
  (* C_RACH_TYPE = "0" *) 
  (* C_RDCH_TYPE = "0" *) 
  (* C_RD_DATA_COUNT_WIDTH = "10" *) 
  (* C_RD_DEPTH = "1024" *) 
  (* C_RD_FREQ = "1" *) 
  (* C_RD_PNTR_WIDTH = "10" *) 
  (* C_REG_SLICE_MODE_AXIS = "0" *) 
  (* C_REG_SLICE_MODE_RACH = "0" *) 
  (* C_REG_SLICE_MODE_RDCH = "0" *) 
  (* C_REG_SLICE_MODE_WACH = "0" *) 
  (* C_REG_SLICE_MODE_WDCH = "0" *) 
  (* C_REG_SLICE_MODE_WRCH = "0" *) 
  (* C_SELECT_XPM = "0" *) 
  (* C_SYNCHRONIZER_STAGE = "2" *) 
  (* C_UNDERFLOW_LOW = "0" *) 
  (* C_USE_COMMON_OVERFLOW = "0" *) 
  (* C_USE_COMMON_UNDERFLOW = "0" *) 
  (* C_USE_DEFAULT_SETTINGS = "0" *) 
  (* C_USE_DOUT_RST = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_ECC_AXIS = "0" *) 
  (* C_USE_ECC_RACH = "0" *) 
  (* C_USE_ECC_RDCH = "0" *) 
  (* C_USE_ECC_WACH = "0" *) 
  (* C_USE_ECC_WDCH = "0" *) 
  (* C_USE_ECC_WRCH = "0" *) 
  (* C_USE_EMBEDDED_REG = "0" *) 
  (* C_USE_FIFO16_FLAGS = "0" *) 
  (* C_USE_FWFT_DATA_COUNT = "0" *) 
  (* C_USE_PIPELINE_REG = "0" *) 
  (* C_VALID_LOW = "0" *) 
  (* C_WACH_TYPE = "0" *) 
  (* C_WDCH_TYPE = "0" *) 
  (* C_WRCH_TYPE = "0" *) 
  (* C_WR_ACK_LOW = "0" *) 
  (* C_WR_DATA_COUNT_WIDTH = "10" *) 
  (* C_WR_DEPTH = "1024" *) 
  (* C_WR_DEPTH_AXIS = "1024" *) 
  (* C_WR_DEPTH_RACH = "16" *) 
  (* C_WR_DEPTH_RDCH = "1024" *) 
  (* C_WR_DEPTH_WACH = "16" *) 
  (* C_WR_DEPTH_WDCH = "1024" *) 
  (* C_WR_DEPTH_WRCH = "16" *) 
  (* C_WR_FREQ = "1" *) 
  (* C_WR_PNTR_WIDTH = "10" *) 
  (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
  (* C_WR_PNTR_WIDTH_RACH = "4" *) 
  (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WACH = "4" *) 
  (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
  (* C_WR_RESPONSE_LATENCY = "1" *) 
  (* is_du_within_envelope = "true" *) 
  FIFO_Code_Couleur_fifo_generator_v13_2_5 U0
       (.almost_empty(NLW_U0_almost_empty_UNCONNECTED),
        .almost_full(NLW_U0_almost_full_UNCONNECTED),
        .axi_ar_data_count(NLW_U0_axi_ar_data_count_UNCONNECTED[4:0]),
        .axi_ar_dbiterr(NLW_U0_axi_ar_dbiterr_UNCONNECTED),
        .axi_ar_injectdbiterr(1'b0),
        .axi_ar_injectsbiterr(1'b0),
        .axi_ar_overflow(NLW_U0_axi_ar_overflow_UNCONNECTED),
        .axi_ar_prog_empty(NLW_U0_axi_ar_prog_empty_UNCONNECTED),
        .axi_ar_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_prog_full(NLW_U0_axi_ar_prog_full_UNCONNECTED),
        .axi_ar_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_rd_data_count(NLW_U0_axi_ar_rd_data_count_UNCONNECTED[4:0]),
        .axi_ar_sbiterr(NLW_U0_axi_ar_sbiterr_UNCONNECTED),
        .axi_ar_underflow(NLW_U0_axi_ar_underflow_UNCONNECTED),
        .axi_ar_wr_data_count(NLW_U0_axi_ar_wr_data_count_UNCONNECTED[4:0]),
        .axi_aw_data_count(NLW_U0_axi_aw_data_count_UNCONNECTED[4:0]),
        .axi_aw_dbiterr(NLW_U0_axi_aw_dbiterr_UNCONNECTED),
        .axi_aw_injectdbiterr(1'b0),
        .axi_aw_injectsbiterr(1'b0),
        .axi_aw_overflow(NLW_U0_axi_aw_overflow_UNCONNECTED),
        .axi_aw_prog_empty(NLW_U0_axi_aw_prog_empty_UNCONNECTED),
        .axi_aw_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_prog_full(NLW_U0_axi_aw_prog_full_UNCONNECTED),
        .axi_aw_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_rd_data_count(NLW_U0_axi_aw_rd_data_count_UNCONNECTED[4:0]),
        .axi_aw_sbiterr(NLW_U0_axi_aw_sbiterr_UNCONNECTED),
        .axi_aw_underflow(NLW_U0_axi_aw_underflow_UNCONNECTED),
        .axi_aw_wr_data_count(NLW_U0_axi_aw_wr_data_count_UNCONNECTED[4:0]),
        .axi_b_data_count(NLW_U0_axi_b_data_count_UNCONNECTED[4:0]),
        .axi_b_dbiterr(NLW_U0_axi_b_dbiterr_UNCONNECTED),
        .axi_b_injectdbiterr(1'b0),
        .axi_b_injectsbiterr(1'b0),
        .axi_b_overflow(NLW_U0_axi_b_overflow_UNCONNECTED),
        .axi_b_prog_empty(NLW_U0_axi_b_prog_empty_UNCONNECTED),
        .axi_b_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_prog_full(NLW_U0_axi_b_prog_full_UNCONNECTED),
        .axi_b_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_rd_data_count(NLW_U0_axi_b_rd_data_count_UNCONNECTED[4:0]),
        .axi_b_sbiterr(NLW_U0_axi_b_sbiterr_UNCONNECTED),
        .axi_b_underflow(NLW_U0_axi_b_underflow_UNCONNECTED),
        .axi_b_wr_data_count(NLW_U0_axi_b_wr_data_count_UNCONNECTED[4:0]),
        .axi_r_data_count(NLW_U0_axi_r_data_count_UNCONNECTED[10:0]),
        .axi_r_dbiterr(NLW_U0_axi_r_dbiterr_UNCONNECTED),
        .axi_r_injectdbiterr(1'b0),
        .axi_r_injectsbiterr(1'b0),
        .axi_r_overflow(NLW_U0_axi_r_overflow_UNCONNECTED),
        .axi_r_prog_empty(NLW_U0_axi_r_prog_empty_UNCONNECTED),
        .axi_r_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_prog_full(NLW_U0_axi_r_prog_full_UNCONNECTED),
        .axi_r_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_rd_data_count(NLW_U0_axi_r_rd_data_count_UNCONNECTED[10:0]),
        .axi_r_sbiterr(NLW_U0_axi_r_sbiterr_UNCONNECTED),
        .axi_r_underflow(NLW_U0_axi_r_underflow_UNCONNECTED),
        .axi_r_wr_data_count(NLW_U0_axi_r_wr_data_count_UNCONNECTED[10:0]),
        .axi_w_data_count(NLW_U0_axi_w_data_count_UNCONNECTED[10:0]),
        .axi_w_dbiterr(NLW_U0_axi_w_dbiterr_UNCONNECTED),
        .axi_w_injectdbiterr(1'b0),
        .axi_w_injectsbiterr(1'b0),
        .axi_w_overflow(NLW_U0_axi_w_overflow_UNCONNECTED),
        .axi_w_prog_empty(NLW_U0_axi_w_prog_empty_UNCONNECTED),
        .axi_w_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_prog_full(NLW_U0_axi_w_prog_full_UNCONNECTED),
        .axi_w_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_rd_data_count(NLW_U0_axi_w_rd_data_count_UNCONNECTED[10:0]),
        .axi_w_sbiterr(NLW_U0_axi_w_sbiterr_UNCONNECTED),
        .axi_w_underflow(NLW_U0_axi_w_underflow_UNCONNECTED),
        .axi_w_wr_data_count(NLW_U0_axi_w_wr_data_count_UNCONNECTED[10:0]),
        .axis_data_count(NLW_U0_axis_data_count_UNCONNECTED[10:0]),
        .axis_dbiterr(NLW_U0_axis_dbiterr_UNCONNECTED),
        .axis_injectdbiterr(1'b0),
        .axis_injectsbiterr(1'b0),
        .axis_overflow(NLW_U0_axis_overflow_UNCONNECTED),
        .axis_prog_empty(NLW_U0_axis_prog_empty_UNCONNECTED),
        .axis_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_prog_full(NLW_U0_axis_prog_full_UNCONNECTED),
        .axis_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_rd_data_count(NLW_U0_axis_rd_data_count_UNCONNECTED[10:0]),
        .axis_sbiterr(NLW_U0_axis_sbiterr_UNCONNECTED),
        .axis_underflow(NLW_U0_axis_underflow_UNCONNECTED),
        .axis_wr_data_count(NLW_U0_axis_wr_data_count_UNCONNECTED[10:0]),
        .backup(1'b0),
        .backup_marker(1'b0),
        .clk(clk),
        .data_count(NLW_U0_data_count_UNCONNECTED[9:0]),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .int_clk(1'b0),
        .m_aclk(1'b0),
        .m_aclk_en(1'b0),
        .m_axi_araddr(NLW_U0_m_axi_araddr_UNCONNECTED[31:0]),
        .m_axi_arburst(NLW_U0_m_axi_arburst_UNCONNECTED[1:0]),
        .m_axi_arcache(NLW_U0_m_axi_arcache_UNCONNECTED[3:0]),
        .m_axi_arid(NLW_U0_m_axi_arid_UNCONNECTED[0]),
        .m_axi_arlen(NLW_U0_m_axi_arlen_UNCONNECTED[7:0]),
        .m_axi_arlock(NLW_U0_m_axi_arlock_UNCONNECTED[0]),
        .m_axi_arprot(NLW_U0_m_axi_arprot_UNCONNECTED[2:0]),
        .m_axi_arqos(NLW_U0_m_axi_arqos_UNCONNECTED[3:0]),
        .m_axi_arready(1'b0),
        .m_axi_arregion(NLW_U0_m_axi_arregion_UNCONNECTED[3:0]),
        .m_axi_arsize(NLW_U0_m_axi_arsize_UNCONNECTED[2:0]),
        .m_axi_aruser(NLW_U0_m_axi_aruser_UNCONNECTED[0]),
        .m_axi_arvalid(NLW_U0_m_axi_arvalid_UNCONNECTED),
        .m_axi_awaddr(NLW_U0_m_axi_awaddr_UNCONNECTED[31:0]),
        .m_axi_awburst(NLW_U0_m_axi_awburst_UNCONNECTED[1:0]),
        .m_axi_awcache(NLW_U0_m_axi_awcache_UNCONNECTED[3:0]),
        .m_axi_awid(NLW_U0_m_axi_awid_UNCONNECTED[0]),
        .m_axi_awlen(NLW_U0_m_axi_awlen_UNCONNECTED[7:0]),
        .m_axi_awlock(NLW_U0_m_axi_awlock_UNCONNECTED[0]),
        .m_axi_awprot(NLW_U0_m_axi_awprot_UNCONNECTED[2:0]),
        .m_axi_awqos(NLW_U0_m_axi_awqos_UNCONNECTED[3:0]),
        .m_axi_awready(1'b0),
        .m_axi_awregion(NLW_U0_m_axi_awregion_UNCONNECTED[3:0]),
        .m_axi_awsize(NLW_U0_m_axi_awsize_UNCONNECTED[2:0]),
        .m_axi_awuser(NLW_U0_m_axi_awuser_UNCONNECTED[0]),
        .m_axi_awvalid(NLW_U0_m_axi_awvalid_UNCONNECTED),
        .m_axi_bid(1'b0),
        .m_axi_bready(NLW_U0_m_axi_bready_UNCONNECTED),
        .m_axi_bresp({1'b0,1'b0}),
        .m_axi_buser(1'b0),
        .m_axi_bvalid(1'b0),
        .m_axi_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_rid(1'b0),
        .m_axi_rlast(1'b0),
        .m_axi_rready(NLW_U0_m_axi_rready_UNCONNECTED),
        .m_axi_rresp({1'b0,1'b0}),
        .m_axi_ruser(1'b0),
        .m_axi_rvalid(1'b0),
        .m_axi_wdata(NLW_U0_m_axi_wdata_UNCONNECTED[63:0]),
        .m_axi_wid(NLW_U0_m_axi_wid_UNCONNECTED[0]),
        .m_axi_wlast(NLW_U0_m_axi_wlast_UNCONNECTED),
        .m_axi_wready(1'b0),
        .m_axi_wstrb(NLW_U0_m_axi_wstrb_UNCONNECTED[7:0]),
        .m_axi_wuser(NLW_U0_m_axi_wuser_UNCONNECTED[0]),
        .m_axi_wvalid(NLW_U0_m_axi_wvalid_UNCONNECTED),
        .m_axis_tdata(NLW_U0_m_axis_tdata_UNCONNECTED[7:0]),
        .m_axis_tdest(NLW_U0_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_U0_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(NLW_U0_m_axis_tkeep_UNCONNECTED[0]),
        .m_axis_tlast(NLW_U0_m_axis_tlast_UNCONNECTED),
        .m_axis_tready(1'b0),
        .m_axis_tstrb(NLW_U0_m_axis_tstrb_UNCONNECTED[0]),
        .m_axis_tuser(NLW_U0_m_axis_tuser_UNCONNECTED[3:0]),
        .m_axis_tvalid(NLW_U0_m_axis_tvalid_UNCONNECTED),
        .overflow(NLW_U0_overflow_UNCONNECTED),
        .prog_empty(NLW_U0_prog_empty_UNCONNECTED),
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full(NLW_U0_prog_full_UNCONNECTED),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(1'b0),
        .rd_data_count(NLW_U0_rd_data_count_UNCONNECTED[9:0]),
        .rd_en(rd_en),
        .rd_rst(1'b0),
        .rd_rst_busy(rd_rst_busy),
        .rst(rst),
        .s_aclk(1'b0),
        .s_aclk_en(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arid(1'b0),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlock(1'b0),
        .s_axi_arprot({1'b0,1'b0,1'b0}),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_aruser(1'b0),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awuser(1'b0),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_buser(NLW_U0_s_axi_buser_UNCONNECTED[0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[63:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_ruser(NLW_U0_s_axi_ruser_UNCONNECTED[0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wid(1'b0),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wuser(1'b0),
        .s_axi_wvalid(1'b0),
        .s_axis_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tdest(1'b0),
        .s_axis_tid(1'b0),
        .s_axis_tkeep(1'b0),
        .s_axis_tlast(1'b0),
        .s_axis_tready(NLW_U0_s_axis_tready_UNCONNECTED),
        .s_axis_tstrb(1'b0),
        .s_axis_tuser({1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .sleep(1'b0),
        .srst(1'b0),
        .underflow(NLW_U0_underflow_UNCONNECTED),
        .valid(NLW_U0_valid_UNCONNECTED),
        .wr_ack(NLW_U0_wr_ack_UNCONNECTED),
        .wr_clk(1'b0),
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[9:0]),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* DEF_VAL = "1'b1" *) (* DEST_SYNC_FF = "5" *) (* INIT = "1" *) 
(* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_sync_rst" *) (* SIM_ASSERT_CHK = "0" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* is_du_within_envelope = "true" *) 
(* keep_hierarchy = "true" *) (* xpm_cdc = "SYNC_RST" *) 
module FIFO_Code_Couleur_xpm_cdc_sync_rst
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [4:0]syncstages_ff;

  assign dest_rst = syncstages_ff[4];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[3]),
        .Q(syncstages_ff[4]),
        .R(1'b0));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "3" *) (* INIT = "0" *) 
(* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_sync_rst" *) (* SIM_ASSERT_CHK = "0" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* is_du_within_envelope = "true" *) 
(* keep_hierarchy = "true" *) (* xpm_cdc = "SYNC_RST" *) 
module FIFO_Code_Couleur_xpm_cdc_sync_rst__parameterized1
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [2:0]syncstages_ff;

  assign dest_rst = syncstages_ff[2];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 100032)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
