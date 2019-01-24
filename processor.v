`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//  Hanlin Chen Adam Awale Percentage 50/50 

module processor(Clk,Reset,Zero,IFPC,IDPC,EXPC,MEPC,WBPC,WDatalo,HI,LO);
input Clk;
input Reset;
output Zero;
output [31:0]HI,LO;
output  [31:0]IFPC,IDPC,EXPC,MEPC,WBPC;
output [31:0]WDatalo;
wire [31:0] Instruction , WriteDatalo,WriteDatahi;
wire [3:0]ALUop;
wire RegWrite;
wire [5:0]ALUCtrl;
wire [31:0]ReadData1,ReadData2;
wire [4:0]out;
wire RegDst;
wire ALUsrc;
wire [31:0] signedextend;
wire [31:0]out2;
wire [31:0]out3;
wire move;
wire SLLsrc;
wire out5;
wire en;
wire memtoreg;
wire memread;
wire memwrite;
wire [31:0] data;
wire [31:0]out6;
wire [31:0]out7;
wire [1:0]load; 
wire PCsrc1;
wire PCscr2;
wire PCsrc3;
wire PCsrc4;
wire PCsrc5;
wire PCsrc6;
wire PCsrc;
wire branch;
wire out8;
wire zero;
wire [31:0]PCAddResult;
wire [31:0]out9;
wire bne;
wire out10;
wire EXgtzero;
wire EXgezero;
wire EXltzero;
wire EXlezero;
wire gtzero;
wire gezero;
wire ltzero;
wire lezero;
wire jalsel,jalsel2;
wire [1:0] jump; 
wire [31:0]N2,N3;
 wire[31:0]Address;
 wire [4:0] A;
 wire[31:0]B;
 wire out12;
 wire out16;
 wire out17;
 wire [31:0]IDInstruction;
 wire [31:0]IDN2;
 wire [31:0]IDN3;
 wire enablePC,enableIFIDReg;
 wire stall;
 //////////////////////Instruction Fetch  Stage///////////////////////////////////////////
ProgramCounter PCCount(enablePC,Address,N3, Reset, Clk);
PCAdder  Adder(N3,N2);
InstructionMemory mem(N3,Instruction);
IFIDReg reg1(enableIFIDReg,Reset,PCsrc,jump,Clk,{N2,Instruction,N3},{IDN2,IDInstruction,IDN3});
 ////////////////////////Instructuion Decode  Stage ///////////////////////////////
 wire EXRegWrite,EXRegDst,EXALUsrc,EXen,EXmemwrite,EXmemread,EXmemtoreg,EXbranch,EXbne,EXjalsel,EXjalsel2;
 wire [1:0]EXload,EXjump;
 wire [31:0]EXsignedextend;
 wire [31:0]EXReadData1,EXReadData2;
 wire [31:0]EXN3,EXN2;
 wire [5:0]EXALUCtrl;
 wire EXSLLsrc;
 wire [4:0]shamt;
 wire [4:0]rt,rd;
 wire WBIDRsSel,WBIDRtSel;
 wire[4:0]EXRs,EXRt;
 wire ForwardbranchA, ForwardbranchB;
 wire [31:0]forwardRs,forwardRt;
 wire [31:0] outbranchA, outbranchB;
 wire [31:0]MEWriteDatalo;
 ControlUnit control1(IDInstruction[25:21],IDInstruction[31:26],IDInstruction[20:16],IDInstruction[5:0],ALUop,RegWrite,RegDst,ALUsrc,en,memwrite,memread,memtoreg,load,branch,bne,jump,jalsel,jalsel2);
  ADD ADD1({signedextend<<2},IDN2, PCAddResult);
 SignExtension signed1(IDInstruction[15:0],signedextend );
 RegisterFile r1(IDInstruction[25:21], IDInstruction[20:16],A, B, out5, Clk, ReadData1, ReadData2);
 ALUControl ALUControl1(ALUop,IDInstruction[21],IDInstruction[6],IDInstruction[5:0],ALUCtrl,SLLsrc);
   
  Mux32Bit2To1 forwardbranchA(outbranchA, forwardRs, MEWriteDatalo,ForwardbranchA);
  Mux32Bit2To1 forwardbranchB(outbranchB, forwardRt, MEWriteDatalo,ForwardbranchB);
 
 
 branchCompare brancmp(ALUCtrl,outbranchA,outbranchB,zero,gtzero,gezero,ltzero,lezero);
   and and1(PCsrc1,branch,zero);
   ////// bne 
   not not1(out10,zero);
   and and2(PCsrc2,bne,out10);
   //// bgtz
   and and3(PCsrc3,gtzero,branch);
   ////bgez
   and and4(PCsrc4,gezero,branch);
   // bltz
   and and5(PCsrc5,ltzero,branch);
   //blez
   and and6(PCsrc6,lezero,branch);
   Or Or1(PCsrc1,PCsrc2,PCsrc3,PCsrc4,PCsrc5,PCsrc6,PCsrc);
   
  Mux32Bit2To1 ForwardWBIDRs(forwardRs, ReadData1,out6,WBIDRsSel);
  Mux32Bit2To1 ForwardWBIDRt(forwardRt, ReadData2,out6,WBIDRtSel);
IDEXReg reg2(stall,Reset,Clk,{RegWrite,RegDst,ALUsrc,en,memwrite,memread,memtoreg,branch,bne,jalsel,jalsel2,load,jump,signedextend,forwardRs,forwardRt,IDN2,IDN3,ALUCtrl,SLLsrc,IDInstruction[10:6],IDInstruction[20:16],IDInstruction[15:11],IDInstruction[25:21], IDInstruction[20:16]},{EXRegWrite,EXRegDst,EXALUsrc,EXen,EXmemwrite,EXmemread,EXmemtoreg,EXbranch,EXbne,EXjalsel,EXjalsel2,EXload,EXjump,EXsignedextend,EXReadData1,EXReadData2,EXN2,EXN3,EXALUCtrl,EXSLLsrc,shamt,rt,rd,EXRs,EXRt});
  
 /////////////////////////////////Excution Statge ////////////////////////////////////////
wire MERegWrite,MEmemwrite,MEmemread,MEmemtoreg,MEbranch,MEbne,MEmove,MEjalsel,MEjalsel2;
wire [4:0]MEout;
wire [1:0]MEjump,MEload;
wire [31:0]MEN2,MEN3;
wire [31:0]MEReadData2;
wire [1:0]ForwardA, ForwardB;
wire [31:0]outA,outB;
  Mux32Bit2To1 mux2(out2, outB, EXsignedextend, EXALUsrc);
  Mux32Bit2To1 mux3(out3, EXReadData1,{27'd0, shamt}, EXSLLsrc);
 
  Mux32Bit3To1 forwardA  (outA, out3, MEWriteDatalo,out6, ForwardA);
  Mux32Bit3To1  forwardB (outB, EXReadData2, MEWriteDatalo,out6, ForwardB);
  
  
  
  ALU32Bit ALU(Clk,EXen,EXALUCtrl,outA,out2, WriteDatalo,WriteDatahi, Zero,move,HI,LO,EXgtzero,EXgezero,EXltzero,EXlezero);
  Mux5Bit2To1 mux1(out, rt, rd, EXRegDst); 
 

 EXMEReg reg3(Reset,Clk,{EXRegWrite,EXmemwrite,EXmemread,EXmemtoreg,EXbranch,EXbne,EXjalsel,EXjalsel2,EXload,EXjump,outB,EXN2,EXN3,WriteDatalo,move,out},{MERegWrite,MEmemwrite,MEmemread,MEmemtoreg,MEbranch,MEbne,MEjalsel,MEjalsel2,MEload,MEjump,MEReadData2,MEN2,MEN3,MEWriteDatalo,MEmove,MEout});
 ////////////////////////////Data Memory stage //////////////////////////////////////////////////////////////
 wire WBRegWrite,WBmemwrite,WBmemtoreg,WBbranch,WBbne,WBmove,WBjalsel,WBjalsel2;
 wire [1:0]WBjump;
 wire [31:0]WBN2,WBN3;
 wire [31:0]WBdata;
 wire [31:0]WBWriteDatalo;
 wire [4:0]WBout;
 wire forwardlw;
 wire [31:0] outlwsw;
   Mux32Bit2To1 muxlwsw(outlwsw, MEReadData2,out6, forwardlw);
   DataMemory dm(MEload,MEWriteDatalo,outlwsw,Clk, MEmemwrite, MEmemread, data); 
   MEWBReg reg4(Reset,Clk,{MERegWrite,MEmemwrite,MEmemtoreg,MEbranch,MEbne,MEjalsel,MEjalsel2,MEjump,MEN2,MEN3,MEWriteDatalo,MEmove,MEout,data},{WBRegWrite,WBmemwrite,WBmemtoreg,WBbranch,WBbne,WBjalsel,WBjalsel2,WBjump,WBN2,WBN3,WBWriteDatalo,WBmove,WBout,WBdata});
/////////////////////// Write Back Stage //////////////////////////////////////////////
 or or1(out5,WBmove,WBRegWrite);

 Mux32Bit2To1 mux4(out6, WBWriteDatalo,WBdata, WBmemtoreg);
 Mux5Bit2To1 mux7(A,WBout,5'd31,WBjalsel);
 Mux32Bit2To1 mux8(B,out6,WBN2,WBjalsel2);

 or or7(out16,WBjump[0],WBjump[1]);
 or or5(out12,WBbranch,WBbne);
 or or8(out17,out16,out12);
 or or2(out8,out17,WBmemwrite);
 Mux32Bit2To1 mux5(out7, out6,{32'd0}, out8);
 //////////////////////////////////////////////////////////////////////////////////
 // branch targeting 
 Mux32Bit2To1 mux6(out9,N2,PCAddResult, PCsrc);
 ////////////////////////jump jal jr//////////////////////////
 
 Mux3to1 m3(jump,out9,{IDN2[31:28],IDInstruction[25:0],2'd0},outbranchA,Address);
 
 
  ForwardUnit forwardunit(MEout,MEmemwrite,forwardlw,jump,branch,bne,IDInstruction[25:21], IDInstruction[20:16],WBout,WBRegWrite,WBIDRsSel,WBIDRtSel,EXRs,EXRt,MEout,MERegWrite,ForwardA,ForwardB,ForwardbranchA,ForwardbranchB);
  HazardUnit  harzardunit1(memwrite,jump,branch,bne,EXRegWrite,EXmemread,IDInstruction[25:21],IDInstruction[20:16],out,stall,enablePC,enableIFIDReg);
 assign IFPC=N3;
 assign IDPC=IDN3;
 assign EXPC=EXN3;
 assign MEPC=MEN3;
 assign WBPC=WBN3;
 assign WDatalo=out7;
endmodule