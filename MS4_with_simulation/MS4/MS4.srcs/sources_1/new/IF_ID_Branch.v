module IF_ID_Branch
(input [6:0]opcode, input [31:0]Rs1, input [31:0]Rs2, input immediate,  output reg zero_flag, not_zero_flag, g_t_flag, g_e_u_flag, l_t_flag, l_t_u_flag, stall, output reg [31:0]jalr_out);
    
    reg [31:0]absoluteRs1;
    reg [31:0]absoluteRs2;
    //checking if it is a negative number
    //assigning the absolute to the opposite of the source value
    //this is used for the branch flags below
    always @(*) begin 
        if (Rs1[31] == 1'b1) begin
            absoluteRs1 = -Rs1;
        end
        if (Rs2[31] == 1'b1) begin
            absoluteRs2 = -Rs2;
        end else begin
            assign absoluteRs1 = Rs1;
            assign absoluteRs2 = Rs2;
        end
    end

    wire [31:0]alu_subtractor;
    assign alu_subtractor = (Rs2 - Rs1);

    always@(*) begin     
        if ((opcode == 7'b1100011) || (opcode == 7'b1100011)) begin 
            if (alu_subtractor == 0) begin
                zero_flag = 1;
                not_zero_flag = ~zero_flag;
            end
            if (alu_subtractor[31] == 0) begin
                g_t_flag = 1;
            end 
            if (alu_subtractor[31] == 1) begin
                l_t_flag = 1;
            end 
            if (absoluteRs1 < absoluteRs2) begin
                l_t_u_flag = 1;
            end
            if (absoluteRs1 >= absoluteRs2) begin
                g_e_u_flag = 1;
            end
        end
        else begin
            zero_flag = 0;
            not_zero_flag = 0;
            g_t_flag = 0;
            l_t_flag = 0;
            l_t_u_flag = 0;
            g_e_u_flag = 0;
        end 
    end

    always @(*) begin 
        if (opcode == 7'1100111)begin 
            jalr_out = Rs1 + immediate;
        end
    end
    
endmodule