`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2016 10:57:21 AM
// Design Name: 
// Module Name: Mux3to1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux3to1(sel,A,B,C,out);
input [31:0]A,B,C;
input [1:0]sel;
output reg [31:0]out;
        always@(*)begin 
        case(sel)
        2'd0: out<=A;
        2'd1: out<=B;
        2'd2: out<=C;
        endcase 
        end 
endmodule
