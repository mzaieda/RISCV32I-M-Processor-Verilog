
`timescale 1ns/1ns

module ALU_control_unit(input [1:0] ALUOp, input [2:0] instr14_12, input instr30, input r_check, output reg [3:0] ALU_selection, output reg [1:0] state, output reg sign);
always @(*) begin 
sign = 0;
case (ALUOp)

2'b01: begin
ALU_selection=4'b0001;
end
2'b00: begin 

ALU_selection=4'b0000; //add

if (instr14_12 == 3'b010) begin
ALU_selection = 4'b1101; //SLTI (set if less than immediate)
end
if (instr14_12 == 3'b011) begin
ALU_selection = 4'b1111; //SLTIU (set if less than immediate UNSIGNED)
end

if (instr14_12 == 3'b001) begin
ALU_selection = 4'b1001; //Shift left logic immediate (SLLI)
end

if (instr14_12 == 3'b101 && instr30==0) begin
ALU_selection = 4'b1010; //Shift right logic immediate (SRLI)
end

if (instr14_12 == 3'b101 && instr30==1) begin
ALU_selection = 4'b1000; //Shift right arithmetic immediate(SRAI)
end


//state

//Load Word
if (instr14_12 == 3'b010) begin
state = 2'b10;
end

//Load Half
if (instr14_12 == 3'b001 || instr14_12 == 3'b101) begin
state = 2'b01;
end


//Load Byte
if (instr14_12 == 3'b000 || instr14_12 == 3'b100) begin
state = 2'b00;
end


//signed or unsigned
if (instr14_12[2] == 1'b1) begin
sign = 1'b1;
end

end
2'b10: //This has a lot cases that should be expanded here with if statements
begin 
if (instr14_12==3'b010)begin
    ALU_selection = 4'b1101; //Set if less than (SLT)
end
if (instr14_12==3'b011)begin
    ALU_selection = 4'b1111; //Set if less than UNSIGNED (SLTU)
end
if (instr14_12== 3'b000) begin 
if (r_check == 1) begin
  if (instr30==0)begin 
  ALU_selection=4'b0000; //add
  end
  else begin 
  ALU_selection=4'b0001; //subtract which is technically has the same selection line of add
  end
  end else if (r_check == 0) begin
    ALU_selection = 4'b0000; //always add (ADDI) (Cancel SUBI)
  end
end 

if (instr14_12== 3'b111) begin 
  if (instr30==0)begin 
  ALU_selection=4'b0101; //and
  end
end 

if (instr14_12== 3'b110) begin 
  if (instr30==0)begin 
  ALU_selection=4'b0100; //or
  end
end 

if (instr14_12== 3'b100) begin 
  if (instr30==0)begin 
  ALU_selection=4'b0111; //xor
  end
end 



//Shiftat
if (instr14_12== 3'b001) begin 

  ALU_selection=4'b1001; //sll

end 
if (instr14_12== 3'b101 && instr30 == 0) begin 

  ALU_selection=4'b1010; //srl

end 
if (instr14_12== 3'b101 && instr30 == 1) begin 

  ALU_selection=4'b1000; //sra

end 





end 



endcase 




end 

endmodule