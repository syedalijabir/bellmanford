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
                                           output[31:0] d_0015, 
                                           input [31:0] a_0016, 
                                           output[31:0] d_0016, 
                                           input [31:0] a_0017, 
                                           output[31:0] d_0017, 
                                           input [31:0] a_0018, 
                                           output[31:0] d_0018, 
                                           input [31:0] a_0019, 
                                           output[31:0] d_0019, 
                                           input [31:0] a_0020, 
                                           output[31:0] d_0020, 
                                           input [31:0] a_0021, 
                                           output[31:0] d_0021, 
                                           input [31:0] a_0022, 
                                           output[31:0] d_0022, 
                                           input [31:0] a_0023, 
                                           output[31:0] d_0023, 
                                           input [31:0] a_0024, 
                                           output[31:0] d_0024, 
                                           input [31:0] a_0025, 
                                           output[31:0] d_0025, 
                                           input [31:0] a_0026, 
                                           output[31:0] d_0026, 
                                           input [31:0] a_0027, 
                                           output[31:0] d_0027, 
                                           input [31:0] a_0028, 
                                           output[31:0] d_0028, 
                                           input [31:0] a_0029, 
                                           output[31:0] d_0029, 
                                           input [31:0] a_0030, 
                                           output[31:0] d_0030, 
                                           input [31:0] a_0031, 
                                           output[31:0] d_0031);
