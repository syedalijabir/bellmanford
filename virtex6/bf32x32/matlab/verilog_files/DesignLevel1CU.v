`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:40:02 04/07/2012 
// Design Name: 
// Module Name:    DesignLevel1CU 
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
module Level1CU(input [31:0] a_in,b_in,c_in,d_in,e_in,f_in,
					 input phase_counter,
					 input [1:0] step_counter,
					 output[31:0] Ao,Bo,Co,Do);

reg [31:0] A,B,C,D;
//------------------------------------------
// First mux - A
always@(*)
begin
	case(phase_counter)
		1'b0 : A = a_in;
		1'b1 : A = c_in;
		default : A = a_in;
	endcase
end
//------------------------------------------
// 2nd mux - C
always@(*)
begin
	case(phase_counter)
		1'b0 : C = c_in;
		1'b1 : C = e_in;
		default : C = c_in;
	endcase
end
//------------------------------------------
// Third mux - B
always@(*)
begin
	case(phase_counter)
		1'b0 : B = b_in;
		1'b1 : B = d_in;
		default : B = b_in;
	endcase
end
//------------------------------------------
// First mux - D
always@(*)
begin
	case(phase_counter)
		1'b0 : D = d_in;
		1'b1 : D = f_in;
		default : D = d_in;
	endcase
end
//------------------------------------------

Level2CU L2CU_1(.A(A),.B(B),.C(C),.D(D),
					.step_counter(step_counter),
					.Ao(Ao),.Bo(Bo),.Co(Co),.Do(Do));

endmodule
