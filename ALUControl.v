`timescale 1ns / 1ps
//////////////////////////////////////////////////////////
//  Hanlin Chen Adam Awale Percentage 50/50 

module ALUControl(ALUop,R,RV,Function,ALUCtrl,SLLsrc);
input [3:0] ALUop;
input [5:0] Function;
input R,RV;
output reg [5:0]ALUCtrl;
output reg SLLsrc;
  always@*begin 
    SLLsrc<=0;
  if(ALUop==4'b0000)begin

    ALUCtrl<=6'b00010;// add for lw sw addi 
    end 
   else if (ALUop==4'b0001)begin// beq // bne
      ALUCtrl<=6'd6; // sub  
    end 
   else if(ALUop==4'b1010)begin // bgtz
    ALUCtrl<=6'd33; 
   end 
   else if (ALUop==4'b1011)begin // bgez
    ALUCtrl<=6'd34; 
   end 
   else if ( ALUop==4'b1101)begin // bltz
    ALUCtrl<=6'd35; 
   end 
   else if ( ALUop==4'b1111)begin // blez
      ALUCtrl<=6'd36; 
     end 
   else if (ALUop==4'b0010)begin // all I type 
    case(Function)
     6'b100000:    ALUCtrl<=6'd2;// add
     6'b100001:    ALUCtrl<=6'd2;// addu
     6'b011000:    ALUCtrl<=6'd4;// mult
     6'b011001:    ALUCtrl<=6'd24;// multu
     6'b100010:    ALUCtrl<=6'd6; // sub
     6'b100100:    ALUCtrl<=6'd0;// and 
     6'b100101:    ALUCtrl<=6'd1; // or 
     6'b101010:    ALUCtrl<=6'd7; // slt
     9'b101011:    ALUCtrl<=6'd19; // sltu
     6'b100111:    ALUCtrl<=6'd12; // nor
     6'b100110:    ALUCtrl<=6'd3; // Xor 
     6'b000100:    ALUCtrl<=6'd5;// sllv 
     6'b010001:    ALUCtrl<=6'd30;//  MTHI
     6'b010011:    ALUCtrl<=6'd29;//  MTLO
     6'b010000:    ALUCtrl<=6'd31;//  MFHI
     6'b010010:    ALUCtrl<=6'd23;//  MFLO
     6'b000110:  begin 
      if(RV=='b0)begin 
       ALUCtrl<=6'd9;//srlv
        end 
      else if(RV=='b1)begin //rotrv
       ALUCtrl<=6'd20;
      end 
       end 
     6'b000011:   begin 
         ALUCtrl<=6'd13;// sra
         SLLsrc<=1;
      end 
     6'b000111: ALUCtrl<=6'd13;// srav
     6'b000000: begin 
         ALUCtrl<=6'd10;// sll
         SLLsrc<=1;
         end  
     6'b000010: begin 
         if(R==1'b0)begin
         ALUCtrl<=6'd11;// srl
         end 
         else if(R==1'b1)begin //rotr
         ALUCtrl<=6'd21;
         end 
         SLLsrc<=1;
         end  
      6'b001011: ALUCtrl<=6'd14;// movn
      6'b001010: ALUCtrl<=6'd15;  //movz
    endcase 
   end 
     else if(ALUop==4'b0011)begin // ori 
        ALUCtrl<=6'd27;
      end   
    else if(ALUop==4'b0100)begin // xori 
              ALUCtrl<=6'd22;
            end 
    else if(ALUop==4'b0101)begin // andi 
            ALUCtrl<=6'd28;
        end 
    else if(ALUop==4'b0110)begin //slti 
            ALUCtrl<=6'd7;
    end 
    else if(ALUop==4'b1110)begin //sltiu 
                ALUCtrl<=6'd19;
        end 
    else if(ALUop==4'b0111)begin //seh or seb 
                ALUCtrl<=6'd18;
                SLLsrc<=1;
        end
     else if(ALUop==4'b1000)begin
     if(Function==6'b000010)begin // mul
          ALUCtrl<=6'd8;
         end 
         else if(Function==6'b000000)begin // MADD
            ALUCtrl<=6'd16;
           end 
         else if(Function==6'b000100)begin // MSUB
              ALUCtrl<=6'd17;
                end  
     end   
    if(ALUop==4'b1001)begin 
       ALUCtrl<=6'd32;
    end  
   end 
endmodule
