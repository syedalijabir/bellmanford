`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:44 04/07/2012 
// Design Name: 
// Module Name:    DesignCounterBlock 
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
module CounterBlock(input rst_global, read_enable_global, clk, iteration_done,
								  output reg [1:0] step_counter, 
								  output reg phase_counter, 
								  output reg [10:0] iteration_counter,
								  output reg rollover_phase_counter,
								  output pre_rollover_phase_counter,
								  output finish);
reg read_enable_global_reg;
//-------------------------------------------------------------------------------
// COMPARATORS

wire cmpout_step_counter  = (step_counter == 2); // cmpout is comparator output
wire cmpout_phase_counter = (phase_counter == 1);
assign finish             = (iteration_counter >= 1500);
assign pre_rollover_phase_counter
                          = cmpout_phase_counter & cmpout_step_counter;

//-------------------------------------------------------------------------------
// Reset and Enable Generation  (or walay)
wire rst_local             = rst_global | read_enable_global     | read_enable_global_reg;
wire rst_step_counter      = rst_local  | rollover_phase_counter | cmpout_step_counter;  
wire rst_phase_counter     = rst_local  | rollover_phase_counter | cmpout_phase_counter & cmpout_step_counter;
wire rst_iteration_counter = rst_global;

wire enable_phase_counter     = cmpout_step_counter;
wire enable_iteration_counter = iteration_done; 								  

//-------------------------------------------------------------------------------
// Sequential part - Register to hold the read enable global signal
always@(posedge clk)
begin
	if (rst_global)
		read_enable_global_reg <= 0;
	else
		read_enable_global_reg <= read_enable_global; 
end

// COUNTERS-SEQUENTIAL PART
always@(posedge clk)
begin
	if (rst_step_counter)
		step_counter <= 0;
	else
		step_counter <= step_counter + 1; // +1 because counter is always enabled
end

always@(posedge clk)
begin
	if (rst_phase_counter)
		phase_counter <= 0;
	else
		phase_counter <= phase_counter + enable_phase_counter; 
end

always@(posedge clk)
begin
	if (rst_iteration_counter)
		iteration_counter <= 0;
	else
		iteration_counter <= iteration_counter + enable_iteration_counter;
		$display("Iteration #%d\n",iteration_counter);
end

//------------------------------------------------------------------------------
// Single Flip-Flop (delay element)
always@(posedge clk)
begin
	if (rst_local)
		rollover_phase_counter <= 0;
	else
		rollover_phase_counter <= cmpout_phase_counter & cmpout_step_counter;
end

endmodule
