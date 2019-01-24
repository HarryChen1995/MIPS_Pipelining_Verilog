`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 04:46:20 PM
// Design Name: 
// Module Name: TopMod
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
//  Hanlin Chen Adam Awale Percentage 50/50 

module TopMod(Clk,Reset,Reset2,en_out,out7);

input Clk;
input Reset;
input Reset2;
output  [7:0]en_out;
output  [6:0]out7;
wire [31:0]PCAdress;
wire [31:0]WDatalo,HI,LO;
wire clkout;
wire Zero;
clkDiv clkd(Reset2,Clk,clkout);
processor p2(clkout,Reset,Zero,PCAdress,WDatalo,HI,LO);
Two4DigitDisplay t1(Clk, PCAdress[7:0],WDatalo[7:0], out7, en_out);
endmodule
