`timescale 1ns / 1ps

module HazardUnit(memwrite,jump,branch,bne,EXRegWrite,EXmemread,IDRs,IDRt,EXDst,stall,enablePC,enableIFIDReg);
input [1:0]jump;
input memwrite;
input branch,bne;
input EXRegWrite;
input EXmemread;
input [4:0]IDRs,IDRt,EXDst;
output reg stall;
output reg enablePC,enableIFIDReg;

 always@(*)begin
  enablePC<=1;
  enableIFIDReg<=1;
  stall<=0;
  if(EXmemread&&(IDRs==EXDst||IDRt==EXDst)&&!memwrite)begin 
   enablePC<=0;
   enableIFIDReg<=0;
   stall<=1'd1;
  end 
  else if((branch||bne)&&(IDRs==EXDst||IDRt==EXDst)&&EXRegWrite)begin 
   enablePC<=0;
   enableIFIDReg<=0;
   stall<=1'd1;
   end 
  else if((jump==2'd2)&&(IDRs==EXDst)&&EXRegWrite)begin 
      enablePC<=0;
      enableIFIDReg<=0;
      stall<=1'd1;
      end 
   
   
 end 


endmodule
