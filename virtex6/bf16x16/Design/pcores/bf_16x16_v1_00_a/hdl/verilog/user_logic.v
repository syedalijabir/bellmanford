//----------------------------------------------------------------------------
// user_logic.vhd - module
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** Xilinx, Inc.                                                          **
// ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
// ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
// ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
// ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
// ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
// ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
// ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
// ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
// ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
// ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
// ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
// ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
// ** FOR A PARTICULAR PURPOSE.                                             **
// **                                                                       **
// ***************************************************************************
//
//----------------------------------------------------------------------------
// Filename:          user_logic.vhd
// Version:           1.00.a
// Description:       User logic module.
// Date:              Sun Jun 23 20:20:07 2013 (by Create and Import Peripheral Wizard)
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

module user_logic
(
  // -- ADD USER PORTS BELOW THIS LINE ---------------
  // --USER ports added here 
  // -- ADD USER PORTS ABOVE THIS LINE ---------------

  // -- DO NOT EDIT BELOW THIS LINE ------------------
  // -- Bus protocol ports, do not add to or delete 
  Bus2IP_Clk,                     // Bus to IP clock
  Bus2IP_Resetn,                  // Bus to IP reset
  Bus2IP_Data,                    // Bus to IP data bus
  Bus2IP_BE,                      // Bus to IP byte enables
  Bus2IP_RdCE,                    // Bus to IP read chip enable
  Bus2IP_WrCE,                    // Bus to IP write chip enable
  IP2Bus_Data,                    // IP to Bus data bus
  IP2Bus_RdAck,                   // IP to Bus read transfer acknowledgement
  IP2Bus_WrAck,                   // IP to Bus write transfer acknowledgement
  IP2Bus_Error                    // IP to Bus error response
  // -- DO NOT EDIT ABOVE THIS LINE ------------------
); // user_logic

// -- ADD USER PARAMETERS BELOW THIS LINE ------------
// --USER parameters added here 
// -- ADD USER PARAMETERS ABOVE THIS LINE ------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol parameters, do not add to or delete
parameter C_NUM_REG                      = 10;
parameter C_SLV_DWIDTH                   = 32;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

// -- ADD USER PORTS BELOW THIS LINE -----------------
// --USER ports added here 
// -- ADD USER PORTS ABOVE THIS LINE -----------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol ports, do not add to or delete
input                                     Bus2IP_Clk;
input                                     Bus2IP_Resetn;
input      [C_SLV_DWIDTH-1 : 0]           Bus2IP_Data;
input      [C_SLV_DWIDTH/8-1 : 0]         Bus2IP_BE;
input      [C_NUM_REG-1 : 0]              Bus2IP_RdCE;
input      [C_NUM_REG-1 : 0]              Bus2IP_WrCE;
output     [C_SLV_DWIDTH-1 : 0]           IP2Bus_Data;
output                                    IP2Bus_RdAck;
output                                    IP2Bus_WrAck;
output                                    IP2Bus_Error;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

