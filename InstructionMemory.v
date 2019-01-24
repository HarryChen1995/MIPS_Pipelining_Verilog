`timescale 1ns / 1ps
//50/50 Adam Awale Hanlin Chen
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////
//  Hanlin Chen Adam Awale Percentage 50/50 
module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    reg [31:0] memory [0:127];
    integer i;
    initial begin 
memory[0] = 32'h34120000;       //      main:           ori     $s2, $zero, 0
    memory[1] = 32'h8e520000;       //                      lw      $s2, 0($s2)
    memory[2] = 32'h34130000;       //                      ori     $s3, $zero, 0
    memory[3] = 32'h8e730004;       //                      lw      $s3, 4($s3)
    memory[4] = 32'h02538820;       //                      add     $s1, $s2, $s3
    memory[5] = 32'h0233a022;       //                      sub     $s4, $s1, $s3
    memory[6] = 32'h02348822;       //                      sub     $s1, $s1, $s4
    memory[7] = 32'h7233a002;       //                      mul     $s4, $s1, $s3
    memory[8] = 32'h0233a022;       //                      sub     $s4, $s1, $s3
    memory[9] = 32'h00000000;       //                      nop
    memory[10] = 32'h7234b002;      //                      mul     $s6, $s1, $s4
    memory[11] = 32'h02968822;      //                      sub     $s1, $s4, $s6
    memory[12] = 32'h02568820;      //                      add     $s1, $s2, $s6
    memory[13] = 32'h00000000;      //                      nop
    memory[14] = 32'h00118a80;      //                      sll     $s1, $s1, 10
    memory[15] = 32'h22350000;      //                      addi    $s5, $s1, 0
    memory[16] = 32'h22b70000;      //                      addi    $s7, $s5, 0
    memory[17] = 32'h34120018;      //                      ori     $s2, $zero, 24
    memory[18] = 32'h8e510000;      //                      lw      $s1, 0($s2)
    memory[19] = 32'h0235a022;      //                      sub     $s4, $s1, $s5
    memory[20] = 32'h0237b024;      //                      and     $s6, $s1, $s7
    memory[21] = 32'h0236b825;      //                      or      $s7, $s1, $s6
    memory[22] = 32'h02339022;      //                      sub     $s2, $s1, $s3
    memory[23] = 32'h02554024;      //                      and     $t0, $s2, $s5
    memory[24] = 32'h02d24825;      //                      or      $t1, $s6, $s2
    memory[25] = 32'h02525020;      //                      add     $t2, $s2, $s2
    memory[26] = 32'h00000000;      //                      nop
    memory[27] = 32'hae290004;      //                      sw      $t1, 4($s1)
    memory[28] = 32'h8e2a0004;      //                      lw      $t2, 4($s1)
    memory[29] = 32'h02339022;      //                      sub     $s2, $s1, $s3
    memory[30] = 32'h02555825;      //                      or      $t3, $s2, $s5
    memory[31] = 32'h02526020;      //                      add     $t4, $s2, $s2
    memory[32] = 32'h02525025;      //                      or      $t2, $s2, $s2
    memory[33] = 32'h02eaa020;      //                      add     $s4, $s7, $t2
    memory[34] = 32'h34090000;      //                      ori     $t1, $zero, 0
    memory[35] = 32'h8d280000;      //                      lw      $t0, 0($t1)
    memory[36] = 32'h8d2a0004;      //                      lw      $t2, 4($t1)
    memory[37] = 32'had2a0000;      //                      sw      $t2, 0($t1)
    memory[38] = 32'had280004;      //                      sw      $t0, 4($t1)
    memory[39] = 32'h8d280000;      //                      lw      $t0, 0($t1)
    memory[40] = 32'h8d2a0004;      //                      lw      $t2, 4($t1)
    memory[41] = 32'h34040018;      //                      ori     $a0, $zero, 24
    memory[42] = 32'h0800002d;      //                      j       start
    memory[43] = 32'h2004ffff;      //                      addi    $a0, $zero, -1
    memory[44] = 32'h2004ffff;      //                      addi    $a0, $zero, -1
    memory[45] = 32'h8c900004;      //      start:          lw      $s0, 4($a0)
    memory[46] = 32'hac900000;      //                      sw      $s0, 0($a0)
    memory[47] = 32'h06010003;      //      branch1:        bgez    $s0, branch2
    memory[48] = 32'h22100001;      //                      addi    $s0, $s0, 1
    memory[49] = 32'h0601ffff;      //                      bgez    $s0, branch1
    memory[50] = 32'h0800003e;      //                      j       error
    memory[51] = 32'h2010ffff;      //      branch2:        addi    $s0, $zero, -1
    memory[52] = 32'h06000004;      //                      bltz    $s0, branch3
    memory[53] = 32'h20100001;      //                      addi    $s0, $zero, 1
    memory[54] = 32'h0010082a;      //                      slt     $at, $zero, $s0
    memory[55] = 32'h1420fffd;      //                      bne     $at, $zero, bran                                                                             ch2
    memory[56] = 32'h0800003e;      //                      j       error
    memory[57] = 32'h06000003;      //      branch3:        bltz    $s0, done
    memory[58] = 32'h2010ffff;      //                      addi    $s0, $zero, -1
    memory[59] = 32'h0600ffff;      //                      bltz    $s0, branch3
    memory[60] = 32'h0800003e;      //                      j       error
    memory[61] = 32'h0800003d;      //      done:           j       done
    memory[62] = 32'h0800003e;      //      error:          j       error





      for(i=63;i<128;i=i+1)begin 
           memory[i]<=32'h00000000;
        end 
    end 
    always@(Address)begin 
     Instruction<=memory[Address/4];
    end 

endmodule
