`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2016 11:41:30 AM
// Design Name: 
// Module Name: ForwardUnit
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


module ForwardUnit(MEout,MEmemwrite,forwardlw,jump,branch,bne,IDRs,IDRt,WBDst,WBRegWrite,WBIDRsSel,WBIDRtSel,EXRs,EXRt,MEDst,MERegWrite,ForwardA,ForwardB,ForwardbranchA,ForwardbranchB);
input branch,bne;
input MEmemwrite;
input [4:0]MEout;
input [1:0]jump;
input WBRegWrite,MERegWrite;
input [4:0]IDRs,IDRt,WBDst,EXRs,EXRt,MEDst;
output reg [1:0]ForwardA,ForwardB;
output reg WBIDRsSel,WBIDRtSel;
output reg forwardlw;
output reg ForwardbranchA,ForwardbranchB;
    always@(*)begin
      WBIDRsSel<=0;
      WBIDRtSel<=0;
      ForwardA<=2'd0;
      ForwardB<=2'd0;
      ForwardbranchA<=0;
      ForwardbranchB<=0;
      forwardlw<=0;
      
      if(MEout==WBDst&&MEmemwrite&&WBRegWrite)begin
      forwardlw<=1; 
      end 
      
     if(IDRs==MEDst&&MERegWrite==1'd1&&MEDst!=5'd0&&(branch||bne||jump==2'd2))begin
              ForwardbranchA<=1;
            end 
     if(IDRt==MEDst&&MERegWrite==1'd1&&MEDst!=5'd0&&(branch||bne))begin 
               ForwardbranchB<=1;
           end  
      
      
    if(IDRs==WBDst&&WBRegWrite==1'd1)begin
      WBIDRsSel<=1;
     end 
   if(IDRt==WBDst&&WBRegWrite==1'd1)begin 
       WBIDRtSel<=1;
   end 
   if(EXRs==MEDst&&MERegWrite==1'd1&&MEDst!=5'd0)begin
        ForwardA<=2'd1;
      end 
    if(EXRt==MEDst&&MERegWrite==1'd1&&MEDst!=5'd0)begin 
         ForwardB<=2'd1;
     end
     
     if(EXRs==WBDst&&WBRegWrite==1'd1&&WBDst!=5'd0&&(!((EXRs==MEDst&&MERegWrite==1'd1&&MEDst!=5'd0))))begin
   
            ForwardA<=2'd2;
           
          end 
     if(EXRt==WBDst&&WBRegWrite==1'd1&&WBDst!=5'd0&&(!((EXRt==MEDst&&MERegWrite==1'd1&&MEDst!=5'd0))))begin 
       
             ForwardB<=2'd2;
            
         end 
    
     end 
endmodule
