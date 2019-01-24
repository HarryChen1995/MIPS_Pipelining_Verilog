`timescale 1ns / 1ps



module EXMEReg(Reset,Clk,in,out);
input Reset;
input Clk;
input [145:0]in;
output reg [145:0]out;
always@(posedge Clk)begin
if(Reset)begin
out<=146'd0; 
end 
else begin 
out<=in; 
end 
end 
endmodule
