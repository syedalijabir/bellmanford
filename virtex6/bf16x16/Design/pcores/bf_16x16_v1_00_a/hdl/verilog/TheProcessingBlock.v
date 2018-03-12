module TheProcessingBlock( input  start, clk, rst_global,                                                              
                          output[9:0] read_address,write_address,                                                      
                          output write_enable_ext,
								  output [10:0]iter_no,output [1:0]Current_State,
                          output finish,                                                                               
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
                                           output[31:0] d_0007, 
                                           input [31:0] a_0008, 
                                           output[31:0] d_0008, 
                                           input [31:0] a_0009, 
                                           output[31:0] d_0009, 
                                           input [31:0] a_0010, 
                                           output[31:0] d_0010, 
                                           input [31:0] a_0011, 
                                           output[31:0] d_0011, 
                                           input [31:0] a_0012, 
                                           output[31:0] d_0012, 
                                           input [31:0] a_0013, 
                                           output[31:0] d_0013, 
                                           input [31:0] a_0014, 
                                           output[31:0] d_0014, 
                                           input [31:0] a_0015, 
                                           output[31:0] d_0015);
// module interconnection wires                                                  
wire read_enable_cu;                                                             
wire write_enable_cu;                                                            
wire iteration_done;                                                             
wire rollover_phase_counter;                                                     
wire pre_rollover_phase_counter;                                                 
                                                                                 
DATAPATH        DP (.write_enable(write_enable_cu),                              
                .read_enable(read_enable_cu),                                    
                .iteration_done(iteration_done),                                 
                .rst_global(rst_global),
					 .iteration_counter(iter_no),
                .clk(clk),                                                       
                .write_enable_ext(write_enable_ext),                             
                .finish(finish),                                                 
                .pre_rollover_phase_counter(pre_rollover_phase_counter),         
                .rollover_phase_counter(rollover_phase_counter),                 
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
                           .d_0007(d_0007), 
                           .a_0008(a_0008), 
                           .d_0008(d_0008), 
                           .a_0009(a_0009), 
                           .d_0009(d_0009), 
                           .a_0010(a_0010), 
                           .d_0010(d_0010), 
                           .a_0011(a_0011), 
                           .d_0011(d_0011), 
                           .a_0012(a_0012), 
                           .d_0012(d_0012), 
                           .a_0013(a_0013), 
                           .d_0013(d_0013), 
                           .a_0014(a_0014), 
                           .d_0014(d_0014), 
                           .a_0015(a_0015), 
                           .d_0015(d_0015));
                                                                                 
AGU agr (.rst_global    (rst_global),                                            
           .clk           (clk),                                                 
           .write_enable_cu  (write_enable_cu),                                  
           .read_enable_cu   (read_enable_cu),                                   
           .rollover_phase_counter (rollover_phase_counter),                     
           .pre_rollover_phase_counter(pre_rollover_phase_counter),              
           .iteration_done(iteration_done),                                      
           .read_address  (read_address),                                        
           .write_address (write_address) );                                     
                                                                                 
TheController Cont ( .iteration_done_agu (iteration_done),                       
                           .finish         (finish),                             
                           .start          (start),
									.Current_State(Current_State),
                           .rst_global     (rst_global),                         
                           .clk            (clk),                                
                           .write_enable   (write_enable_cu),                    
                           .read_enable    (read_enable_cu));                    
endmodule                                                                        