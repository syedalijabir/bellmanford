//-----------------------------------------------------------------------------
// ddr3_sdram_wrapper.v
//-----------------------------------------------------------------------------

(* x_core_info = "axi_v6_ddrx_v1_03_a" *)
module ddr3_sdram_wrapper
  (
    clk,
    clk_mem,
    clk_rd_base,
    aresetn,
    clk_ref,
    iodelay_ctrl_rdy_i,
    iodelay_ctrl_rdy_o,
    pd_PSEN,
    pd_PSINCDEC,
    pd_PSDONE,
    phy_init_done,
    interrupt,
    ddr_addr,
    ddr_ba,
    ddr_cas_n,
    ddr_ck_p,
    ddr_ck_n,
    ddr_cke,
    ddr_cs_n,
    ddr_dm,
    ddr_odt,
    ddr_ras_n,
    ddr_reset_n,
    ddr_parity,
    ddr_we_n,
    ddr_dq,
    ddr_dqs_p,
    ddr_dqs_n,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awqos,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arqos,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_ctrl_awaddr,
    s_axi_ctrl_awvalid,
    s_axi_ctrl_awready,
    s_axi_ctrl_wdata,
    s_axi_ctrl_wvalid,
    s_axi_ctrl_wready,
    s_axi_ctrl_bresp,
    s_axi_ctrl_bvalid,
    s_axi_ctrl_bready,
    s_axi_ctrl_araddr,
    s_axi_ctrl_arvalid,
    s_axi_ctrl_arready,
    s_axi_ctrl_rdata,
    s_axi_ctrl_rresp,
    s_axi_ctrl_rvalid,
    s_axi_ctrl_rready
  );
  input clk;
  input clk_mem;
  input clk_rd_base;
  input aresetn;
  input clk_ref;
  input iodelay_ctrl_rdy_i;
  output iodelay_ctrl_rdy_o;
  output pd_PSEN;
  output pd_PSINCDEC;
  input pd_PSDONE;
  output phy_init_done;
  output interrupt;
  output [12:0] ddr_addr;
  output [2:0] ddr_ba;
  output ddr_cas_n;
  output [0:0] ddr_ck_p;
  output [0:0] ddr_ck_n;
  output [0:0] ddr_cke;
  output [0:0] ddr_cs_n;
  output [0:0] ddr_dm;
  output [0:0] ddr_odt;
  output ddr_ras_n;
  output ddr_reset_n;
  output ddr_parity;
  output ddr_we_n;
  inout [7:0] ddr_dq;
  inout [0:0] ddr_dqs_p;
  inout [0:0] ddr_dqs_n;
  input [0:0] s_axi_awid;
  input [31:0] s_axi_awaddr;
  input [7:0] s_axi_awlen;
  input [2:0] s_axi_awsize;
  input [1:0] s_axi_awburst;
  input [0:0] s_axi_awlock;
  input [3:0] s_axi_awcache;
  input [2:0] s_axi_awprot;
  input [3:0] s_axi_awqos;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0] s_axi_wdata;
  input [3:0] s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [0:0] s_axi_bid;
  output [1:0] s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [0:0] s_axi_arid;
  input [31:0] s_axi_araddr;
  input [7:0] s_axi_arlen;
  input [2:0] s_axi_arsize;
  input [1:0] s_axi_arburst;
  input [0:0] s_axi_arlock;
  input [3:0] s_axi_arcache;
  input [2:0] s_axi_arprot;
  input [3:0] s_axi_arqos;
  input s_axi_arvalid;
  output s_axi_arready;
  output [0:0] s_axi_rid;
  output [31:0] s_axi_rdata;
  output [1:0] s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input [31:0] s_axi_ctrl_awaddr;
  input s_axi_ctrl_awvalid;
  output s_axi_ctrl_awready;
  input [31:0] s_axi_ctrl_wdata;
  input s_axi_ctrl_wvalid;
  output s_axi_ctrl_wready;
  output [1:0] s_axi_ctrl_bresp;
  output s_axi_ctrl_bvalid;
  input s_axi_ctrl_bready;
  input [31:0] s_axi_ctrl_araddr;
  input s_axi_ctrl_arvalid;
  output s_axi_ctrl_arready;
  output [31:0] s_axi_ctrl_rdata;
  output [1:0] s_axi_ctrl_rresp;
  output s_axi_ctrl_rvalid;
  input s_axi_ctrl_rready;

  axi_v6_ddrx
    #(
      .C_REFCLK_FREQ ( 200 ),
      .C_BYPASS_INIT_CAL ( "OFF" ),
      .C_IODELAY_GRP ( "DDR3_SDRAM" ),
      .C_USE_EXTERNAL_IODELAY_CTRL ( 0 ),
      .C_DRAM_TYPE ( "DDR3" ),
      .C_NCS_PER_RANK ( 1 ),
      .C_BANK_WIDTH ( 3 ),
      .C_CK_WIDTH ( 1 ),
      .C_CKE_WIDTH ( 1 ),
      .C_COL_WIDTH ( 10 ),
      .C_CS_WIDTH ( 1 ),
      .C_DM_WIDTH ( 1 ),
      .C_USE_DM_PORT ( 1 ),
      .C_DRAM_WIDTH ( 8 ),
      .C_DQS_WIDTH ( 1 ),
      .C_ROW_WIDTH ( 13 ),
      .C_DQ_WIDTH ( 8 ),
      .C_BURST_MODE ( "8" ),
      .C_BURST_TYPE ( "SEQ" ),
      .C_IODELAY_HP_MODE ( "ON" ),
      .C_CL ( 6 ),
      .C_CWL ( 5 ),
      .C_ADDR_CMD_MODE ( "1T" ),
      .C_NBANK_MACHS ( 4 ),
      .C_ORDERING ( "NORM" ),
      .C_RANKS ( 1 ),
      .C_CAL_WIDTH ( "HALF" ),
      .C_RTT_NOM ( "40" ),
      .C_RTT_WR ( "OFF" ),
      .C_OUTPUT_DRV ( "HIGH" ),
      .C_REG_CTRL ( "OFF" ),
      .C_NDQS_COL0 ( 1 ),
      .C_NDQS_COL1 ( 0 ),
      .C_NDQS_COL2 ( 0 ),
      .C_NDQS_COL3 ( 0 ),
      .C_DQS_LOC_COL0 ( 8'h00 ),
      .C_DQS_LOC_COL1 ( 0 ),
      .C_DQS_LOC_COL2 ( 0 ),
      .C_DQS_LOC_COL3 ( 0 ),
      .C_TCK ( 2500 ),
      .C_TFAW ( 45000 ),
      .C_TPRDI ( 1000000 ),
      .C_TRRD ( 7500 ),
      .C_TRAS ( 36000 ),
      .C_TRCD ( 13500 ),
      .C_TREFI ( 7800000 ),
      .C_TRFC ( 110000 ),
      .C_TRP ( 13500 ),
      .C_TRTP ( 7500 ),
      .C_TWTR ( 7500 ),
      .C_TZQI ( 128000000 ),
      .C_TZQCS ( 64 ),
      .C_SLOT_0_CONFIG ( 8'b00000001 ),
      .C_SLOT_1_CONFIG ( 8'b00000000 ),
      .C_MEM_ADDR_ORDER ( "BANK_ROW_COLUMN" ),
      .C_ECC ( "OFF" ),
      .C_ECC_TEST ( "OFF" ),
      .C_S_AXI_ID_WIDTH ( 1 ),
      .C_S_AXI_ADDR_WIDTH ( 32 ),
      .C_S_AXI_DATA_WIDTH ( 32 ),
      .C_S_AXI_SUPPORTS_NARROW_BURST ( 0 ),
      .C_S_AXI_REG_EN0 ( 20'h00000 ),
      .C_S_AXI_REG_EN1 ( 20'h01000 ),
      .C_S_AXI_BASEADDR ( 32'hbc000000 ),
      .C_S_AXI_HIGHADDR ( 32'hbfffffff ),
      .C_S_AXI_CTRL_ADDR_WIDTH ( 32 ),
      .C_S_AXI_CTRL_DATA_WIDTH ( 32 )
    )
    DDR3_SDRAM (
      .clk ( clk ),
      .clk_mem ( clk_mem ),
      .clk_rd_base ( clk_rd_base ),
      .aresetn ( aresetn ),
      .clk_ref ( clk_ref ),
      .iodelay_ctrl_rdy_i ( iodelay_ctrl_rdy_i ),
      .iodelay_ctrl_rdy_o ( iodelay_ctrl_rdy_o ),
      .pd_PSEN ( pd_PSEN ),
      .pd_PSINCDEC ( pd_PSINCDEC ),
      .pd_PSDONE ( pd_PSDONE ),
      .phy_init_done ( phy_init_done ),
      .interrupt ( interrupt ),
      .ddr_addr ( ddr_addr ),
      .ddr_ba ( ddr_ba ),
      .ddr_cas_n ( ddr_cas_n ),
      .ddr_ck_p ( ddr_ck_p ),
      .ddr_ck_n ( ddr_ck_n ),
      .ddr_cke ( ddr_cke ),
      .ddr_cs_n ( ddr_cs_n ),
      .ddr_dm ( ddr_dm ),
      .ddr_odt ( ddr_odt ),
      .ddr_ras_n ( ddr_ras_n ),
      .ddr_reset_n ( ddr_reset_n ),
      .ddr_parity ( ddr_parity ),
      .ddr_we_n ( ddr_we_n ),
      .ddr_dq ( ddr_dq ),
      .ddr_dqs_p ( ddr_dqs_p ),
      .ddr_dqs_n ( ddr_dqs_n ),
      .s_axi_awid ( s_axi_awid ),
      .s_axi_awaddr ( s_axi_awaddr ),
      .s_axi_awlen ( s_axi_awlen ),
      .s_axi_awsize ( s_axi_awsize ),
      .s_axi_awburst ( s_axi_awburst ),
      .s_axi_awlock ( s_axi_awlock ),
      .s_axi_awcache ( s_axi_awcache ),
      .s_axi_awprot ( s_axi_awprot ),
      .s_axi_awqos ( s_axi_awqos ),
      .s_axi_awvalid ( s_axi_awvalid ),
      .s_axi_awready ( s_axi_awready ),
      .s_axi_wdata ( s_axi_wdata ),
      .s_axi_wstrb ( s_axi_wstrb ),
      .s_axi_wlast ( s_axi_wlast ),
      .s_axi_wvalid ( s_axi_wvalid ),
      .s_axi_wready ( s_axi_wready ),
      .s_axi_bid ( s_axi_bid ),
      .s_axi_bresp ( s_axi_bresp ),
      .s_axi_bvalid ( s_axi_bvalid ),
      .s_axi_bready ( s_axi_bready ),
      .s_axi_arid ( s_axi_arid ),
      .s_axi_araddr ( s_axi_araddr ),
      .s_axi_arlen ( s_axi_arlen ),
      .s_axi_arsize ( s_axi_arsize ),
      .s_axi_arburst ( s_axi_arburst ),
      .s_axi_arlock ( s_axi_arlock ),
      .s_axi_arcache ( s_axi_arcache ),
      .s_axi_arprot ( s_axi_arprot ),
      .s_axi_arqos ( s_axi_arqos ),
      .s_axi_arvalid ( s_axi_arvalid ),
      .s_axi_arready ( s_axi_arready ),
      .s_axi_rid ( s_axi_rid ),
      .s_axi_rdata ( s_axi_rdata ),
      .s_axi_rresp ( s_axi_rresp ),
      .s_axi_rlast ( s_axi_rlast ),
      .s_axi_rvalid ( s_axi_rvalid ),
      .s_axi_rready ( s_axi_rready ),
      .s_axi_ctrl_awaddr ( s_axi_ctrl_awaddr ),
      .s_axi_ctrl_awvalid ( s_axi_ctrl_awvalid ),
      .s_axi_ctrl_awready ( s_axi_ctrl_awready ),
      .s_axi_ctrl_wdata ( s_axi_ctrl_wdata ),
      .s_axi_ctrl_wvalid ( s_axi_ctrl_wvalid ),
      .s_axi_ctrl_wready ( s_axi_ctrl_wready ),
      .s_axi_ctrl_bresp ( s_axi_ctrl_bresp ),
      .s_axi_ctrl_bvalid ( s_axi_ctrl_bvalid ),
      .s_axi_ctrl_bready ( s_axi_ctrl_bready ),
      .s_axi_ctrl_araddr ( s_axi_ctrl_araddr ),
      .s_axi_ctrl_arvalid ( s_axi_ctrl_arvalid ),
      .s_axi_ctrl_arready ( s_axi_ctrl_arready ),
      .s_axi_ctrl_rdata ( s_axi_ctrl_rdata ),
      .s_axi_ctrl_rresp ( s_axi_ctrl_rresp ),
      .s_axi_ctrl_rvalid ( s_axi_ctrl_rvalid ),
      .s_axi_ctrl_rready ( s_axi_ctrl_rready )
    );

endmodule

