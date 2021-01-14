`timescale 1ns/1ns
module mux_4x1_four ( input [31:0] a, [31:0] b, [31:0] c, [31:0]d,  input branch_check, input [1:0] s0, output reg [31:0] out);


always @ (*)
begin

case (s0)
2'b00 : out <= a;
2'b01 :begin
if (branch_check == 1) begin
out <= b; //take the branch
end else if (branch_check ==0 ) begin
 out <= a; //branch not taken so go to PC + 4
end
 
 end
2'b10 :out <= c;

2'b11 : out <= d;
endcase

end

endmodule