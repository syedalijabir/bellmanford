module PE(input [31:0]S,T, output [31:0] T_dash); // the source S and target T nodes are  input 
                                                  // and T_dash is the updated target node
  
  
  
  wire [2:0]  pS = S[31:29];          // splitting the input wire
  wire [7:0]  wS = S[28:21];          
  wire [20:0] dS = S[20: 0];          
    
  wire [2:0]  pT = T[31:29];          // splitting the input wire
  wire [7:0]  wT = T[28:21];
  wire [20:0] dT = T[20: 0];
  
  wire [20:0] new_distance = (dS+wT); 
  wire update_true = new_distance < dT;    // comparator whether to update or not
  
  wire [2:0 ] muxO_pT = update_true?      pS     : pT ;  // if update is true? update select the mux outputs for updating
  wire [20:0] muxO_dT = update_true? new_distance: dT ;

  
  wire [2:0]  pT_dash = muxO_pT;      // naming the Tdash wires
  wire [7:0]  wT_dash = wT;
  wire [20:0] dT_dash = muxO_dT;
  
  assign T_dash={pT_dash, wT_dash, dT_dash}; // concatenating T dash
  
endmodule
