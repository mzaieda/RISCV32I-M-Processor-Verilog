// file: decoder32.v
// author: @maco

`timescale 1ns/1ns

module decoder32(input[4:0] a,input regwrite, output reg [31:0] out);
integer i;

always @(*) begin
out=0;
out[a]=regwrite;
end



endmodule