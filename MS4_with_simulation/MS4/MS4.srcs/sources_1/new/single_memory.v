`timescale 1ns/1ns

module single_memory
(input slower_clock, input MemRead, input MemWrite,
input [31:0] addr, input [31:0] data_in, input [1:0] state, input sign, output [31:0] data_out);

reg [7:0] mem [(128-1):0]; //Byte addressable memory (1 GB elemetns each elemtns contains 8 bits)
reg [31:0] my_data, my_instr;
wire [31:0] base = 64; //base of data memory
//fetch instruction at pos edge and access data at neg edge

initial begin
$readmemh("instructions_mem.mem", mem);
	mem[0+base]=8'b00000011;  
	mem[1+base]=8'b00000001;
	mem[2+base]=8'b00000000;
	mem[3+base]=8'b00000000;
	mem[4+base]=8'b00000011;
	mem[5+base]=8'b00000001;
	mem[6+base]=8'b00000000;
	mem[7+base]=8'b00000000;
	mem[8+base]=8'b00000101;
	mem[9+base]=8'b00000000;
	mem[10+base]=8'b00000000;
	mem[11+base]=8'b00000000;
	
end

always @(*) begin //latest update here
my_instr = {mem[addr+3],mem[addr+2],mem[addr+1], mem[addr+0]};//change here 

end
always @(negedge slower_clock) begin
if (MemWrite) begin
if (state == 0) begin
        mem[addr+base] <= data_in[7:0];
//Store Half 
end else if (state == 1) begin

    mem[addr+base] <= data_in[7:0];
    mem[addr+1+base] <= data_in[15:8];
 
//Store Word
end else if (state == 2) begin
// store word signed
        mem[addr+base] <= data_in[7:0];
        mem[addr+1+base] <= data_in[15:8];
        mem[addr+2+base] <= data_in[23:16];
        mem[addr+3+base] <= data_in[31:24];
    end
end //if memWrite
end //alwasy closing

always @(*) begin 
if (MemRead) begin
    //Load Byte signed
    if (state == 0 && sign == 0) begin
        my_data <= {{24{mem[addr+base][7]}},mem[addr+base]};           
        //load byte unsigned
    end else if (state ==0 && sign == 1) begin
        my_data <= {24'b0,mem[addr+base]};    
    //Load Half signed
    end else if (state == 2'b01 && sign == 0) begin  
           my_data = {{16{mem[addr+base+1][7]}},mem[addr+1+base], mem[addr+base]};
        //load half unsigned
    end else if (state == 2'b01 && sign == 1) begin
        my_data = {16'b0,mem[addr+1+base], mem[addr+base]};
        //Load Word signed
    end else if (state == 2'b10 && sign == 1) begin
           my_data = {mem[addr+3+base],mem[addr+2+base],mem[addr+1+base], mem[addr+base]};
        //load Word unsigned
    end else if (state == 2'b10 && sign == 0) begin
        my_data = {mem[addr+3+base],mem[addr+2+base],mem[addr+1+base], mem[addr+base]};
    end else 
        my_data = 0;
    
//closing if memRead
end
end
//clsing always

muxarray choose_data(my_data, my_instr, slower_clock, data_out);

endmodule