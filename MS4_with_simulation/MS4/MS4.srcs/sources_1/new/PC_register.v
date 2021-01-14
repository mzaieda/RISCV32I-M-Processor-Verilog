
`timescale 1ns/1ns

module PC_register(input [31:0] a, input clk, input rst, input sel, output[31:0] out );
wire [31:0] out_before;
genvar i;

generate

for ( i=0; i<32;i=i+1)
begin
mux2 mod1(out[i] ,a[i], sel, out_before[i]);
dflipflop mod2(clk,rst,out_before[i], out[i]);

end
endgenerate

endmodule