`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	MemWrite<=0;
	MemRead<=1;
	#5;
	@(posedge Clk);
	 MemWrite<=1;
	 Address<=32'd0;
	 WriteData<=32'd1;
	 @(posedge Clk);
      Address<=32'd4;
	  WriteData<=32'd7;
	 @(posedge Clk);
      Address<=32'd8;
     WriteData<=32'd20;
     @(posedge Clk);
     Address<=32'd12;
     WriteData<=32'd25;
      #100;
	end

endmodule

