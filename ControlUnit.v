`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////

//  Hanlin Chen Adam Awale Percentage 50/50 
module ControlUnit(Rs,Opcode,BLTZ,Function,ALUop,RegWrite,RegDst,ALUsrc,en,memwrite,memread,MemtoReg,load,branch,bne,jump,jalsel,jalsel2);
input [4:0] BLTZ;
input [4:0]Rs;
input [5:0] Function;
input [5:0] Opcode;
output reg [3:0]ALUop;
output reg RegWrite;
output reg RegDst;
output reg ALUsrc;
output reg en;
output reg MemtoReg;
output reg memwrite;
output reg memread;
output reg [1:0]load;
output reg branch;
output reg bne;
output reg [1:0]jump;
output reg jalsel;
output reg jalsel2;
   always@(*)begin 
   ALUop<=4'b0000; // defualt setting 
   RegWrite<=0;
   RegDst<=0;
   ALUsrc<=0;
   en<=0;
   MemtoReg<=0;
   memwrite<=0;
   memread<=0;
   load<=2'd0;
   branch<=0;
   bne<=0;
   jump<=2'd0;
   jalsel<=0;
   jalsel2<=0;
   case(Opcode)
   6'b000000:begin // add sub  and  or slt mult
           ALUop<=4'b0010;
           RegWrite<=1;
           RegDst<=1;
           if(Function==6'b000000&&Rs!=5'd0)begin
            RegDst<=0;
           end 
            else if(Function==6'b011000||Function==6'b011001)begin // not write to register for mult instruction 
           en<=1;
           RegWrite<=0;
            end 
           else if(Function==6'b001011||Function==6'b001010)begin// movn movz 
             RegWrite<=0;
             end 
            else if (Function==6'b010001||Function==6'b010011)begin // MTHI,MTLO
            en<=1;
             RegWrite<=0;
            end 
            else if(Function==6'b001000)begin// jr
             RegWrite<=0;
            jump<=2'd2;
            end 
           end     
    6'b001111:begin// lui 
     RegWrite<=1;
     ALUsrc<=1;
     ALUop<=4'b1001;
    end          
   6'b100011:begin // lw
             MemtoReg<=1;
             RegWrite<=1;
             ALUsrc<=1;
             memread<=1;
   end 
    6'b101011:begin // sw
             ALUsrc<=1;
             memwrite<=1;
     end 
   6'b100000:begin// lb  
               MemtoReg<=1;
               RegWrite<=1;
               ALUsrc<=1;
               memread<=1;
               load<=2'd1;
   end 
              
    6'b101000:begin //sb
              ALUsrc<=1;
              memwrite<=1;
              load<=2'd1;
    end 
    
    6'b100001:begin //lh
                MemtoReg<=1;
                 RegWrite<=1;
                 ALUsrc<=1;
                 memread<=1;
                 load<=2'd2;
    end 
    6'b101001:begin  // sh
        ALUsrc<=1;
        memwrite<=1;
        load<=2'd2;
    end 
    
    6'b001000:begin // addi 
               RegWrite<=1;
                ALUsrc<=1;
     end 
     6'b001001:begin // addiu 
               RegWrite<=1;
               ALUsrc<=1;
          end     
     6'b000100:begin // beq 
                ALUop<=4'b0001;
                branch<=1;
               end   
               
      6'b000101:begin // bnq 
             ALUop<=4'b0001;
             bne<=1;
             end            
       6'b000111:begin // bgtz
        branch<=1;
        ALUop<=4'b1010;
       end    
       6'b000001:begin // bgez or bltz
            if(BLTZ==5'b00001)begin // bgez
               branch<=1;
               ALUop<=4'b1011;
               end 
              else if(BLTZ==5'b00000)begin // bltz
                branch<=1;
                ALUop<=4'b1101;
               end 
              end    
         6'b000110:begin // blez
                    branch<=1;
                    ALUop<=4'b1111;
                   end    
     6'b011100:begin // mul 
                ALUop<=4'b1000;
                RegDst<=1;           
          if(Function==6'b000000)begin // for MADD
          en<=1; 
                 RegWrite<=0;
           end 
        else if(Function==6'b000100)begin // for  MSUB
        en<=1; 
                    RegWrite<=0;
                      end 
           else begin 
                RegWrite<=1;
           end 
               end     
      6'b001101:begin // ori 
                  ALUop<=4'b0011;
                  ALUsrc<=1;         
                  RegWrite<=1;
           end 
      6'b001110:begin // xori 
                ALUop<=4'b0100;
                ALUsrc<=1;         
                RegWrite<=1;
             end 
       6'b001100:begin // andi  
                ALUop<=4'b0101;
                ALUsrc<=1;         
                RegWrite<=1;
           end 
       6'b001010:begin // slti  
                  ALUop<=4'b0110;
                  ALUsrc<=1;         
                  RegWrite<=1;
             end 
       6'b001011:begin //sltiu
        ALUop<=4'b1110;
        ALUsrc<=1;         
        RegWrite<=1;
       end  
       6'b011111:begin// seh or seb
            ALUop<=4'b0111;
            RegWrite<=1;
            RegDst<=1;
       end  
       
      6'b000010:begin //j
      jump<=2'd1;
      end 
      6'b000011:begin //jal
      jump<=2'd1;
      jalsel<=1;
      jalsel2<=1;
      RegWrite<=1;
      end
   endcase  
   
 end 
endmodule
