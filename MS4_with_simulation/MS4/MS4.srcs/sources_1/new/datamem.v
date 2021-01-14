`timescale 1ns/1ns

module datamem
(input clk, input MemRead, input MemWrite,
input [31:0] addr, input [31:0] data_in, input [1:0] state, input sign, output reg [31:0] data_out);

reg [7:0] mem [500:0]; //Byte addressable memory (1 GB elemetns each elemtns contains 8 bits)
always @(posedge clk) begin

data_out = 0;
if (MemWrite) begin
//

    //Store Byte 
if (state == 0) begin
        mem[addr] <= data_in[7:0];
//Store Half 
end else if (state == 1) begin

    mem[addr] <= data_in[7:0];
    mem[addr+1] <= data_in[15:8];
 
//Store Word
end else if (state == 2) begin
// store word signed
        mem[addr] <= data_in[7:0];
        mem[addr+1] <= data_in[15:8];
        mem[addr+2] <= data_in[23:16];
        mem[addr+3] <= data_in[31:24];
    end
end //if memWrite
end //alwasy closing

always @(*) begin 

if (MemRead) begin
    //Load Byte signed
    if (state == 0 && sign == 0) begin
        data_out <= {{24{mem[addr][7]}},mem[addr]};           
        //load byte unsigned
    end else if (state ==0 && sign == 1) begin
        data_out <= {24'b0,mem[addr]};    
    //Load Half signed
    end else if (state == 1 && sign == 0) begin  
           data_out = {{16{mem[addr+1][7]}},mem[addr+1], mem[addr]};
        //load half unsigned
    end else if (state == 1 && sign == 1) begin
        data_out = {16'b0,mem[addr+1], mem[addr]};
        //Load Word signed
    end else if (state == 2 && sign == 1) begin
           data_out = {mem[addr+3],mem[addr+2],mem[addr+1], mem[addr]};
        //load Word unsigned
    end else if (state == 2 && sign == 0) begin
        data_out = {mem[addr+3],mem[addr+2],mem[addr+1], mem[addr]};
   

    end
//closing if memRead
end

//clsing always
end

initial begin
	mem[0]=8'b00000011;  
	mem[1]=8'b00000000;
	mem[2]=8'b00000000;
	mem[3]=8'b00000001;
	mem[4]=8'b00001010;
	mem[5]=8'b00000000;
	mem[6]=8'b00000000;
	mem[7]=8'b00000000;
	mem[8]=8'b00000101;
	mem[9]=8'b00000000;
	mem[10]=8'b00000000;
	mem[11]=8'b00000000;
	//mem[3]=8'd17;
	//mem[4]=8'd9;
	//mem[5]=8'd25;
end

endmodule
