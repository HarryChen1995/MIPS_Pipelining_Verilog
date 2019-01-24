`timescale 1ns / 1ps



module IDEXReg(stall,Reset,Clk,in,out);
input stall;
input Reset;
input Clk;
input [206:0]in;
output reg [206:0]out; 
always@(posedge Clk)begin
if(Reset)begin
out<=207'd0; 
end 
else if(stall)begin
out<=207'd0; 
end 
else begin 
out<=in; 
end 
end 
endmodule
