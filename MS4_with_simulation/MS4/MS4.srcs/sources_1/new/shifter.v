`timescale 1ns / 1ps
/*******************************************************************
*
* Module: shifter.v
* Project: RISCV32I
* Author: Mohammed Zaieda, mzaieda@aucegypt.edu
* Description: This module will handle 3 of the shift instructions, 
* the ones with no immediates.
*
* Change history: 24/10/20 - Created this file, and finished it. 
* 25/10/20 - Nothing
*
**********************************************************************/

`include "defines.v"

module shifter(
    input signed [31:0]a, 
    input [4:0]shamt, 
    input [1:0]type, 
    output reg [31:0]r
);

	always @(*) begin
		if(type == 2'b00)begin
			 r = a >> shamt;   //srl instruction performed
        end else if (type == 2'b10)begin
                 r = a >>> shamt;   //sra with an extra > character to indicate for the shift arithmetic
           
        end else if (type == 2'b01)begin
                 r = a << shamt;   //sll instruction performed
         end else if (type == 2'b11)begin
                 r = a;   //give the output the input with no change
         end
        
	end //always
endmodule