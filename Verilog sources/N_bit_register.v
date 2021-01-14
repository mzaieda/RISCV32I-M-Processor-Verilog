`timescale 1ns / 1ps

module N_bit_register #(parameter N=8)(input clk, input rst, input load, input[N-1:0]D, output [N-1:0] out);

wire [N-1:0]mux_out;

genvar i;
generate
    for (i = 0; i < N; i = i + 1) begin
       //input clk, input rst, input D, output reg Q
        mux2 mu(out[i], D[i], load, mux_out[i]);
        //input A, input B,input S, output reg Y
        dflipflop FF(clk, rst, mux_out[i], out[i]);
        
    end

endgenerate
endmodule
