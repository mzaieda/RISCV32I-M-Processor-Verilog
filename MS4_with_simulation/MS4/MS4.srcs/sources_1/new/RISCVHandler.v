`timescale 1ns / 1ps

module RISCVHandler(input clk, rst);
  /* WIRES DECLARATION */
 
  /*Slower Clock instantiation*/
  /*
  module slower_clock
  (input clk, input rst, input D, output reg Q);
  */
   reg ecall_flag = 0;
  wire [1:0] mux_spade_selection;
  wire [31:0] normal_or_nop;

  reg slow_clk = 0;
  //slower_clock sol7efa(clk,rst, 0, slow_clk);
  always @ (posedge clk or posedge rst) begin // Asynchronous Reset
    if(rst) begin
    slow_clk <= 1;
    end else begin
   slow_clk <= ~slow_clk;
      end
      end
     
  wire [31:0] PC_input;
 
  //assigin PC_output = 0;
  //assign PC_input = 0;

   wire [31:0] IF_ID_PC, IF_ID_Inst;
wire Branch, MemRead, MemtoReg,  MemWrite, ALUSrc, RegWrite, JALFlag;
   wire [1:0] ALUOp;
    wire [31:0] MEM_WB_Imm;
   wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
   wire [12:0] ID_EX_Ctrl;
      wire [3:0] ID_EX_Func;
      wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd; //Only 5 bits
      wire [1:0] Jal_selection;
      wire [12:0] control_in = {mux_spade_selection,RegWrite, MemtoReg, JALFlag,  Jal_selection, Branch, MemRead, MemWrite,ALUOp, ALUSrc};
      wire [3:0] inst_mem_special = {IF_ID_Inst[30], IF_ID_Inst[14:12]};


      wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2;
      wire [9:0] EX_MEM_Ctrl;
      wire [4:0] EX_MEM_Rd;
      wire EX_MEM_Zero;
      wire [5:0] control_in_ex_mum = {RegWrite, MemtoReg, JALFlag, Branch, MemRead, MemWrite};

wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
      wire [3:0] MEM_WB_Ctrl;

wire [31:0] PC_output;
  // wire [31:0] instr_mem_out;
   /*
   (input slower_clock, input MemRead, input MemWrite,
   input [31:0] addr, input [31:0] data_in, input [1:0] state, input sign, output reg [31:0] data_out);
   */
   
    //instrMemory instruction_mem(PC_output,instr_mem_out);
   
    wire [31:0] datamemout;
    wire [31:0] first_adder_output;
    RippleCarryAdder first_adder(PC_output, 32'd4, 0, first_adder_output);

    //IF_ID
     //Break Dance
         /***********IF/ID************/
         //////////////////////////////////////////////////////////////////////////
         wire [31:0] IF_ID_first_adder_output;
         N_bit_register #(120) IF_ID (~slow_clk,rst,1'b1,{first_adder_output, PC_output, normal_or_nop}, {IF_ID_first_adder_output, IF_ID_PC,IF_ID_Inst} );
         // output reg Branch, MemRead, MemtoReg,  MemWrite, ALUSrc, RegWrite, output reg [1:0] ALUOp
         //  (instr_mem_out[6:2],Branch, MemRead, MemtoReg,  MemWrite, ALUSrc, RegWrite,ALUOp);
         


/*module control_unit(input [4:0] instr, output reg Branch, MemRead, MemtoReg,  MemWrite, ALUSrc, RegWrite, output reg [1:0] ALUOp, output reg [1:0] mux_spade_selection, output reg r_check);
*/
 
 wire [31:0] regfileout1, regfileout2, final_out;
 wire [4:0] MEM_WB_Rd;
 /*
 module RegFile (
 input clk, rst,
 input [4:0] readreg1, readreg2, writereg,
 input [31:0] writedata,
 input regwrite,
 output [31:0] readdata1, readdata2 );
 
 */
 wire branchtaken;
wire [31:0] mux_4_out;
 RegFile Register_File(~clk, rst,
 IF_ID_Inst[19:15],IF_ID_Inst[24:20], MEM_WB_Rd,
 mux_4_out, MEM_WB_Ctrl[1], regfileout1, regfileout2);

wire [31:0] immgen_out;
rv32_ImmGen immediate_gen(IF_ID_Inst, immgen_out);



 
  wire r_check;

  control_unit control_unit1 (IF_ID_Inst[6:2],Branch, MemRead, MemtoReg,  MemWrite,
   ALUSrc, RegWrite,ALUOp, JALFlag, Jal_selection, mux_spade_selection, r_check);

/*******MUX for JAL/JALR/AUIPC******/
wire [31:0] auipc_in;

//00 branch
//01 Jalr flag
//10 pc+4
//11 jal flag
RippleCarryAdder adder_auipc(IF_ID_PC, immgen_out, 0, auipc_in);
wire [31:0] MEM_WB_BranchAddOut;
wire [31:0] MEM_WB_first_adder_output;
mux_4x1 mux_before_regfile(MEM_WB_BranchAddOut, MEM_WB_first_adder_output, final_out, MEM_WB_Imm, MEM_WB_Ctrl[3:2], mux_4_out);
wire [12:0] control_or_nop;
muxarray muxNop(control_in, 0, branchtaken, control_or_nop);
//mux_4x1_four jalr_out(branch_outcome, jalr_outcome, pc+4, jal_outcome, jalr_selection, jalr_mux_out);
wire [31:0] ID_EX_first_adder_output;
 /***********ID/EX************/
    //wire [4:0]IF_ID_Rd;
      //Note that I added more 15 bits in this register to take rs1, rs2, rd
       N_bit_register #(192) ID_EX (slow_clk,rst,1'b1,
       {IF_ID_first_adder_output, control_or_nop, IF_ID_PC,regfileout1, regfileout2, immgen_out, inst_mem_special,
        IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7]},
       {ID_EX_first_adder_output, ID_EX_Ctrl,ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2,
       ID_EX_Imm, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd} );
       // Rs1 and Rs2 are needed later for the forwarding unit
       
       //shift left
       //wire [31:0] shift_out;
       //shift_one shifting_one(ID_EX_Imm, shift_out);
       
       //adder fr target address
       wire [31:0] second_adder_output;
       RippleCarryAdder second_adder(ID_EX_PC, ID_EX_Imm,0,second_adder_output);
//This is the mux after the RF
wire [31:0] secondALUin, forwardB_Out;
muxarray Reg_imm_mux( forwardB_Out, ID_EX_Imm, ID_EX_Ctrl[0], secondALUin);

//This is the ALU control unit
wire [3:0] ALU_selection;
/*module ALU_control_unit(input [1:0] ALUOp, input [2:0] instr14_12, input instr30, input r_check, output reg [3:0] ALU_selection, output reg [1:0] state, output reg sign);
*/
wire [1:0] state;
wire sign;
ALU_control_unit alu_control_unit(ID_EX_Ctrl[2:1],ID_EX_Func[2:0], ID_EX_Func[3] , r_check,ALU_selection, state, sign);
/*
`timescale 1ns / 1ps
module forwardingUnit
(
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,
    input [4:0] EX_MEM_RegisterRd,
    input [4:0] ID_EX_RegisterRs1,
    input [4:0] ID_EX_RegisterRs2,
    input [4:0] MEM_WB_RegisterRd,
    output reg [1:0]ForwardA,
    output reg [1:0]ForwardB
 );
  wire [12:0] control_in = {mux_spade_selection,RegWrite, MemtoReg,
  JALFlag,  Jal_selection, Branch, MemRead, MemWrite,ALUOp, ALUSrc};
