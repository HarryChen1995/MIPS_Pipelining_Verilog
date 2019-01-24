`timescale 1ns / 1ps



module IFIDReg(enableIFIDReg,Reset,PCsrc,jump,Clk,in,out);
input [1:0]jump;
input enableIFIDReg;
input PCsrc;
input Reset;
input Clk;
input [95:0]in;
output reg [95:0]out;
always@(posedge Clk)begin
if(Reset)begin
out<=96'd0; 
end 
else if(PCsrc)begin
out<=96'd0; 
end 
else if((jump==2'd1||jump==2'd2)&&enableIFIDReg)begin 
out<=96'd0;
end  
else if(enableIFIDReg)begin 
out<=in; 
end 
end 
endmodule
