`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// ADD  | 0010
// SUB  | 0110
// AND  | 0000
// OR   | 0001
// SLT  | 0111
// MULT | 1000
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(Clk,en,ALUControl, A, B, ALUResultlo,ALUResulthi, Zero,move,HI,LO,gtzero,gezero,ltzero,lezero);
    input Clk,en;
	input [5:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
    output reg move;
	output reg [31:0] ALUResultlo;	// answer
	output reg [31:0] ALUResulthi;
	output reg Zero;	    // Zero=1 if ALUResult == 0
	output reg [31:0]HI,LO;
	output reg gtzero;
	output reg gezero;
	output reg ltzero;
	output reg lezero;
	reg [31:0]hi,lo;
	initial begin 
	hi<=32'd0;
	lo<=32'd0;
	HI<=32'd0;
	LO<=32'd0;
	end 
   always@*begin 
    move<=0;
    gtzero<=0;
    gezero<=0;
    ltzero<=0;
    lezero<=0;
    case (ALUControl)
      6'd2:  {ALUResulthi,ALUResultlo}<=A+B;
      6'd6:  {ALUResulthi,ALUResultlo}<=A-B; 
      6'd0:  {ALUResulthi,ALUResultlo}<=A&B; 
      6'd28:  {ALUResulthi,ALUResultlo}<=A&{16'd0,B[15:0]};
      6'd1:  {ALUResulthi,ALUResultlo}<=A|B; 
      6'd27: {ALUResulthi,ALUResultlo}<=A|{16'd0,B[15:0]}; 
      6'd7:  {ALUResulthi,ALUResultlo}<=($signed (A)<$signed (B));
      6'd19: {ALUResulthi,ALUResultlo}<=(A<B);
      6'd8:  {ALUResulthi,ALUResultlo}<=A*B;
      6'd10:  {ALUResulthi,ALUResultlo}<=B<<A;
      6'd11:  {ALUResulthi,ALUResultlo}<=B>>A;
      6'd12:  {ALUResulthi,ALUResultlo}<=~(A|B);
      6'd3:  {ALUResulthi,ALUResultlo}<=(A^B);
      6'd22:  {ALUResulthi,ALUResultlo}<=A^{16'd0,B[15:0]};
      6'd33: begin //bgtz
      if($signed(A)>$signed(32'd0))begin 
      gtzero<=1;
      end 
     end 
     6'd34: begin //bgez
           if(~($signed(A)<$signed(32'd0)))begin 
           gezero<=1;
           end
          end 
      6'd35: begin //bltz
                    if(($signed(A)<$signed(32'd0)))begin 
                    ltzero<=1;
                    end
                   end 
     6'd36: begin //blez
               if(~($signed(A)>$signed(32'd0)))begin 
               lezero<=1;
               end
              end 
       6'd4: begin
        {hi,lo}<=$signed (A*B); //mult
        {ALUResulthi,ALUResultlo}<=32'd0;
        end 
      6'd24: begin
      {hi,lo}<= (A*B); //multu
      {ALUResulthi,ALUResultlo}<=32'd0;
     end 
      6'd16:begin {hi,lo}<=$signed({HI,LO})+$signed((A*B)); // madd 
      {ALUResulthi,ALUResultlo}<=32'd0;
      end 
      6'd17:begin {hi,lo}<=$signed({HI,LO})-$signed (A*B); // msub
      {ALUResulthi,ALUResultlo}<=32'd0;
      end 
      6'd5:{ALUResulthi,ALUResultlo}<=B<<A; //sllv
      6'd9:{ALUResulthi,ALUResultlo}<=B>>A; //srlv 
      6'd13:{ALUResulthi,ALUResultlo}<=B>>>A; //sra or srav 
      6'd30:begin hi<=$signed (A); //mthi
      {ALUResulthi,ALUResultlo}<=32'd0;
      end 
      6'd29:begin lo<=$signed (A); //mtlo
      {ALUResulthi,ALUResultlo}<=32'd0;
      end 
      6'd31:{ALUResulthi,ALUResultlo}<=HI;// mfhi
      6'd23:{ALUResulthi,ALUResultlo}<=LO;// mflo
      6'd14:begin 
      if(B!=32'b0)begin 
         {ALUResulthi,ALUResultlo}<=A;
         move<=1;
        end 
        else begin 
          {ALUResulthi,ALUResultlo}<=32'd0;
             end 
      end 
      6'd15:begin 
          if(B==32'b0)begin 
              {ALUResulthi,ALUResultlo}<=A;
              move<=1;
             end 
            else begin 
            {ALUResulthi,ALUResultlo}<=32'd0;
            end 
           end 
      6'd18:begin 
        if(A==32'd24)begin //seh 
              {ALUResulthi,ALUResultlo}<={{16{B[15]}},B[15:0]};
              end 
        else if(A==32'd16)begin //seb 
            {ALUResulthi,ALUResultlo}<={{24{B[7]}},B[7:0]};
               end 
         end 
      6'd20:begin // rotrv 
       {ALUResulthi,ALUResultlo}<=B>>(A[4:0])|B<<(32-A[4:0]);
      end 
       6'd21:begin // rotr 
            {ALUResulthi,ALUResultlo}<=B>>A|B<<(32-A);
           end 
        6'd32:{ALUResulthi,ALUResultlo}<=B<<16; //lui
    endcase 
    
        if({ALUResulthi,ALUResultlo}==32'd0)begin 
        Zero<=1;
        end 
        else begin 
        Zero<=0;
        end 
   end   
   always@(negedge Clk)begin
    if(en)begin
    {HI,LO}<={hi, lo};
    end  
   end 
endmodule

