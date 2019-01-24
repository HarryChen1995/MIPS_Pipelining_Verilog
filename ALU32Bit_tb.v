`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	ALUControl<=4'b0110;
    A<=32'd12;
    B<=32'd12;
	#10;
	ALUControl<=4'd7;
	A<=32'd11;
	B<=32'd56;
    #10;
    A<=32'd100;
    B<=32'd56;
    #10;
    ALUControl<=4'd12;
     A<=32'd100;
     B<=32'd56;
    #10;
    ALUControl<=4'd0;
    #10;
    ALUControl<=4'd1;
    #10;
    end 
endmodule

