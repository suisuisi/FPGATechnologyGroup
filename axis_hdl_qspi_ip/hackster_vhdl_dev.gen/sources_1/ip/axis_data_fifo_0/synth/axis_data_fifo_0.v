// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2023 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:ip:axis_data_fifo:2.0
// IP Revision: 10

(* X_CORE_INFO = "axis_data_fifo_v2_0_10_top,Vivado 2023.1" *)
(* CHECK_LICENSE_TYPE = "axis_data_fifo_0,axis_data_fifo_v2_0_10_top,{}" *)
(* CORE_GENERATION_INFO = "axis_data_fifo_0,axis_data_fifo_v2_0_10_top,{x_ipProduct=Vivado 2023.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=axis_data_fifo,x_ipVersion=2.0,x_ipCoreRevision=10,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_FAMILY=zynquplus,C_AXIS_TDATA_WIDTH=8,C_AXIS_TID_WIDTH=1,C_AXIS_TDEST_WIDTH=1,C_AXIS_TUSER_WIDTH=1,C_AXIS_SIGNAL_SET=0b00000000000000000000000000010011,C_FIFO_DEPTH=512,C_FIFO_MODE=1,C_IS_ACLK_ASYNC=0,C_SYNCHRONIZER_STAGE=3,C_ACLKEN_CONV_MODE=0,C_ECC_MODE=0,C_FIFO_MEMORY_TYPE=auto,C_USE_AD\
V_FEATURES=825241648,C_PROG_EMPTY_THRESH=5,C_PROG_FULL_THRESH=11}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module axis_data_fifo_0 (
  s_axis_aresetn,
  s_axis_aclk,
  s_axis_tvalid,
  s_axis_tready,
  s_axis_tdata,
  s_axis_tlast,
  m_axis_tvalid,
  m_axis_tready,
  m_axis_tdata,
  m_axis_tlast
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S_RSTIF RST" *)
input wire s_axis_aresetn;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_CLKIF, ASSOCIATED_BUSIF S_AXIS, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S_CLKIF CLK" *)
input wire s_axis_aclk;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *)
input wire s_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TREADY" *)
output wire s_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *)
input wire [7 : 0] s_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TLAST" *)
input wire s_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *)
output wire m_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *)
input wire m_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *)
output wire [7 : 0] m_axis_tdata;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TLAST" *)
output wire m_axis_tlast;

  axis_data_fifo_v2_0_10_top #(
    .C_FAMILY("zynquplus"),
    .C_AXIS_TDATA_WIDTH(8),
    .C_AXIS_TID_WIDTH(1),
    .C_AXIS_TDEST_WIDTH(1),
    .C_AXIS_TUSER_WIDTH(1),
    .C_AXIS_SIGNAL_SET(32'B00000000000000000000000000010011),
    .C_FIFO_DEPTH(512),
    .C_FIFO_MODE(1),
    .C_IS_ACLK_ASYNC(0),
    .C_SYNCHRONIZER_STAGE(3),
    .C_ACLKEN_CONV_MODE(0),
    .C_ECC_MODE(0),
    .C_FIFO_MEMORY_TYPE("auto"),
    .C_USE_ADV_FEATURES(825241648),
    .C_PROG_EMPTY_THRESH(5),
    .C_PROG_FULL_THRESH(11)
  ) inst (
    .s_axis_aresetn(s_axis_aresetn),
    .s_axis_aclk(s_axis_aclk),
    .s_axis_aclken(1'H1),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tready(s_axis_tready),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tstrb(1'H1),
    .s_axis_tkeep(1'H1),
    .s_axis_tlast(s_axis_tlast),
    .s_axis_tid(1'H0),
    .s_axis_tdest(1'H0),
    .s_axis_tuser(1'H0),
    .m_axis_aclk(1'H0),
    .m_axis_aclken(1'H1),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tready(m_axis_tready),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tstrb(),
    .m_axis_tkeep(),
    .m_axis_tlast(m_axis_tlast),
    .m_axis_tid(),
    .m_axis_tdest(),
    .m_axis_tuser(),
    .axis_wr_data_count(),
    .axis_rd_data_count(),
    .almost_empty(),
    .prog_empty(),
    .almost_full(),
    .prog_full(),
    .sbiterr(),
    .dbiterr(),
    .injectsbiterr(1'H0),
    .injectdbiterr(1'H0)
  );
endmodule
