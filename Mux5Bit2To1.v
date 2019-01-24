`timescale 1ns / 1ps
//  Hanlin Chen Adam Awale Percentage 50/50 
module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
   
    input [4:0] inA;
    input [4:0] inB;
    input sel;
 
   always@*begin 
      case(sel)
      1'b0:out<=inA;
      1'b1:out<=inB;
      endcase 
   end 
endmodule
