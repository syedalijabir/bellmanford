module Design_BRAM(input clk,w_en,                                                                  
                  output [31:0]a_0000,                                                              
                  input [9:0]muxra0,                                                                
                  input [31:0]d_0000,                                                               
                  output [31:0]a_0001,                                                              
                  input [9:0]muxra1,                                                                
                  input [31:0]d_0001,                                                               
                  output [31:0]a_0002,                                                              
                  input [9:0]muxra2,                                                                
                  input [31:0]d_0002,                                                               
                  output [31:0]a_0003,                                                              
                  input [9:0]muxra3,                                                                
                  input [31:0]d_0003,                                                               
                  output [31:0]a_0004,                                                              
                  input [9:0]muxra4,                                                                
                  input [31:0]d_0004,                                                               
                  output [31:0]a_0005,                                                              
                  input [9:0]muxra5,                                                                
                  input [31:0]d_0005,                                                               
                  output [31:0]a_0006,                                                              
                  input [9:0]muxra6,                                                                
                  input [31:0]d_0006,                                                               
                  output [31:0]a_0007,                                                              
                  input [9:0]muxra7,                                                                
                  input [31:0]d_0007,                                                               
                  input [9:0]write_address);                                                        
    wire [31:0]d0,                                                                                  
               d1,                                                                                  
               d2,                                                                                  
               d3,                                                                                  
               d4,                                                                                  
               d5,                                                                                  
               d6,                                                                                  
               d7;                                                                                  
     BRAM_0 bram_0(                                                                                 
     .addra(muxra0),                                                                                
     .douta(a_0000),                                                                                
     .dinb(d_0000),                                                                                 
     .doutb(d0),                                                                                    
   .clka(clk),.clkb(clk),.wea(0),.dina(0),.web(w_en),.addrb(write_address));                        
     BRAM_1 bram_1(                                                                                 
     .addra(muxra1),                                                                                
     .douta(a_0001),                                                                                
     .dinb(d_0001),                                                                                 
     .doutb(d1),                                                                                    
   .clka(clk),.clkb(clk),.wea(0),.dina(0),.web(w_en),.addrb(write_address));                        
     BRAM_2 bram_2(                                                                                 
     .addra(muxra2),                                                                                
     .douta(a_0002),                                                                                
     .dinb(d_0002),                                                                                 
     .doutb(d2),                                                                                    
   .clka(clk),.clkb(clk),.wea(0),.dina(0),.web(w_en),.addrb(write_address));                        
     BRAM_3 bram_3(                                                                                 
     .addra(muxra3),                                                                                
     .douta(a_0003),                                                                                
     .dinb(d_0003),                                                                                 
     .doutb(d3),                                                                                    
   .clka(clk),.clkb(clk),.wea(0),.dina(0),.web(w_en),.addrb(write_address));                        
     BRAM_4 bram_4(                                                                                 
     .addra(muxra4),                                                                                
     .douta(a_0004),                                                                                
     .dinb(d_0004),                                                                                 
     .doutb(d4),                                                                                    
   .clka(clk),.clkb(clk),.wea(0),.dina(0),.web(w_en),.addrb(write_address));                        
     BRAM_5 bram_5(                                                                                 
     .addra(muxra5),                                                                                
     .douta(a_0005),                                                                                
     .dinb(d_0005),                                                                                 
     .doutb(d5),                                                                                    
   .clka(clk),.clkb(clk),.wea(0),.dina(0),.web(w_en),.addrb(write_address));                        
     BRAM_6 bram_6(                                                                                 
     .addra(muxra6),                                                                                
     .douta(a_0006),                                                                                
     .dinb(d_0006),                                                                                 
     .doutb(d6),                                                                                    
   .clka(clk),.clkb(clk),.wea(0),.dina(0),.web(w_en),.addrb(write_address));                        
     BRAM_7 bram_7(                                                                                 
     .addra(muxra7),                                                                                
     .douta(a_0007),                                                                                
     .dinb(d_0007),                                                                                 
     .doutb(d7),                                                                                    
   .clka(clk),.clkb(clk),.wea(0),.dina(0),.web(w_en),.addrb(write_address));                        
endmodule
