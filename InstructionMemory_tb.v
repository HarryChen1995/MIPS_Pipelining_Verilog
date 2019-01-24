`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 
// Module - InstructionMemory_tb.v
// Description - Test the 'InstructionMemory_tb.v' module.
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 
     reg[31:0] Address;
    wire [31:0] Instruction;

   

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);

	initial begin
	
    Address<=32'd0;
    #10;
    Address<=32'd4;
    #10;
    Address<=32'd8;
    #10;
    Address<=32'd12;
    #100;
	
	end

endmodule

