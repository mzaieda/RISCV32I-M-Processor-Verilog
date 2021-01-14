`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2020 05:18:27 PM
// Design Name: 
// Module Name: FullProcessor_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISCVHandler_tb();
    reg clk, rst;
    
    RISCVHandler test(clk, rst);
    
    
    
    initial begin 
    rst=1; 
    #50;
    rst=0;
    end 
    
    initial begin
    clk = 1;
    forever #50 clk = ~clk;
    end
    
endmodule