//----------------------------------------------------------------------------
// Implementation
//----------------------------------------------------------------------------

  // --USER nets declarations added here, as needed for user logic

  // Nets for user logic slave model s/w accessible register example
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg0;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg1;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg2;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg3;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg4;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg5;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg6;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg7;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg8;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_reg9;
  wire       [9 : 0]                        slv_reg_write_sel;
  wire       [9 : 0]                        slv_reg_read_sel;
  reg        [C_SLV_DWIDTH-1 : 0]           slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;

  // --USER logic implementation added here

  // ------------------------------------------------------
  // Example code to read/write user logic slave model s/w accessible registers
  // 
  // Note:
  // The example code presented here is to show you one way of reading/writing
  // software accessible registers implemented in the user logic slave model.
  // Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  // to one software accessible register by the top level template. For example,
  // if you have four 32 bit software accessible registers in the user logic,
  // you are basically operating on the following memory mapped registers:
  // 
  //    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  //                     "1000"   C_BASEADDR + 0x0
  //                     "0100"   C_BASEADDR + 0x4
  //                     "0010"   C_BASEADDR + 0x8
  //                     "0001"   C_BASEADDR + 0xC
  // 
  // ------------------------------------------------------

  assign
    slv_reg_write_sel = Bus2IP_WrCE[9:0],
    slv_reg_read_sel  = Bus2IP_RdCE[9:0],
    slv_write_ack     = Bus2IP_WrCE[0] || Bus2IP_WrCE[1] || Bus2IP_WrCE[2] || Bus2IP_WrCE[3] || Bus2IP_WrCE[4] || Bus2IP_WrCE[5] || Bus2IP_WrCE[6] || Bus2IP_WrCE[7] || Bus2IP_WrCE[8] || Bus2IP_WrCE[9],
    slv_read_ack      = Bus2IP_RdCE[0] || Bus2IP_RdCE[1] || Bus2IP_RdCE[2] || Bus2IP_RdCE[3] || Bus2IP_RdCE[4] || Bus2IP_RdCE[5] || Bus2IP_RdCE[6] || Bus2IP_RdCE[7] || Bus2IP_RdCE[8] || Bus2IP_RdCE[9];

  // implement slave model register(s)
  always @( posedge Bus2IP_Clk )
    begin

      if ( Bus2IP_Resetn == 1'b0 )
        begin
          slv_reg0 <= 0;
          slv_reg1 <= 0;
//          slv_reg2 <= 0;
          slv_reg3 <= 0;
  //        slv_reg4 <= 0;
    //      slv_reg5 <= 0;
          slv_reg6 <= 0;
          slv_reg7 <= 0;
          slv_reg8 <= 0;
          slv_reg9 <= 0;
        end
      else
        case ( slv_reg_write_sel )
          10'b1000000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg0[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
          10'b0100000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg1[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
      /*    10'b0010000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg2[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
        */  10'b0001000000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg3[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
        /*  10'b0000100000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg4[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
          10'b0000010000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg5[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
        */  10'b0000001000 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg6[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
          10'b0000000100 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg7[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
          10'b0000000010 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg8[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
          10'b0000000001 :
            for ( byte_index = 0; byte_index <= (C_SLV_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                slv_reg9[(byte_index*8) +: 8] <= Bus2IP_Data[(byte_index*8) +: 8];
          default : begin
            slv_reg0 <= slv_reg0;
            slv_reg1 <= slv_reg1;
          //  slv_reg2 <= slv_reg2;
            slv_reg3 <= slv_reg3;
            //slv_reg4 <= slv_reg4;
            //slv_reg5 <= slv_reg5;
            slv_reg6 <= slv_reg6;
            slv_reg7 <= slv_reg7;
            slv_reg8 <= slv_reg8;
            slv_reg9 <= slv_reg9;
                    end
        endcase

    end // SLAVE_REG_WRITE_PROC

  // implement slave model register read mux
  always @( slv_reg_read_sel or slv_reg0 or slv_reg1 or slv_reg2 or slv_reg3 or slv_reg4 or slv_reg5 or slv_reg6 or slv_reg7 or slv_reg8 or slv_reg9 )
    begin 

      case ( slv_reg_read_sel )
        10'b1000000000 : slv_ip2bus_data <= slv_reg0;
        10'b0100000000 : slv_ip2bus_data <= slv_reg1;
        10'b0010000000 : slv_ip2bus_data <= slv_reg2;
        10'b0001000000 : slv_ip2bus_data <= slv_reg3;
        10'b0000100000 : slv_ip2bus_data <= slv_reg4;
        10'b0000010000 : slv_ip2bus_data <= slv_reg5;
        10'b0000001000 : slv_ip2bus_data <= slv_reg6;
        10'b0000000100 : slv_ip2bus_data <= slv_reg7;
        10'b0000000010 : slv_ip2bus_data <= slv_reg8;
        10'b0000000001 : slv_ip2bus_data <= slv_reg9;
        default : slv_ip2bus_data <= 0;
      endcase

    end // SLAVE_REG_READ_PROC

  // ------------------------------------------------------------
  // Example code to drive IP to Bus signals
  // ------------------------------------------------------------

  assign IP2Bus_Data    = (slv_read_ack == 1'b1) ? slv_ip2bus_data : 0;
  assign IP2Bus_WrAck   = slv_write_ack;
  assign IP2Bus_RdAck   = slv_read_ack;
  assign IP2Bus_Error   = 0;

//Design variables                                                                                  
wire write_enable_ext;                                                                              
wire [9:0]write_address;                                                                            
wire [9:0]read_address;                                                                             
wire [1:0] Current_State;                                                                           
     wire   [31:0]a_0000;                                                                           
     wire  [31:0]d_0000;                                                                            
     wire   [31:0]a_0001;                                                                           
     wire  [31:0]d_0001;                                                                            
     wire   [31:0]a_0002;                                                                           
     wire  [31:0]d_0002;                                                                            
     wire   [31:0]a_0003;                                                                           
     wire  [31:0]d_0003;                                                                            
     wire   [31:0]a_0004;                                                                           
     wire  [31:0]d_0004;                                                                            
     wire   [31:0]a_0005;                                                                           
     wire  [31:0]d_0005;                                                                            
     wire   [31:0]a_0006;                                                                           
     wire  [31:0]d_0006;                                                                            
     wire   [31:0]a_0007;                                                                           
     wire  [31:0]d_0007;                                                                            
     wire   [31:0]a_0008;                                                                           
     wire  [31:0]d_0008;                                                                            
     wire   [31:0]a_0009;                                                                           
     wire  [31:0]d_0009;                                                                            
     wire   [31:0]a_0010;                                                                           
     wire  [31:0]d_0010;                                                                            
     wire   [31:0]a_0011;                                                                           
     wire  [31:0]d_0011;                                                                            
     wire   [31:0]a_0012;                                                                           
     wire  [31:0]d_0012;                                                                            
     wire   [31:0]a_0013;                                                                           
     wire  [31:0]d_0013;                                                                            
     wire   [31:0]a_0014;                                                                           
     wire  [31:0]d_0014;                                                                            
     wire   [31:0]a_0015;                                                                           
     wire  [31:0]d_0015;                                                                            
// Signals from MicroBlaze                                                                          
wire [9:0] mb_addra = slv_reg1[9:0];                                                                
wire mb_web = slv_reg1[30];                                                                         
wire [9:0] mb_addrb = slv_reg1[19:10];                                                              
wire [9:0] b_no = slv_reg1[29:20]; // Bram Number ?                                                 
wire sig_start = slv_reg1[31];                                                                      
wire finish,reset_p;                                                                                
wire [10:0] iter_no;                                                                                
assign reset_p = slv_reg3[0]; 
reg mb_start;                                                                      
always@(posedge Bus2IP_Clk)                                                                         
begin                                                                                               
     mb_start <= sig_start;                                                                         
end                                                                                                 
always @( posedge Bus2IP_Clk ) begin                                                                
if ( reset_p ) begin                                                                                
slv_reg2 <= 0;                                                                                      
slv_reg4 <= 0;                                                                                      
slv_reg5 <= 0;                                                                                      
end                                                                                                 
else begin                                                                                          
slv_reg5 <= {10'd0,Current_State,write_address,read_address};                                        
slv_reg4 <= {13'd0,iter_no,7'd0,finish};                                                              
case(b_no)                                                                                          
     0 : slv_reg2 <= a_0000;                                                                        
     1 : slv_reg2 <= a_0001;                                                                        
     2 : slv_reg2 <= a_0002;                                                                        
     3 : slv_reg2 <= a_0003;                                                                        
     4 : slv_reg2 <= a_0004;                                                                        
     5 : slv_reg2 <= a_0005;                                                                        
     6 : slv_reg2 <= a_0006;                                                                        
     7 : slv_reg2 <= a_0007;                                                                        
     8 : slv_reg2 <= a_0008;                                                                        
     9 : slv_reg2 <= a_0009;                                                                        
     10 : slv_reg2 <= a_0010;                                                                       
     11 : slv_reg2 <= a_0011;                                                                       
     12 : slv_reg2 <= a_0012;                                                                       
     13 : slv_reg2 <= a_0013;                                                                       
     14 : slv_reg2 <= a_0014;                                                                       
     15 : slv_reg2 <= a_0015;                                                                       
    default : slv_reg2 <= 0;                                                                         
    endcase                                                                                         
end                                                                                                 
end                                                                                                 
reg [9:0]mux_addra_bram;                                                                            
always@(*) begin                                                                                    
if(mb_start)                                                                                        
     mux_addra_bram = read_address;                                                                 
else                                                                                                
     mux_addra_bram = mb_addra;                                                                     
end                                                                                                 
reg [9:0]mux_addrb_bram;                                                                            
always@(*) begin                                                                                    
if(mb_start)                                                                                        
     mux_addrb_bram = write_address;                                                                
else                                                                                                
     mux_addrb_bram = mb_addrb;                                                                     
end                                                                                                 
     reg [31:0]mux_dinb0,                                                                           
               mux_dinb1,                                                                           
               mux_dinb2,                                                                           
               mux_dinb3,                                                                           
               mux_dinb4,                                                                           
               mux_dinb5,                                                                           
               mux_dinb6,                                                                           
               mux_dinb7,                                                                           
               mux_dinb8,                                                                           
               mux_dinb9,                                                                           
               mux_dinb10,                                                                          
               mux_dinb11,                                                                          
               mux_dinb12,                                                                          
               mux_dinb13,                                                                          
               mux_dinb14,                                                                          
               mux_dinb15;                                                                          
always@(*) begin                                                                                    
if(mb_start) begin                                                                                  
     mux_dinb0 = d_0000;                                                                            
     mux_dinb1 = d_0001;                                                                            
     mux_dinb2 = d_0002;                                                                            
     mux_dinb3 = d_0003;                                                                            
     mux_dinb4 = d_0004;                                                                            
     mux_dinb5 = d_0005;                                                                            
     mux_dinb6 = d_0006;                                                                            
     mux_dinb7 = d_0007;                                                                            
     mux_dinb8 = d_0008;                                                                            
     mux_dinb9 = d_0009;                                                                            
     mux_dinb10 = d_0010;                                                                           
     mux_dinb11 = d_0011;                                                                           
     mux_dinb12 = d_0012;                                                                           
     mux_dinb13 = d_0013;                                                                           
     mux_dinb14 = d_0014;                                                                           
     mux_dinb15 = d_0015;                                                                           
end                                                                                                 
else begin                                                                                          
     mux_dinb0 = slv_reg0;                                                                          
     mux_dinb1 = slv_reg0;                                                                          
     mux_dinb2 = slv_reg0;                                                                          
     mux_dinb3 = slv_reg0;                                                                          
     mux_dinb4 = slv_reg0;                                                                          
     mux_dinb5 = slv_reg0;                                                                          
     mux_dinb6 = slv_reg0;                                                                          
     mux_dinb7 = slv_reg0;                                                                          
     mux_dinb8 = slv_reg0;                                                                          
     mux_dinb9 = slv_reg0;                                                                          
     mux_dinb10 = slv_reg0;                                                                         
     mux_dinb11 = slv_reg0;                                                                         
     mux_dinb12 = slv_reg0;                                                                         
     mux_dinb13 = slv_reg0;                                                                         
     mux_dinb14 = slv_reg0;                                                                         
     mux_dinb15 = slv_reg0;                                                                         
    end                                                                                             
end                                                                                                 
     reg mux_web0,                                                                                  
               mux_web1,                                                                            
               mux_web2,                                                                            
               mux_web3,                                                                            
               mux_web4,                                                                            
               mux_web5,                                                                            
               mux_web6,                                                                            
               mux_web7,                                                                            
               mux_web8,                                                                            
               mux_web9,                                                                            
               mux_web10,                                                                           
               mux_web11,                                                                           
               mux_web12,                                                                           
               mux_web13,                                                                           
               mux_web14,                                                                           
               mux_web15;                                                                           
always@(*) begin                                                                                    
if(mb_start) begin                                                                                  
     mux_web0 = write_enable_ext;                                                                   
     mux_web1 = write_enable_ext;                                                                   
     mux_web2 = write_enable_ext;                                                                   
     mux_web3 = write_enable_ext;                                                                   
     mux_web4 = write_enable_ext;                                                                   
     mux_web5 = write_enable_ext;                                                                   
     mux_web6 = write_enable_ext;                                                                   
     mux_web7 = write_enable_ext;                                                                   
     mux_web8 = write_enable_ext;                                                                   
     mux_web9 = write_enable_ext;                                                                   
     mux_web10 = write_enable_ext;                                                                  
     mux_web11 = write_enable_ext;                                                                  
     mux_web12 = write_enable_ext;                                                                  
     mux_web13 = write_enable_ext;                                                                  
     mux_web14 = write_enable_ext;                                                                  
     mux_web15 = write_enable_ext;                                                                  
end                                                                                                 
else begin                                                                                          
case(b_no)                                                                                          
0 : begin                                                                                           
mux_web0 = mb_web;                                                                                  
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
1 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = mb_web;                                                                                  
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
2 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = mb_web;                                                                                  
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
3 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = mb_web;                                                                                  
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
4 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = mb_web;                                                                                  
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
5 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = mb_web;                                                                                  
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
6 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = mb_web;                                                                                  
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
7 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = mb_web;                                                                                  
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
8 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = mb_web;                                                                                  
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
9 : begin                                                                                           
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = mb_web;                                                                                  
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
10 : begin                                                                                          
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = mb_web;                                                                                 
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
11 : begin                                                                                          
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = mb_web;                                                                                 
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
12 : begin                                                                                          
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = mb_web;                                                                                 
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
13 : begin                                                                                          
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = mb_web;                                                                                 
mux_web14 = 0;                                                                                      
mux_web15 = 0;                                                                                      
end                                                                                                 
14 : begin                                                                                          
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = mb_web;                                                                                 
mux_web15 = 0;                                                                                      
end                                                                                                 
15 : begin                                                                                          
mux_web0 = 0;                                                                                       
mux_web1 = 0;                                                                                       
mux_web2 = 0;                                                                                       
mux_web3 = 0;                                                                                       
mux_web4 = 0;                                                                                       
mux_web5 = 0;                                                                                       
mux_web6 = 0;                                                                                       
mux_web7 = 0;                                                                                       
mux_web8 = 0;                                                                                       
mux_web9 = 0;                                                                                       
mux_web10 = 0;                                                                                      
mux_web11 = 0;                                                                                      
mux_web12 = 0;                                                                                      
mux_web13 = 0;                                                                                      
mux_web14 = 0;                                                                                      
mux_web15 = mb_web;                                                                                 
end                                                                                                 
default : begin                                                                                     
     mux_web0 = 0;                                                                                  
     mux_web1 = 0;                                                                                  
     mux_web2 = 0;                                                                                  
     mux_web3 = 0;                                                                                  
     mux_web4 = 0;                                                                                  
     mux_web5 = 0;                                                                                  
     mux_web6 = 0;                                                                                  
     mux_web7 = 0;                                                                                  
     mux_web8 = 0;                                                                                  
     mux_web9 = 0;                                                                                  
     mux_web10 = 0;                                                                                 
     mux_web11 = 0;                                                                                 
     mux_web12 = 0;                                                                                 
     mux_web13 = 0;                                                                                 
     mux_web14 = 0;                                                                                 
     mux_web15 = 0;                                                                                 
end                                                                                                 
endcase                                                                                             
end                                                                                                 
end                                                                                                 
     BRAM_0 bram_0(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0000),                                                                                
     .dinb(mux_dinb0),                                                                              
     .doutb(d0),                                                                                    
     .web(mux_web0),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_1(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0001),                                                                                
     .dinb(mux_dinb1),                                                                              
     .doutb(d1),                                                                                    
     .web(mux_web1),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_2(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0002),                                                                                
     .dinb(mux_dinb2),                                                                              
     .doutb(d2),                                                                                    
     .web(mux_web2),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_3(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0003),                                                                                
     .dinb(mux_dinb3),                                                                              
     .doutb(d3),                                                                                    
     .web(mux_web3),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_4(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0004),                                                                                
     .dinb(mux_dinb4),                                                                              
     .doutb(d4),                                                                                    
     .web(mux_web4),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_5(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0005),                                                                                
     .dinb(mux_dinb5),                                                                              
     .doutb(d5),                                                                                    
     .web(mux_web5),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_6(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0006),                                                                                
     .dinb(mux_dinb6),                                                                              
     .doutb(d6),                                                                                    
     .web(mux_web6),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_7(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0007),                                                                                
     .dinb(mux_dinb7),                                                                              
     .doutb(d7),                                                                                    
     .web(mux_web7),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_8(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0008),                                                                                
     .dinb(mux_dinb8),                                                                              
     .doutb(d8),                                                                                    
     .web(mux_web8),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_9(                                                                                 
     .addra(mux_addra_bram),                                                                        
     .douta(a_0009),                                                                                
     .dinb(mux_dinb9),                                                                              
     .doutb(d9),                                                                                    
     .web(mux_web9),                                                                                
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_10(                                                                                
     .addra(mux_addra_bram),                                                                        
     .douta(a_0010),                                                                                
     .dinb(mux_dinb10),                                                                             
     .doutb(d10),                                                                                   
     .web(mux_web10),                                                                               
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_11(                                                                                
     .addra(mux_addra_bram),                                                                        
     .douta(a_0011),                                                                                
     .dinb(mux_dinb11),                                                                             
     .doutb(d11),                                                                                   
     .web(mux_web11),                                                                               
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_12(                                                                                
     .addra(mux_addra_bram),                                                                        
     .douta(a_0012),                                                                                
     .dinb(mux_dinb12),                                                                             
     .doutb(d12),                                                                                   
     .web(mux_web12),                                                                               
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_13(                                                                                
     .addra(mux_addra_bram),                                                                        
     .douta(a_0013),                                                                                
     .dinb(mux_dinb13),                                                                             
     .doutb(d13),                                                                                   
     .web(mux_web13),                                                                               
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_14(                                                                                
     .addra(mux_addra_bram),                                                                        
     .douta(a_0014),                                                                                
     .dinb(mux_dinb14),                                                                             
     .doutb(d14),                                                                                   
     .web(mux_web14),                                                                               
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
     BRAM_0 bram_15(                                                                                
     .addra(mux_addra_bram),                                                                        
     .douta(a_0015),                                                                                
     .dinb(mux_dinb15),                                                                             
     .doutb(d15),                                                                                   
     .web(mux_web15),                                                                               
   .clka(Bus2IP_Clk),.clkb(Bus2IP_Clk),.wea(0),.dina(0),.addrb(mux_addrb_bram));                    
TheProcessingBlock BF( .start(mb_start), .clk(Bus2IP_Clk), .rst_global(reset_p),                    
                       .read_address(read_address),.write_address(write_address),                   
                       .iter_no(iter_no),.Current_State(Current_State),                             
                       .write_enable_ext(write_enable_ext),.finish(finish),                         
     .a_0000(a_0000),.d_0000(d_0000),                                                               
     .a_0001(a_0001),.d_0001(d_0001),                                                               
     .a_0002(a_0002),.d_0002(d_0002),                                                               
     .a_0003(a_0003),.d_0003(d_0003),                                                               
     .a_0004(a_0004),.d_0004(d_0004),                                                               
     .a_0005(a_0005),.d_0005(d_0005),                                                               
     .a_0006(a_0006),.d_0006(d_0006),                                                               
     .a_0007(a_0007),.d_0007(d_0007),                                                               
     .a_0008(a_0008),.d_0008(d_0008),                                                               
     .a_0009(a_0009),.d_0009(d_0009),                                                               
     .a_0010(a_0010),.d_0010(d_0010),                                                               
     .a_0011(a_0011),.d_0011(d_0011),                                                               
     .a_0012(a_0012),.d_0012(d_0012),                                                               
     .a_0013(a_0013),.d_0013(d_0013),                                                               
     .a_0014(a_0014),.d_0014(d_0014),                                                               
     .a_0015(a_0015),.d_0015(d_0015));                                                              
                                                              

endmodule