*/

//Main ALU
//wire Zero;
wire [1:0] forwardA, forwardB;

//Forwarding Unit
forwardingUnit forward_module(
EX_MEM_Ctrl[7],
MEM_WB_Ctrl[1],
EX_MEM_Rd,
ID_EX_Rs1,
ID_EX_Rs2,
MEM_WB_Rd,
forwardA,
forwardB
);


wire [31:0] ALU_first_in;
//wire [31:0] ALU_second_in;
mux_4x1 forwardA_mod(ID_EX_RegR1, final_out, EX_MEM_ALU_out, 0,forwardA, ALU_first_in);
mux_4x1 forwardB_mod(ID_EX_RegR2, final_out, EX_MEM_ALU_out, 0,forwardB, forwardB_Out);
wire [31:0] ALUout;
/*
module prv32_ALU(
input   wire [31:0] a, b,
input   wire [4:0]  shamt,
output  reg  [31:0] r,
output  wire        cf, zf, vf, sf,
input   wire [3:0]  alufn
);
*/
wire cf, zf, vf, sf;

prv32_ALU ALUModule(
ALU_first_in, secondALUin,
ID_EX_Rs2,
ALUout,
cf, zf, vf, sf,
ALU_selection
);



    wire [1:0] EX_MEM_state;
    wire EX_MEM_sign;
    wire EX_MEM_cf;
    wire EX_MEM_zf;
    wire EX_MEM_vf;
    wire EX_MEM_sf;
    wire EX_MEM_branchFlag;
    wire [31:0] EX_MEM_first_adder_output;
    /*
    module branchOutput(
        input [2:0]funct3,
        input branch, //branch 1/0 from the control unit
        input Z,        //zero flag
        input C,        //carry
        input V,        //overflow
        input S,        //sign
        output reg branch_output
    );
    */
 wire[2:0] EX_MEM_Func;
 wire [31:0] EX_MEM_Imm;
      /***********EX/MEM************/
      //I added 5 more bits for Rd
       N_bit_register #(251) EX_MEM (~slow_clk,rst,1'b1,
       {ID_EX_Imm,ID_EX_first_adder_output, ID_EX_Func[2:0],state, sign, ID_EX_Ctrl[12:3], second_adder_output, cf, zf, vf, sf, ALUout, forwardB_Out, ID_EX_Rd },
       {EX_MEM_Imm,EX_MEM_first_adder_output,EX_MEM_Func,EX_MEM_state, EX_MEM_sign, EX_MEM_Ctrl, EX_MEM_BranchAddOut,EX_MEM_cf, EX_MEM_zf, EX_MEM_vf,EX_MEM_sf,
       EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd} );

   wire branchFlag;
    branchOutput branchout(EX_MEM_Func, EX_MEM_Ctrl[2], EX_MEM_cf, EX_MEM_zf, EX_MEM_vf, EX_MEM_sf, branchFlag);
