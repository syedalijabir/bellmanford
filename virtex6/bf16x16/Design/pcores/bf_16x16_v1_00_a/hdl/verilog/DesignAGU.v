`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:42:32 04/11/2012 
// Design Name: 
// Module Name:    DesignAGU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AGU( input rst_global, clk, write_enable_cu, read_enable_cu, rollover_phase_counter,pre_rollover_phase_counter,
				output iteration_done,
				output reg [9:0] read_address, write_address ); // assumming 1024 deep DRAMs


parameter number_of_columns = 16; 				// Assuming width of 768

wire read_enable  = read_enable_cu  | pre_rollover_phase_counter;
wire write_enable = write_enable_cu | rollover_phase_counter;

wire   read_end 		 = (read_address == number_of_columns - 1);
wire  write_end 		 = (write_address == number_of_columns - 1); // when it reached last possible address

wire rst_read         = rst_global | read_end   & read_enable;
wire rst_write        = rst_global | write_end  ;//& write_enable_cu ; 

// the write address needs to be reset as soon as it reaches the end, so no need to wait for phasw counter rollover;

assign iteration_done = write_end ;//& write_enable;	
/*
always@(posedge clk)
	if(rst_global)
		iteration_done <=0;
	else
		iteration_done <= write_end & write_enable;	
*/

always@(posedge clk)
	if(rst_read)
		read_address  <= 0 ;
	else
		if(read_enable)
			read_address  <= read_address + 1 ;
		else
			read_address  <= read_address;
		
		
always@(posedge clk)
	if(rst_write)
		write_address <= 0 ;
	else
		if(write_enable)
			write_address  <= write_address + 1 ;
		else
			write_address  <= write_address;
		
		
		
endmodule
