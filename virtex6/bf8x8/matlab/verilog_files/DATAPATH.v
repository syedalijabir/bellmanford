module DATAPATH(input  write_enable, read_enable, iteration_done, rst_global, clk,                                     
                  output write_enable_ext, finish, rollover_phase_counter, pre_rollover_phase_counter,                 
                                           input [31:0] a_0000, 
                                           output[31:0] d_0000, 
                                           input [31:0] a_0001, 
                                           output[31:0] d_0001, 
                                           input [31:0] a_0002, 
                                           output[31:0] d_0002, 
                                           input [31:0] a_0003, 
                                           output[31:0] d_0003, 
                                           input [31:0] a_0004, 
                                           output[31:0] d_0004, 
                                           input [31:0] a_0005, 
                                           output[31:0] d_0005, 
                                           input [31:0] a_0006, 
                                           output[31:0] d_0006, 
                                           input [31:0] a_0007, 
                                           output[31:0] d_0007);
                                                                                        
// intermodul connection wire                                                           
wire       phase_counter;                                                               
wire [1:0] step_counter;                                                                
wire [10:0]iteration_counter;                                                           
                                                                                        
assign write_enable_ext = write_enable | rollover_phase_counter;                        
                                                                                        
CounterBlock CB ( .rst_global (rst_global), .clk(clk),                                  
                       .read_enable_global     (read_enable),                           
                       .iteration_done         (iteration_done),                        
                       .step_counter           (step_counter),                          
                       .phase_counter          (phase_counter),                         
                       .iteration_counter      (iteration_counter),                     
                       .rollover_phase_counter (rollover_phase_counter),                
                       .pre_rollover_phase_counter(pre_rollover_phase_counter),         
                       .finish                 (finish));                               
                                                                                        
DRAM_ComputationalBlock        DCB(.clk(clk), .rst_global  (rst_global),                
                            .read_enable_global     (read_enable),                      
                            .rollover_phase_counter (rollover_phase_counter),           
                            .phase_counter          (phase_counter),                    
                            .step_counter           (step_counter),                     
                           .a_0000(a_0000), 
                           .d_0000(d_0000), 
                           .a_0001(a_0001), 
                           .d_0001(d_0001), 
                           .a_0002(a_0002), 
                           .d_0002(d_0002), 
                           .a_0003(a_0003), 
                           .d_0003(d_0003), 
                           .a_0004(a_0004), 
                           .d_0004(d_0004), 
                           .a_0005(a_0005), 
                           .d_0005(d_0005), 
                           .a_0006(a_0006), 
                           .d_0006(d_0006), 
                           .a_0007(a_0007), 
                           .d_0007(d_0007));
                                                                                 
endmodule                                                                        
