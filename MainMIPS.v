`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 11:17:54 AM
// Design Name: 
// Module Name: MainMIPS
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

module MainMIPS(clk, out, pc);
wire [31:0] InstructionMemory [1023:0];
output reg [9:0] pc;
wire [9:0] tempPC;

wire [31:0] instruction;
input clk;
wire [25:0] jumpAddr;
wire jumpBool;
output [31:0] out;



UpdatePC ProgCounterUpdation(jumpAddr, pc, jumpBool, clk, tempPC);
InsDecALUandRegisterAccessing DecALU(instruction, pc, clk, jumpAddr, jumpBool, out);


//assign InstructionMemory[0] = 32'b00000010011001110011100000100000;
assign instruction = 32'b00001100000000000000000000001000;


initial
begin
pc <= 10'd15;

//InstructionMemory[1] <= 32'b00000010011001110011100000100010;
//InstructionMemory[2] <= 32'b00000010011001110011100000100010;
//InstructionMemory[3] <= 32'b00000010011001110011100000100010;
end
always@(posedge clk)
begin
pc <= tempPC;
//instruction <= InstructionMemory[pc];
end
endmodule
