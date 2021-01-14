`timescale 1ns / 1ps

//generatnig a flag to determine whether it is fence or ebreak instruction
module fence_ebreak(input [4:0] my_opcode, output reg my_flag);
always @(*) begin
    if ((my_opcode == 5'b00011) || (my_opcode == 5'b11100)) begin //fence or ebreak
        my_flag = 1;
    
    end else begin
        my_flag = 0;
        
    end
end
endmodule
