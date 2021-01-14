
`timescale 1ns/1ns

module instrMemory (input [31:0] addr, output [31:0] data_out);
reg [7:0] mem [(500-1):0];

initial begin
$readmemh("instructions_mem.mem", mem);

end

assign data_out = {mem[addr+0],mem[addr+1],mem[addr+2],mem[addr+3]};
endmodule