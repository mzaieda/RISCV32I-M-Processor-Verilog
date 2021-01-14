`timescale 1ns/1ns

module slower_clock
(input clk, input rst, input D, output reg Q);
always @ (posedge clk ) begin // Asynchronous Reset
  if(rst) begin
  Q <= clk;
  end else begin
 Q<= Q+1;
    end
    end
endmodule