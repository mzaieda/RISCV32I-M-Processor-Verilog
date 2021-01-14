`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2020 04:35:57 AM
// Design Name: 
// Module Name: top_module
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


module top_module(input clk,
input uart_in,

output  [3:0] Anode,
output  [6:0] LED_out
,output [7:0] out_uart    );

UART_receiver_multiple_Keys(
     clk,
     uart_in, 
  out_uart
   );
   
//   wire [4:0]outripple;
//   wire [3:0] sum;
//   wire carryout;
//   ripple0 mod1(out_uart [7:4], out_uart [3:0],outripple);

 Four_Digit_Seven_Segment_Driver_Optimized(clk, {5'd0,out_uart},Anode,LED_out);
endmodule
