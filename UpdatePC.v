`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 11:17:21 AM
// Design Name: 
// Module Name: UpdatePC
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


module UpdatePC(address, pc, isBranch, clk, updatedPC);
input [25:0] address;
input [9:0] pc;
input isBranch;
input clk;
output [9:0] updatedPC;

//always@(posedge clk)
//begin
assign updatedPC = isBranch ? address[9:0] : pc+1;
//end

endmodule

