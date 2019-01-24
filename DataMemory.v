`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(load,Address, WriteData, Clk, MemWrite, MemRead, ReadData); 
    input [1:0]load;
    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 

    output reg [31:0] ReadData; // Contents of memory location at Address
    reg [31:0]MEM[0:255];
    integer i;
    initial begin
    MEM[0] = 32'h64;
    MEM[1] = 32'hc8;
    MEM[2] = 32'h12c;
    MEM[3] = 32'h190;
    MEM[4] = 32'h1f4;
    MEM[5] = 32'h258;
    MEM[6] = 32'h2bc;
    MEM[7] = 32'h320;
    MEM[8] = 32'h384;
    MEM[9] = 32'h3e8;
    MEM[10] = 32'h44c;
    MEM[11] = 32'h4b0;

    for(i=12;i<256;i=i+1)begin 
       MEM[i]<=0;
       end 
    end 
  always@(posedge Clk)begin 
  if(load==2'd0)begin 
    if(MemWrite)begin
       MEM[Address/4]<=WriteData;
     end 
    end 
   else if(load==2'd1)begin 
    if(MemWrite)begin
     case(Address[1:0])
      2'd0:MEM[(Address)/4][7:0]=WriteData[7:0];
      2'd1:MEM[(Address)/4][15:8]=WriteData[7:0];
      2'd2:MEM[(Address)/4][23:16]=WriteData[7:0];
      2'd3:MEM[(Address)/4][31:24]=WriteData[7:0];
     endcase 
     end 
   end 
   
   else if(load==2'd2)begin 
       if(MemWrite)begin
        case(Address[1:0])
         2'd0:{MEM[Address/4][15:0]}<=WriteData[15:0];
         2'd2:{MEM[Address/4][31:16]}<=WriteData[15:0];
        endcase 
        end 
      end 
   
   
  end 
  always@(*)begin 
  if(load==2'd0)begin 
     if(MemRead)begin 
       ReadData<=MEM[Address/4];
      end 
     end 
   else if(load==2'd1)begin 
         if(MemRead)begin
            case(Address[1:0])
             2'd0:ReadData={{24{MEM[Address/4][7]}},MEM[Address/4][7:0]};
             2'd1:ReadData={{24{MEM[Address/4][15]}},MEM[Address/4][15:8]};
             2'd2:ReadData={{24{MEM[Address/4][23]}},MEM[Address/4][23:16]};
             2'd3:ReadData={{24{MEM[Address/4][31]}},MEM[Address/4][31:24]};
            endcase 
          end 
        end 
        
         else if(load==2'd2)begin 
               if(MemRead)begin
                  case(Address[1:0])
                   2'd0:ReadData<={{16{MEM[Address/4][15]}},MEM[Address/4][15:0]};
                   2'd2:ReadData<={{16{MEM[Address/4][31]}},MEM[Address/4][31:16]};
                  endcase 
                end 
              end  
        
  end 
  
endmodule