`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 01:18:21 PM
// Design Name: 
// Module Name: RegisterFile
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

module RegisterFile(readAddress1, readAddress2, writeEnable, writeAddress, writeData, clk, data1, data2);
input [4:0] readAddress1, readAddress2;
input writeEnable;
input [4:0] writeAddress;
input [31:0] writeData;
input clk;
output [31:0] data1, data2;

reg [31:0] RegisterFile[31:0];


initial
begin
RegisterFile[0] <= 32'd0;
RegisterFile[1] <= 32'd0;
RegisterFile[2] <= 32'd0;
RegisterFile[3] <= 32'd0;
RegisterFile[4] <= 32'd0;
RegisterFile[5] <= 32'd0;
RegisterFile[6] <= 32'd0;
RegisterFile[7] <= 32'd5;
RegisterFile[8] <= 32'd0;
RegisterFile[9] <= 32'd0;
RegisterFile[10] <= 32'd0;
RegisterFile[11] <= 32'd0;
RegisterFile[12] <= 32'd0;
RegisterFile[13] <= 32'd0;
RegisterFile[14] <= 32'd0;
RegisterFile[15] <= 32'd0;
RegisterFile[16] <= 32'd0;
RegisterFile[17] <= 32'd0;
RegisterFile[18] <= 32'd13;
RegisterFile[19] <= 32'd10;
RegisterFile[20] <= 32'd0;
RegisterFile[21] <= 32'd0;
RegisterFile[22] <= 32'd0;
RegisterFile[23] <= 32'd0;
RegisterFile[24] <= 32'd0;
RegisterFile[25] <= 32'd0;
RegisterFile[26] <= 32'd0;
RegisterFile[27] <= 32'd0;
RegisterFile[28] <= 32'd0;
RegisterFile[29] <= 32'd0;
RegisterFile[31] <= 32'd0;
RegisterFile[32] <= 32'd0;
end

assign data1 = RegisterFile[readAddress1];
assign data2 = RegisterFile[readAddress2];
always@(posedge clk)
begin
RegisterFile[writeAddress] <= writeEnable ? writeData : RegisterFile[writeAddress];
end

endmodule


