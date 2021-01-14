`timescale 1ns / 1ps
/*******************************************************************
*
* Module: branchOutputs.v
* Project: RISCV32I
* Author: Mohammed Zaieda, mzaieda@aucegypt.edu
* Description: This module should operate on controlling the outputs for each case
* statement given below and assigning the output to appropriate register.
*
* Change history: 23/10/20 - Created this file, and set the backbone of the file.
* 24/10/20 - Fixed some issues, finished editting the file, added comments. 
*
**********************************************************************/

`include "defines.v"

module branchOutput(
    input [2:0]funct3, 
    input branch, //branch 1/0 from the control unit
    input Z,        //zero flag
    input C,        //carry
    input V,        //overflow
    input S,        //sign 
    output reg branch_output
);
/*this always block will execute, and assigning the output of
this module to the appropriate number to see if it is a 
branch or not, with the appropriate conditions.
*/
	always @(*) begin
		if(branch) begin
			if((funct3 == `BR_BEQ) && Z)begin
				 branch_output = 1;
			end else if ((funct3 == `BR_BNE) && ~Z) begin
					 branch_output = 1;
			end else if((funct3 == `BR_BLT) && (S!=V)) begin
					 branch_output = 1;	
			end else if((funct3 == `BR_BGE) && (S==V)) begin
					 branch_output = 1;
			end else if ((funct3 == `BR_BLTU) && ~C) begin
					 branch_output = 1;
			end else if ((funct3 == `BR_BGEU) && C) begin
					 branch_output = 1;
			end 
		end
        else begin 
            branch_output = 0;
        end
	end
endmodule