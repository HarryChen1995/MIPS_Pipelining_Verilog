`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit3To1(out, inA, inB,inC, sel);

    output reg [31:0] out;
   
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [1:0]sel;
 
   always@(inA,inB,sel)begin 
      case(sel)
      2'd0:out<=inA;
      2'd1:out<=inB;
      2'd2:out<=inC;
      endcase 
   end 
endmodule
