`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:39:13 04/08/2012 
// Design Name: 
// Module Name:    TheController 
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
module TheController(input iteration_done_agu, finish, start, rst_global,
							clk, output reg [1:0]Current_State,
							output reg write_enable, read_enable);

wire iteration_done =iteration_done_agu ;
/*reg iteration_done;

always@(posedge clk)
	if(rst_global)
		iteration_done <= 0;
	else
		iteration_done <= iteration_done_agu;
*/
parameter IDLE_STATE = 2'b00,
			 INIT_STATE = 2'b01,
			 PROC_STATE = 2'b11,
			 WAIT_STATE = 2'b10;

reg[1:0]    Next_State; 			 
//reg[1:0] Current_State; 			 
wire [3:0] input_signal = {iteration_done, finish, start};
//----------------------------------------
// Combinational part
always@(*)
begin
	case(Current_State)
	IDLE_STATE:
		begin
			if(!start)
				begin
				Next_State   = IDLE_STATE;
				write_enable = 0;
				read_enable  = 0;
				end
			else
				begin
				Next_State   = INIT_STATE;
				write_enable = 0;
				read_enable  = 1;
				end
		end
	INIT_STATE:
		begin
				Next_State 	 = WAIT_STATE;
				write_enable = 0;
				read_enable  = 1;
		end
	WAIT_STATE:
		begin
				Next_State 	 = PROC_STATE;
				write_enable = 0;
				read_enable  = 0;
		end	
		
	PROC_STATE:
		begin
			if(finish)
				begin
				Next_State   = IDLE_STATE;
				write_enable = 0;
				read_enable  = 0;
				end
			else
				begin
				if(iteration_done)
					begin
					Next_State   = WAIT_STATE;
					write_enable = 1;
					read_enable  = 1;	
					end
				else
					begin
					Next_State   = PROC_STATE;
					write_enable = 0;
					read_enable  = 0;	
					end
				end
		end
	default:
		begin
				Next_State   = IDLE_STATE;
				write_enable = 0;
				read_enable  = 0;
		end
	endcase
end
//---------------------------------------
//Sequential part
always@(posedge clk)
begin
	if(rst_global)
		Current_State <= IDLE_STATE;
	else
		Current_State <= Next_State;
end
endmodule
