`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:02 04/07/2012 
// Design Name: 
// Module Name:    DesignLevel2CU 
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
module Level2CU( input [31:0] A,B,C,D, 
							  input [1:0] step_counter, 
							  output reg [31:0]Ao,Bo,Co,Do);
//-----------------------------------------------------------------------
// PE1
// Source Mux
reg [31:0] PE1_S;					  
always@(*)
begin
	case(step_counter)
	2'b01: PE1_S = {3'b000,A[28:0]};
	2'b00: PE1_S = {3'b010,A[28:0]};
	2'b10: PE1_S = {3'b001,A[28:0]};
	default: PE1_S = 0;
	endcase
end

// Target Mux
reg [31:0] PE1_T;					  
always@(*)
begin
	case(step_counter)
	2'b01: PE1_T = B;
	2'b00: PE1_T = C;
	2'b10: PE1_T = D;
	default: PE1_T = 0;
	endcase
end

// Instantiation of PE1
wire [31:0] PE1_Tdash; // Output
PE PE1(.S(PE1_S), .T(PE1_T), .T_dash(PE1_Tdash));

//-----------------------------------------------------------------------
// PE2
// Source Mux
reg [31:0] PE2_S;					  
always@(*)
begin
	case(step_counter)
	2'b01: PE2_S = {3'b100,B[28:0]};
	2'b00: PE2_S = {3'b110,C[28:0]};
	2'b10: PE2_S = {3'b101,D[28:0]};
	default: PE2_S = 0;
	endcase
end

// Target Mux
reg [31:0] PE2_T;					  
always@(*)
begin
	case(step_counter)
	2'b01: PE2_T = A;
	2'b00: PE2_T = A;
	2'b10: PE2_T = A;
	default: PE2_T = A;
	endcase
end

// Instantiation of PE2
wire [31:0] PE2_Tdash; // Output
PE PE2(.S(PE2_S), .T(PE2_T), .T_dash(PE2_Tdash));

//-----------------------------------------------------------------------
// PE3
// Source Mux
reg [31:0] PE3_S;					  
always@(*)
begin
	case(step_counter)
	2'b01: PE3_S = {3'b000,C[28:0]};
	2'b00: PE3_S = {3'b010,B[28:0]};
	2'b10: PE3_S = {3'b111,C[28:0]};
	default: PE3_S = 0;
	endcase
end

// Target Mux
reg [31:0] PE3_T;					  
always@(*)
begin
	case(step_counter)
	2'b01: PE3_T = D;
	2'b00: PE3_T = D;
	2'b10: PE3_T = B;
	default: PE3_T = 0;
	endcase
end

// Instantiation of PE3
wire [31:0] PE3_Tdash; // Output
PE PE3(.S(PE3_S), .T(PE3_T), .T_dash(PE3_Tdash));

//-----------------------------------------------------------------------
// PE4
// Source Mux
reg [31:0] PE4_S;					  
always@(*)
begin
	case(step_counter)
	2'b01: PE4_S = {3'b100,D[28:0]};
	2'b00: PE4_S = {3'b110,D[28:0]};
	2'b10: PE4_S = {3'b011,B[28:0]};
	default: PE4_S = 0;
	endcase
end

// Target Mux
reg [31:0] PE4_T;					  
always@(*)
begin
	case(step_counter)
	2'b01: PE4_T = C;
	2'b00: PE4_T = B;
	2'b10: PE4_T = C;
	default: PE4_T = 0;
	endcase
end

// Instantiation of PE4
wire [31:0] PE4_Tdash; // Output
PE PE4(.S(PE4_S), .T(PE4_T), .T_dash(PE4_Tdash));


//-------------------------------------------------------------------
// Output Stage Muxes

// Bo

always@(*)
begin
	case(step_counter)
	2'b01: Bo = PE1_Tdash;
	2'b00: Bo = PE4_Tdash;
	2'b10: Bo = PE3_Tdash;
	default: Bo = 0;
	endcase
end

// Ao
always@(*)
begin
	Ao = PE2_Tdash;
end

// Do
always@(*)
begin
	case(step_counter)
	2'b01: Do = PE3_Tdash;
	2'b00: Do = PE3_Tdash;
	2'b10: Do = PE1_Tdash;
	default: Do = 0;
	endcase
end

// Co
always@(*)
begin
	case(step_counter)
	2'b01: Co = PE4_Tdash;
	2'b00: Co = PE1_Tdash;
	2'b10: Co = PE4_Tdash;
	default: Co = 0;
	endcase
end

/*
//-------------------------------------------------------------------
// Output Stage Muxes

// Bo

always@(*)
begin
	case(step_counter)
	2'b00: Bo = PE1_Tdash;
	2'b01: Bo = PE4_Tdash;
	2'b10: Bo = PE3_Tdash;
	default: Bo = 0;
	endcase
end

// Ao
always@(*)
begin
	Ao = PE2_Tdash;
end

// Do
always@(*)
begin
	case(step_counter)
	2'b00: Do = PE3_Tdash;
	2'b01: Do = PE3_Tdash;
	2'b10: Do = PE1_Tdash;
	default: Do = 0;
	endcase
end

// Co
always@(*)
begin
	case(step_counter)
	2'b00: Co = PE4_Tdash;
	2'b01: Co = PE1_Tdash;
	2'b10: Co = PE4_Tdash;
	default: Co = 0;
	endcase
end
*/
endmodule
