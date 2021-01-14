`timescale 1ns/1ns
module mux_4x1 ( input [31:0] a, [31:0] b, [31:0] c, [31:0] d, [1:0] s0, output reg [31:0] out);


always @ (*)
begin

case (s0)
2'b00 : out <= a;
2'b01 : out <= b;
2'b10 : out <= c;
2'b11 : out <= d;
endcase

end

endmodule