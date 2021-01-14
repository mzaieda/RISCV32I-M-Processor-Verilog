`timescale 1ns/1ns
module control_unit(input [4:0] instr, output reg Branch, MemRead, MemtoReg,  MemWrite, ALUSrc, RegWrite, output reg [1:0] ALUOp, output reg JALFlag, output reg [1:0] Jal_selection, output reg [1:0] mux_spade_selection, output reg r_check);

always @(*) begin 
r_check = 0;

Branch = (instr==5'b11000); //Branch, JALR, JAL
MemRead = (instr==5'b00000);
MemtoReg= (instr==5'b00000);
MemWrite= (instr==5'b01000);
ALUSrc= (instr== 5'b00000) || (instr==5'b01000) || (instr==5'b00100); //This supports the I-format instructions
RegWrite= (instr== 5'b00000)||(instr==5'b01100)||(instr==5'b00100) || (instr==5'b01101) || (instr==5'b00101) || (instr==5'b11011) || (instr==5'b11001);
JALFlag = (instr==5'b11001 || instr==5'b11011);
Jal_selection = 2'b00;
if(instr[4:0] == 5'b11000) begin
Jal_selection = 2'b01; //Branch
end 
if(instr[4:0] == 5'b11001) begin
Jal_selection = 2'b10;  //JALR
end 
if(instr[4:0] == 5'b11011) begin
Jal_selection = 2'b11; //JAL
end
 

case(instr)

5'b01101:begin 
ALUOp=2'b00; //LUI
mux_spade_selection = 2'b11;
end
5'b00101: begin //AUIPC
ALUOp= 2'b00;
mux_spade_selection = 2'b00; 
end
5'b11011: begin
ALUOp = 2'b00; //JAL
mux_spade_selection = 2'b01; 
end
5'b11001: begin
ALUOp = 2'b00;
mux_spade_selection = 2'b01; //JALR
end
5'b11000: ALUOp = 2'b01; //BEQ, BNE, BLT, BGE, BLTU, BGEU
5'b00000: begin
 ALUOp = 2'b00; //LB, LH, LW, LBU, LHU
mux_spade_selection = 2'b10;
end
5'b01000: ALUOp = 2'b00; //SB, SH, SW
5'b00100: begin ALUOp = 2'b00; //ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, 
mux_spade_selection = 2'b10;

end
5'b01100: begin
 ALUOp = 2'b10; //ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND 
mux_spade_selection = 2'b10;
r_check = 1;
end
//FENCE
/*
output reg [1:0] ALUOp, output reg JALFlag, output reg [1:0] Jal_selection, output reg [1:0] mux_spade_selection, output reg r_check);*/
5'b00011: begin
Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; 
ALUOp = 0; JALFlag = 0; Jal_selection = 0; mux_spade_selection = 0; r_check = 0;
end
//EBREAK
5'b11100: begin
Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0;
ALUOp = 0; JALFlag = 0; Jal_selection = 0; mux_spade_selection = 0; r_check = 0;
end

endcase



end

endmodule