
`timescale 1ns/1ns

module muxarray(input [31:0] a, input [31:0] b, input sel, output [31:0]out);
genvar i;

generate

for (i = 0; i < 32; i = i + 1)
begin
mux2 mod1(a[i] ,b[i], sel, out[i]);
end
endgenerate

endmodule