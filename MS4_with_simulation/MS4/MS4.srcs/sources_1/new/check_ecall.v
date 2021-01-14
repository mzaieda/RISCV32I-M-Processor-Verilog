`timescale 1ns / 1ps

module check_ecall(input [4:0] my_opcode, output reg ecall_flag);

always @(*)begin
    if (my_opcode == 5'b11100) begin
        ecall_flag = 0;
    end else begin
    
        ecall_flag = 1;
    end

end
endmodule
