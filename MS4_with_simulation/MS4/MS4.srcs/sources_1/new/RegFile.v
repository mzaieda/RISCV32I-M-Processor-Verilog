
`timescale 1ns/1ns

module RegFile (
input clk, rst,
input [4:0] readreg1, readreg2, writereg,
input [31:0] writedata,
input regwrite,
output [31:0] readdata1, readdata2 );
 
 //wire [31:0] inregs [0:31]; 
  wire [31:0] myregs [0:31];
  wire [31:0] load;
  
  genvar i;

generate

for ( i=0; i<32;i=i+1)
begin
PC_register mod1(writedata, clk, rst, load[i], myregs[i] );
end
endgenerate
 
assign readdata1= myregs [readreg1];
assign readdata2= myregs [readreg2];
decoder32 mod4(writereg,writereg==0?0:regwrite, load);
 
endmodule