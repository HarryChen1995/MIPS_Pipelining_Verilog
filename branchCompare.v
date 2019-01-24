`timescale 1ns / 1ps


module branchCompare(ALUCtrl,Rs,Rt,zero,gtzero,gezero,ltzero,lezero);
input [5:0]ALUCtrl;
input [31:0]Rs,Rt;
output reg zero,gtzero,gezero,ltzero,lezero;
  always@(*)begin
  gtzero<=0;
  gezero<=0;
  ltzero<=0;
  lezero<=0;
  case(ALUCtrl)
  6'd6: begin
        if((Rs-Rt)==32'd0)begin  
         zero<=1;
         end 
    else begin
        zero<=0; 
   end 
  end 
  6'd33: begin //bgtz
       if($signed(Rs)>$signed(32'd0))begin 
       gtzero<=1;
       end 
      end 
      6'd34: begin //bgez
            if(~($signed(Rs)<$signed(32'd0)))begin 
            gezero<=1;
            end
           end 
       6'd35: begin //bltz
                     if(($signed(Rs)<$signed(32'd0)))begin 
                     ltzero<=1;
                     end
                    end 
      6'd36: begin //blez
                if(~($signed(Rs)>$signed(32'd0)))begin 
                lezero<=1;
                end
               end  
  
  
  
  endcase 
 
  
  
 end 

endmodule