parameter n=32;                                                     
                                                                    
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
 wire [31:0] Ao_0008;
 wire [31:0] Bo_0008;
 wire [31:0] Co_0008;
 wire [31:0] Do_0008;
 wire [31:0] Ao_0009;
 wire [31:0] Bo_0009;
 wire [31:0] Co_0009;
 wire [31:0] Do_0009;
 wire [31:0] Ao_0010;
 wire [31:0] Bo_0010;
 wire [31:0] Co_0010;
 wire [31:0] Do_0010;
 wire [31:0] Ao_0011;
 wire [31:0] Bo_0011;
 wire [31:0] Co_0011;
 wire [31:0] Do_0011;
 wire [31:0] Ao_0012;
 wire [31:0] Bo_0012;
 wire [31:0] Co_0012;
 wire [31:0] Do_0012;
 wire [31:0] Ao_0013;
 wire [31:0] Bo_0013;
 wire [31:0] Co_0013;
 wire [31:0] Do_0013;
 wire [31:0] Ao_0014;
 wire [31:0] Bo_0014;
 wire [31:0] Co_0014;
 wire [31:0] Do_0014;
 wire [31:0] Ao_0015;
 wire [31:0] Bo_0015;
 wire [31:0] Co_0015;
 wire [31:0] Do_0015;
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
          dram1[0016] <= a_0016;
          dram1[0017] <= a_0017;
          dram1[0018] <= a_0018;
          dram1[0019] <= a_0019;
          dram1[0020] <= a_0020;
          dram1[0021] <= a_0021;
          dram1[0022] <= a_0022;
          dram1[0023] <= a_0023;
          dram1[0024] <= a_0024;
          dram1[0025] <= a_0025;
          dram1[0026] <= a_0026;
          dram1[0027] <= a_0027;
          dram1[0028] <= a_0028;
          dram1[0029] <= a_0029;
          dram1[0030] <= a_0030;
          dram1[0031] <= a_0031;
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
           dram1[0015] <= phase_counter ? Ao_0007    : Co_0007;
           dram1[0016] <= phase_counter ? Co_0007    : Ao_0008;
           dram1[0017] <= phase_counter ? Ao_0008    : Co_0008;
           dram1[0018] <= phase_counter ? Co_0008    : Ao_0009;
           dram1[0019] <= phase_counter ? Ao_0009    : Co_0009;
           dram1[0020] <= phase_counter ? Co_0009    : Ao_0010;
           dram1[0021] <= phase_counter ? Ao_0010    : Co_0010;
           dram1[0022] <= phase_counter ? Co_0010    : Ao_0011;
           dram1[0023] <= phase_counter ? Ao_0011    : Co_0011;
           dram1[0024] <= phase_counter ? Co_0011    : Ao_0012;
           dram1[0025] <= phase_counter ? Ao_0012    : Co_0012;
           dram1[0026] <= phase_counter ? Co_0012    : Ao_0013;
           dram1[0027] <= phase_counter ? Ao_0013    : Co_0013;
           dram1[0028] <= phase_counter ? Co_0013    : Ao_0014;
           dram1[0029] <= phase_counter ? Ao_0014    : Co_0014;
           dram1[0030] <= phase_counter ? Co_0014    : Ao_0015;
           dram1[0031] <= phase_counter ? dra1[00031]: Co_0015;
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
           dram2[0015] <= phase_counter ? Bo_0007    : Do_0007;
           dram2[0016] <= phase_counter ? Do_0007    : Bo_0008;
           dram2[0017] <= phase_counter ? Bo_0008    : Do_0008;
           dram2[0018] <= phase_counter ? Do_0008    : Bo_0009;
           dram2[0019] <= phase_counter ? Bo_0009    : Do_0009;
           dram2[0020] <= phase_counter ? Do_0009    : Bo_0010;
           dram2[0021] <= phase_counter ? Bo_0010    : Do_0010;
           dram2[0022] <= phase_counter ? Do_0010    : Bo_0011;
           dram2[0023] <= phase_counter ? Bo_0011    : Do_0011;
           dram2[0024] <= phase_counter ? Do_0011    : Bo_0012;
           dram2[0025] <= phase_counter ? Bo_0012    : Do_0012;
           dram2[0026] <= phase_counter ? Do_0012    : Bo_0013;
           dram2[0027] <= phase_counter ? Bo_0013    : Do_0013;
           dram2[0028] <= phase_counter ? Do_0013    : Bo_0014;
           dram2[0029] <= phase_counter ? Bo_0014    : Do_0014;
           dram2[0030] <= phase_counter ? Do_0014    : Bo_0015;
           dram2[0031] <= phase_counter ? dra2[00031]: Do_0015;
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
                    .e_in(dram1[0016]),           
                    .f_in(dram2[0016]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0007),            
                         .Bo(Bo_0007),            
                         .Co(Co_0007),            
                         .Do(Do_0007));           
                                                  
 Level1CU                  L1CU_0008(             
                    .a_in(dram1[0016]),           
                    .b_in(dram2[0016]),           
                    .c_in(dram1[0017]),           
                    .d_in(dram2[0017]),           
                    .e_in(dram1[0018]),           
                    .f_in(dram2[0018]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0008),            
                         .Bo(Bo_0008),            
                         .Co(Co_0008),            
                         .Do(Do_0008));           
                                                  
 Level1CU                  L1CU_0009(             
                    .a_in(dram1[0018]),           
                    .b_in(dram2[0018]),           
                    .c_in(dram1[0019]),           
                    .d_in(dram2[0019]),           
                    .e_in(dram1[0020]),           
                    .f_in(dram2[0020]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0009),            
                         .Bo(Bo_0009),            
                         .Co(Co_0009),            
                         .Do(Do_0009));           
                                                  
 Level1CU                  L1CU_0010(             
                    .a_in(dram1[0020]),           
                    .b_in(dram2[0020]),           
                    .c_in(dram1[0021]),           
                    .d_in(dram2[0021]),           
                    .e_in(dram1[0022]),           
                    .f_in(dram2[0022]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0010),            
                         .Bo(Bo_0010),            
                         .Co(Co_0010),            
                         .Do(Do_0010));           
                                                  
 Level1CU                  L1CU_0011(             
                    .a_in(dram1[0022]),           
                    .b_in(dram2[0022]),           
                    .c_in(dram1[0023]),           
                    .d_in(dram2[0023]),           
                    .e_in(dram1[0024]),           
                    .f_in(dram2[0024]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0011),            
                         .Bo(Bo_0011),            
                         .Co(Co_0011),            
                         .Do(Do_0011));           
                                                  
 Level1CU                  L1CU_0012(             
                    .a_in(dram1[0024]),           
                    .b_in(dram2[0024]),           
                    .c_in(dram1[0025]),           
                    .d_in(dram2[0025]),           
                    .e_in(dram1[0026]),           
                    .f_in(dram2[0026]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0012),            
                         .Bo(Bo_0012),            
                         .Co(Co_0012),            
                         .Do(Do_0012));           
                                                  
 Level1CU                  L1CU_0013(             
                    .a_in(dram1[0026]),           
                    .b_in(dram2[0026]),           
                    .c_in(dram1[0027]),           
                    .d_in(dram2[0027]),           
                    .e_in(dram1[0028]),           
                    .f_in(dram2[0028]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0013),            
                         .Bo(Bo_0013),            
                         .Co(Co_0013),            
                         .Do(Do_0013));           
                                                  
 Level1CU                  L1CU_0014(             
                    .a_in(dram1[0028]),           
                    .b_in(dram2[0028]),           
                    .c_in(dram1[0029]),           
                    .d_in(dram2[0029]),           
                    .e_in(dram1[0030]),           
                    .f_in(dram2[0030]),           
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0014),            
                         .Bo(Bo_0014),            
                         .Co(Co_0014),            
                         .Do(Do_0014));           
                                                  
 Level1CU                  L1CU_0015(             
                    .a_in(dram1[0030]),           
                    .b_in(dram2[0030]),           
                    .c_in(dram1[0031]),           
                    .d_in(dram2[0031]),           
                    .e_in(0),                     
                    .f_in(0),                     
                    .phase_counter(phase_counter),
                    .step_counter(step_counter),  
                         .Ao(Ao_0015),            
                         .Bo(Bo_0015),            
                         .Co(Co_0015),            
                         .Do(Do_0015));           
 
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
 assign    d_0016 = dram2[0016];
 assign    d_0017 = dram2[0017];
 assign    d_0018 = dram2[0018];
 assign    d_0019 = dram2[0019];
 assign    d_0020 = dram2[0020];
 assign    d_0021 = dram2[0021];
 assign    d_0022 = dram2[0022];
 assign    d_0023 = dram2[0023];
 assign    d_0024 = dram2[0024];
 assign    d_0025 = dram2[0025];
 assign    d_0026 = dram2[0026];
 assign    d_0027 = dram2[0027];
 assign    d_0028 = dram2[0028];
 assign    d_0029 = dram2[0029];
 assign    d_0030 = dram2[0030];
 assign    d_0031 = dram2[0031];
 
//-----------------------------------------------
 
endmodule