wire and_out;
wire my_pc_src;
assign and_out= EX_MEM_Ctrl[2] & branchFlag;

//assign my_pc_src = and_out | EX_MEM_Ctrl[3];

//mux before PC
    
    //muxarray mux_before_PC(first_adder_output, EX_MEM_BranchAddOut, my_pc_src, PC_input);
    mux_4x1_four jal_hybrdid_mux(first_adder_output, EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_BranchAddOut, branchFlag, EX_MEM_Ctrl[4:3], PC_input, branchtaken);
      PC_register PC_reg( PC_input, slow_clk, rst, ~ecall_flag, PC_output );

     
     
/*
module datamem
(input clk, input MemRead, input MemWrite,
input [5:0] addr, input [31:0] data_in, input [1:0] state, input sign, output reg [31:0] data_out);

*/

/*
   
 
   (input slower_clock, input MemRead, input MemWrite,
   input [31:0] addr, input [31:0] data_in, input [1:0] state, input sign, output reg [31:0] data_out);
   */
   //ecall
  
   
    always @(*) begin
        if (datamemout[6:2] == 5'b11100) begin
            ecall_flag = 1;
        end
         
       end
   single_memory Hybrid_Mem (slow_clk, EX_MEM_Ctrl[1], EX_MEM_Ctrl[0], (slow_clk==1?PC_output:EX_MEM_ALU_out), EX_MEM_RegR2,
   EX_MEM_state, EX_MEM_sign, datamemout);
   
   

   //end
   //fence - ebreak mux
   wire fence_ebreak_flag;
   fence_ebreak special_flag(datamemout[6:2], fence_ebreak_flag);
   
   
   muxarray normal_or_nop_mux(datamemout, 32'h00000033, fence_ebreak_flag, normal_or_nop);
   
//datamem Data_Mem( clk, EX_MEM_Ctrl[1], EX_MEM_Ctrl[0],EX_MEM_ALU_out, EX_MEM_RegR2,EX_MEM_state, EX_MEM_sign, datamemout);



      /***********MEM/WB************/
           // wire [31:0] MEM_WB_Rd;
      wire control_in_mem_wb = EX_MEM_Ctrl[0];
      //wire [31:0] MEM_WB_first_adder_output;
      //wire [31:0] MEM_WB_BranchAddOut;
   
      //I added 5 more bits for the Rd
       N_bit_register #(175) MEM_WB (slow_clk,rst,1'b1,
       {EX_MEM_Imm, EX_MEM_BranchAddOut,EX_MEM_first_adder_output,EX_MEM_Ctrl[9:6], datamemout, EX_MEM_ALU_out, EX_MEM_Rd},
       {MEM_WB_Imm, MEM_WB_BranchAddOut,MEM_WB_first_adder_output,MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out,
       MEM_WB_Rd} );

   
   /**************************************************/


//mux after data memory
muxarray mux_after_data( MEM_WB_ALU_out,MEM_WB_Mem_out, MEM_WB_Ctrl[0], final_out);

 
endmodule