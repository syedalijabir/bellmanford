module DRAM_ComputationalBlock( input clk, rst_global, read_enable_global, rollover_phase_counter, phase_counter,      
                                           input [1:0]step_counter,                                                    
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
parameter n=16;                                                     
                                                                    
 reg read_enable_global_reg;                                        
 wire read_enable = read_enable_global_reg | rollover_phase_counter;
 wire [31:0] Ao_0000;
 wire [31:0] Bo_0000;
 wire [31:0] Co_0000;
 wire [31:0] Do_0000;
 wire [31:0] Ao_0001;
 wire [31:0] Bo_0001;
 wire [31:0] Co_0001;
 wire [31:0] Do_0001;
 wire [31:0] Ao_0002;
 wire [31:0] Bo_0002;
 wire [31:0] Co_0002;
 wire [31:0] Do_0002;
 wire [31:0] Ao_0003;
 wire [31:0] Bo_0003;
 wire [31:0] Co_0003;
 wire [31:0] Do_0003;
 wire [31:0] Ao_0004;
 wire [31:0] Bo_0004;
 wire [31:0] Co_0004;
 wire [31:0] Do_0004;
 wire [31:0] Ao_0005;
 wire [31:0] Bo_0005;
 wire [31:0] Co_0005;
 wire [31:0] Do_0005;
 wire [31:0] Ao_0006;
 wire [31:0] Bo_0006;
 wire [31:0] Co_0006;
 wire [31:0] Do_0006;
 wire [31:0] Ao_0007;
 wire [31:0] Bo_0007;
 wire [31:0] Co_0007;
 wire [31:0] Do_0007;
//----------------------------------------------------------------------
// Read enable global register                                          
                                                                        
always@(posedge clk)                                                    
begin                                                                   
   if (rst_global)                                                      
       read_enable_global_reg <= 0;                                     
   else                                                                 
       read_enable_global_reg <= read_enable_global;                    
end                                                                     
                                                                        
// Block RAM-1                                                          
reg [31:0]dram1[0:n-1];                                                 
integer i;                                                              
always@(posedge clk )                                                   
begin                                                                   
   if (rst_global)                                                      
   begin                                                                
       for (i=0; i<n; i=i+1)                                            
           dram1[i] <= 0;                                               
   end                                                                  
   else                                                                 
   begin                                                                
       if (read_enable)                                                 
       begin                                                            
          dram1[0000] <= a_0000;
          dram1[0001] <= a_0001;
          dram1[0002] <= a_0002;
          dram1[0003] <= a_0003;
          dram1[0004] <= a_0004;
          dram1[0005] <= a_0005;
          dram1[0006] <= a_0006;
          dram1[0007] <= a_0007;
          dram1[0008] <= a_0008;
          dram1[0009] <= a_0009;
          dram1[0010] <= a_0010;
          dram1[0011] <= a_0011;
          dram1[0012] <= a_0012;
          dram1[0013] <= a_0013;
          dram1[0014] <= a_0014;
          dram1[0015] <= a_0015;
       end                                                     
       else                                                    
       begin                                                   
           dram1[0000] <= phase_counter ? dram1[0000]: Ao_0000;
           dram1[0001] <= phase_counter ? Ao_0000    : Co_0000;
           dram1[0002] <= phase_counter ? Co_0000    : Ao_0001;
           dram1[0003] <= phase_counter ? Ao_0001    : Co_0001;
           dram1[0004] <= phase_counter ? Co_0001    : Ao_0002;
           dram1[0005] <= phase_counter ? Ao_0002    : Co_0002;
           dram1[0006] <= phase_counter ? Co_0002    : Ao_0003;
           dram1[0007] <= phase_counter ? Ao_0003    : Co_0003;
           dram1[0008] <= phase_counter ? Co_0003    : Ao_0004;
           dram1[0009] <= phase_counter ? Ao_0004    : Co_0004;
           dram1[0010] <= phase_counter ? Co_0004    : Ao_0005;
           dram1[0011] <= phase_counter ? Ao_0005    : Co_0005;
           dram1[0012] <= phase_counter ? Co_0005    : Ao_0006;
           dram1[0013] <= phase_counter ? Ao_0006    : Co_0006;
           dram1[0014] <= phase_counter ? Co_0006    : Ao_0007;
           dram1[0015] <= phase_counter ? dra1[00015]: Co_0007;
      	end                                                                     
   end                                                                         
end                                                                            
                                                                               
//--------------------------------------------------------------------------   
// Block RAM-2                                                                 
reg [31:0]dram2[0:n-1];                                                        
integer j,k;                                                                   
always@(posedge clk)                                                           
begin                                                                          
   if (rst_global)                                                             
   begin                                                                       
       for (j=0; j<n; j=j+1)                                                   
           dram2[j] <= 0;                                                      
   end                                                                         
   else                                                                        
   begin                                                                       
       if (read_enable)                                                        
           begin                                                               
           for (k=0; k<n; k=k+1)                                               
           dram2[k] <= dram1[k];                                               
           end                                                                 
       else                                                                    
       begin                                                    // From Figure 
           dram2[0000] <= phase_counter ? dram2[0000]: Bo_0000;  // X3         
           dram2[0001] <= phase_counter ? Bo_0000    : Do_0000;
           dram2[0002] <= phase_counter ? Do_0000    : Bo_0001;
           dram2[0003] <= phase_counter ? Bo_0001    : Do_0001;
           dram2[0004] <= phase_counter ? Do_0001    : Bo_0002;
           dram2[0005] <= phase_counter ? Bo_0002    : Do_0002;
           dram2[0006] <= phase_counter ? Do_0002    : Bo_0003;
           dram2[0007] <= phase_counter ? Bo_0003    : Do_0003;
           dram2[0008] <= phase_counter ? Do_0003    : Bo_0004;
           dram2[0009] <= phase_counter ? Bo_0004    : Do_0004;
           dram2[0010] <= phase_counter ? Do_0004    : Bo_0005;
           dram2[0011] <= phase_counter ? Bo_0005    : Do_0005;
           dram2[0012] <= phase_counter ? Do_0005    : Bo_0006;
           dram2[0013] <= phase_counter ? Bo_0006    : Do_0006;
           dram2[0014] <= phase_counter ? Do_0006    : Bo_0007;
           dram2[0015] <= phase_counter ? dra2[00015]: Do_0007;
       end                                                               
   end                                                                   
end                                                                      
                                                                         
//-----------------------------------------------------------------------
// Computational Block Merged                                            
 
//-----------------------------------------------
 
                                                  
 Level1CU                  L1CU_0000(             
                    .a_in(dram1[0000]),           
                    .b_in(dram2[0000]),           
                    .c_in(dram1[0001]),           
                    .d_in(dram2[0001]),           
                    .e_in(dram1[0002]),           
                    .f_in(dram2[0002]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0000),            
                         .Bo(Bo_0000),            
                         .Co(Co_0000),            
                         .Do(Do_0000));           
                                                  
 Level1CU                  L1CU_0001(             
                    .a_in(dram1[0002]),           
                    .b_in(dram2[0002]),           
                    .c_in(dram1[0003]),           
                    .d_in(dram2[0003]),           
                    .e_in(dram1[0004]),           
                    .f_in(dram2[0004]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0001),            
                         .Bo(Bo_0001),            
                         .Co(Co_0001),            
                         .Do(Do_0001));           
                                                  
 Level1CU                  L1CU_0002(             
                    .a_in(dram1[0004]),           
                    .b_in(dram2[0004]),           
                    .c_in(dram1[0005]),           
                    .d_in(dram2[0005]),           
                    .e_in(dram1[0006]),           
                    .f_in(dram2[0006]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0002),            
                         .Bo(Bo_0002),            
                         .Co(Co_0002),            
                         .Do(Do_0002));           
                                                  
 Level1CU                  L1CU_0003(             
                    .a_in(dram1[0006]),           
                    .b_in(dram2[0006]),           
                    .c_in(dram1[0007]),           
                    .d_in(dram2[0007]),           
                    .e_in(dram1[0008]),           
                    .f_in(dram2[0008]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0003),            
                         .Bo(Bo_0003),            
                         .Co(Co_0003),            
                         .Do(Do_0003));           
                                                  
 Level1CU                  L1CU_0004(             
                    .a_in(dram1[0008]),           
                    .b_in(dram2[0008]),           
                    .c_in(dram1[0009]),           
                    .d_in(dram2[0009]),           
                    .e_in(dram1[0010]),           
                    .f_in(dram2[0010]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0004),            
                         .Bo(Bo_0004),            
                         .Co(Co_0004),            
                         .Do(Do_0004));           
                                                  
 Level1CU                  L1CU_0005(             
                    .a_in(dram1[0010]),           
                    .b_in(dram2[0010]),           
                    .c_in(dram1[0011]),           
                    .d_in(dram2[0011]),           
                    .e_in(dram1[0012]),           
                    .f_in(dram2[0012]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0005),            
                         .Bo(Bo_0005),            
                         .Co(Co_0005),            
                         .Do(Do_0005));           
                                                  
 Level1CU                  L1CU_0006(             
                    .a_in(dram1[0012]),           
                    .b_in(dram2[0012]),           
                    .c_in(dram1[0013]),           
                    .d_in(dram2[0013]),           
                    .e_in(dram1[0014]),           
                    .f_in(dram2[0014]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0006),            
                         .Bo(Bo_0006),            
                         .Co(Co_0006),            
                         .Do(Do_0006));           
                                                  
 Level1CU                  L1CU_0007(             
                    .a_in(dram1[0014]),           
                    .b_in(dram2[0014]),           
                    .c_in(dram1[0015]),           
                    .d_in(dram2[0015]),           
                    .e_in(0),                     
                    .f_in(0),                     
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0007),            
                         .Bo(Bo_0007),            
                         .Co(Co_0007),            
                         .Do(Do_0007));           
 
//-----------------------------------------------
 
 assign    d_0000 = dram2[0000];
 assign    d_0001 = dram2[0001];
 assign    d_0002 = dram2[0002];
 assign    d_0003 = dram2[0003];
 assign    d_0004 = dram2[0004];
 assign    d_0005 = dram2[0005];
 assign    d_0006 = dram2[0006];
 assign    d_0007 = dram2[0007];
 assign    d_0008 = dram2[0008];
 assign    d_0009 = dram2[0009];
 assign    d_0010 = dram2[0010];
 assign    d_0011 = dram2[0011];
 assign    d_0012 = dram2[0012];
 assign    d_0013 = dram2[0013];
 assign    d_0014 = dram2[0014];
 assign    d_0015 = dram2[0015];
 
//-----------------------------------------------
 
endmodule
