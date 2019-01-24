`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module processor_tb();
reg Clk,Reset;
wire Zero;
wire [31:0]IFPC,IDPC,EXPC,MEPC,WBPC;
wire [31:0]WDatalo;
wire[31:0] HI,LO;
processor p1(.Clk(Clk),.Reset(Reset),.Zero(Zero),.IFPC(IFPC),.IDPC(IDPC),.EXPC(EXPC),.MEPC(MEPC),.WBPC(WBPC),.WDatalo(WDatalo),.HI(HI),.LO(LO));

always begin 
Clk<=1;
#100;
Clk<=0;
#100;
end 
initial begin 
Reset<=1;
#40;
Reset<=0;
#2000;

end 


endmodule