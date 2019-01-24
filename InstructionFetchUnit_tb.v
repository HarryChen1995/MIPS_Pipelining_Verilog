`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2016 05:49:36 PM
// Design Name: 
// Module Name: InstructionFetchUnit_tb
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


module InstructionFetchUnit_tb( );
   reg Clk,Reset;
   wire [31:0] Instruction;
   InstructionFetchUnit  m1(.Instruction(Instruction),.Reset(Reset),.Clk(Clk));
   always begin 
   Clk<=0;
   #100;
   Clk<=1;
   #100;
   end 
   initial begin 
   Reset<=1;
   #200;
   Reset<=0;
   #100;
   end 
endmodule
