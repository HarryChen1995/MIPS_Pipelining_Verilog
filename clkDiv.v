// HanLin Chen / Adam Awale percentage 50/50 
`timescale 1ns / 1ps
module clkDiv(rst,clk,clkout);


parameter Div1=100000000;

input clk,rst;
output reg clkout;
reg [26:0] counter;
reg clkint;
always@(posedge clk) begin 
if(rst==1) begin
counter<=0;
clkint<=0;
clkout<=0;
end
else begin

    if( counter== Div1-1) begin
            clkout <= ~clkint;
            clkint <= ~clkint;
            counter <= 0;
         end
         else begin
            clkout <= clkint;
            clkint <= clkint;
            counter <= counter + 1;
         end
    end
 
end  
endmodule 
