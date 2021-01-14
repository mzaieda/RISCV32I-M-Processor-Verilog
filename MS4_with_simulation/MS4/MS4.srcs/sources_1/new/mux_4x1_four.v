`timescale 1ns/1ns
module mux_4x1_four ( input [31:0] a, [31:0] b, [31:0] c, [31:0]d,  input branch_check, input [1:0] s0, output reg [31:0] out, output reg branchtaken);


always @ (*)
begin

case (s0)
2'b00 : begin 
out <= a;
branchtaken = 0;
end
2'b01 :begin

if (branch_check == 1) begin
out <= b; //take the branch
branchtaken = 1;
end else if (branch_check ==0 ) begin
 out <= a; //branch not taken so go to PC + 4
 branchtaken = 0;
end
 
 end
2'b10 : begin
out <= c;
branchtaken = 0;
end
2'b11 : begin
out <= d;
 branchtaken = 0;
end
endcase

end

endmodule