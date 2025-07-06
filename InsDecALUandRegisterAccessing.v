`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 11:16:33 AM
// Design Name: 
// Module Name: InsDecALUandRegisterAccessing
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
module memory_wrapper(a,d,dpra,clk,we,dpo);

input [9:0] a,dpra;
input clk,we;
output [31:0] dpo;
input [31:0] d; 
     
    dist_mem_gen_0 memory (
  .a(a),        // input wire [9 : 0] a
  .d(d),        // input wire [31 : 0] d
  .dpra(dpra),  // input wire [9 : 0] dpra
  .clk(clk),    // input wire clk
  .we(we),      // input wire we
  .dpo(dpo)    // output wire [31 : 0] dpo
);
endmodule






module InsDecALUandRegisterAccessing(instruction, pc, clk, jumpAddr, jumpBool, out, opcode, rs, rt, rd, shamt, func, data1, data2);
input [31:0] instruction;
input clk;
input pc;
output reg [31:0] out;
output reg [25:0] jumpAddr;
output reg jumpBool;
output wire [5:0] opcode;
output wire [4:0] rs, rt, rd, shamt;
output wire [5:0] func;



assign opcode = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign shamt = instruction[10:6];
assign func = instruction[5:0];
reg [31:0] temp;
reg [63:0] multiplyReg;
reg [4:0] readAddress1, readAddress2;
reg writeEnable;
reg [4:0] writeAddress;
reg [31:0] writeData;
output wire [31:0] data1, data2;
wire reset;


RegisterFile register(readAddress1, readAddress2, writeEnable, writeAddress, writeData, clk, data1, data2);












reg [9:0] a;
reg [31:0] d;
reg [9:0] dpra;
reg we;
wire [31:0] dpo;
memory_wrapper memoryInteger(a, d, dpra, clk, we, dpo);







//reg [4:0] readAddress1fp, readAddress2fp;
//reg writeEnablefp;
//reg [4:0] writeAddressfp;
//reg [31:0] writeDatafp;
//wire [31:0] data1fp, data2fp;
//RegisterFileFP register2(readAddress1fp, readAddress2fp, writeEnablefp, writeAddressfp, writeDatafp, clk, data1fp, data2fp);
//reg [7:0] expA, expB, expResult;
//reg [22:0] manA, manB, manResult;
//reg signA, signB, signResult;
//6'd44: begin
//    writeEnablefp = 0;
//    readAddress1fp <= rs;
//    readAddress2fp <= rt;
//    {signA, expA, manA} <= data1fp;
//    {signB, expB, manB} <= data2fp;
//    if(expB < expA)
//    begin
//    manResult <= manB>>(expA-expB);
//    manB <= manResult;
//    {signResult, expResult, manResult} <= {};
//    end
//    
    
    

initial
begin
readAddress1 <= rs;
readAddress2 <= rt;
writeEnable <= 0;
writeAddress <= 0;
writeData <= 0;
jumpAddr <= 0;
jumpBool <= 0;
a<=0;
d<=0;
dpra <=0;
we<=0;

end



always @(posedge clk)
begin
case(opcode)
    6'd0:begin 
        case(func)
            6'd0: begin 
            writeEnable = 1'b0;
            readAddress1 <= rt;
            temp <= {27'd0, data1};
            writeData <= temp << shamt;
            writeAddress <= rd;
            writeEnable <= 1'b1;
            out <= writeData;
            end // sll
            6'd2: begin 
            writeEnable = 1'b0;
            readAddress1 <= rt;
            temp <= {27'd0, data1};
            writeData <= temp >> shamt;
            writeAddress <= rd;
            writeEnable <= 1'b1;
            out <= writeData;
            end // srl
            6'd3: begin 
            writeEnable = 1'b0;
            readAddress1 <= rt;
            
            if(rt[4]) temp <= {27'd1, data1};
            else temp <= {27'd0, data1};
            
            writeData <= temp >> shamt;
            writeAddress <= rd;
            writeEnable <= 1'b1;
            out <= writeData;
            end // sra
//            6'd4: begin end // sllv
//            6'd6: begin end // srlv
//            6'd7: begin end // srav
            6'd8: begin 
            jumpAddr <= {21'd0,rs};
            jumpBool <= 1;
            out <= 0;
            end // jr
//            6'd9: begin end // jalr
//            6'd12: begin end // syscall
//            6'd13: begin end // break
//            6'd16: begin end // mfhi
//            6'd17: begin end // mthi
//            6'd18: begin end // mflo
//            6'd19: begin end // mtlo
            6'd24: begin 
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            multiplyReg <= data1 * data2;
            writeData = multiplyReg[63:32];
            writeAddress <= 5'd26;
            writeEnable <= 1;
            writeEnable = 0;
            writeData = multiplyReg[31:0];
            writeAddress <= 5'd27;
            writeEnable <= 1;
            out <= writeData;  
            end // mul ??????????????
//            6'd25: begin end // multu
//            6'd26: begin end // div
//            6'd27: begin end // divu
            6'd32: begin 
            writeEnable = 0;
            readAddress1 = rs;
            readAddress2 = rt;
            writeData = data1 + data2;
            writeAddress = rd;
            writeEnable = 1;
            out = writeData;  
            //writeEnable = 0; 
            end // add
            6'd33: begin 
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            writeData <= data1 + data2;
            writeAddress <= rd;
            writeEnable <= 1;
            out = writeData;  
            writeEnable <= 0; 
            end // addu ????
            6'd34: begin
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            writeData <= data1 - data2;
            writeAddress <= rd;
            writeEnable <= 1;
            out <= writeData;
            end // sub
            6'd35: begin
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            writeData <= data1 - data2;
            writeAddress <= rd;
            writeEnable <= 1;
            out <= writeData;  
            end // subu ?????????
            6'd36: begin 
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            writeData <= data1 & data2;
            writeAddress <= rd;
            writeEnable <= 1;
            out <= writeData;  
            end // and
            6'd37: begin 
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            writeData <= data1 | data2;
            writeAddress <= rd;
            writeEnable <= 1;
            out <= writeData;  
            end // or
            6'd38: begin 
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            writeData <= data1 ^ data2;
            writeAddress <= rd;
            writeEnable <= 1;
            out <= writeData;  end // xor
            6'd39: begin 
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            writeData <= data1 | data2;
            writeData <= ~writeData;
            writeAddress <= rd;
            writeEnable <= 1;
            out <= writeData;  end // nor
            6'd42: begin 
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            if(data1 < data2) writeData <= 32'd1;
            else writeData <= 32'd0;
            writeAddress <= rd;
            writeEnable <= 1;
            out <= writeData;  
            end // slt
            6'd43: begin 
            writeEnable = 0;
            readAddress1 <= rs;
            readAddress2 <= rt;
            if(data1 < data2) writeData <= 32'd1;
            else writeData <= 32'd0;
            writeAddress <= rd;
            writeEnable <= 1;
            out <= writeData;  
            end // sltu ????????????
            
            
            default: out <= 0;
        endcase
    end //R type
    6'd1:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    readAddress2 <= rt;
    if(data1[31] == 1)
    begin
    jumpAddr <= {10'd0, rd, shamt, func};
    jumpBool <= 1;
    end
    out <= 0;
    end // bltz
    6'd2:begin 
    jumpAddr <= {rs, rt, rd, shamt, func};
    jumpBool <= 1;
    end // jump
    6'd3:begin 
    writeEnable = 0;
    jumpAddr <= {rs, rt, rd, shamt, func};
    jumpBool <= 1;
//    writeEnable = 0;
    writeData <= {23'd0,pc+1};
    writeAddress <= 32'd31;
    readAddress1 <= 32'd31;
    
    writeEnable <= 1;
    out <= data1;
    end // jal
    6'd4:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    readAddress2 <= rt;
    if(data1-data2 == 0)
    begin
    jumpAddr <= {10'd0, rd, shamt, func};
    jumpBool <= 1;
    end
    out<=0;
    end // beq
    6'd5:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    readAddress2 <= rt;
    if(data1-data2 != 0)
    begin
    jumpAddr <= {10'd0, rd, shamt, func};
    jumpBool <= 1;
    end
    out <= 0;
    end // bne
    6'd6:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    readAddress2 <= rt;
    if(data1[31] == 1 || data1 == 32'd0)
    begin
    jumpAddr <= {10'd0, rd, shamt, func};
    jumpBool <= 1;
    end
    out <= 0;
    end // blez
    6'd7:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    readAddress2 <= rt;
    if(data1[31] == 0)
    begin
    jumpAddr <= {10'd0, rd, shamt, func};
    jumpBool <= 1;
    end
    out <= 0;
    end // bgtz
    6'd8:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    writeData <= data1 + {16'd0, rd, shamt, func};
    writeAddress <= rt;
    writeEnable <= 1;
    out <= writeData;
    end // addi
    6'd9:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    writeData <= data1 + {16'd0, rd, shamt, func};
    writeAddress <= rt;
    writeEnable <= 1;
    out <= writeData;
    end // addiu ???????????????
    6'd10:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    temp<= data1 - {16'd0, rd, shamt, func};
    if(temp[31] == 1) writeData <= 32'd1;
    else writeData <= 32'd0;
    writeAddress <= rt;
    writeEnable <= 1;
    out <= writeData;
    end // slti
//    6'd11:begin end // sltiu
    6'd12:begin
    writeEnable = 0;
    readAddress1 <= rs;
    writeData <= data1 & {16'd0, rd, shamt, func};
    writeAddress <= rt;
    writeEnable <= 1;
    out <= writeData; 
    end // andi
    6'd13:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    writeData <= data1 | {16'd0, rd, shamt, func};
    writeAddress <= rt;
    writeEnable <= 1;
    out <= writeData; 
    end // ori
    6'd14:begin 
    writeEnable = 0;
    readAddress1 <= rs;
    writeData <= data1 ^ {16'd0, rd, shamt, func};
    writeAddress <= rt;
    writeEnable <= 1;
    out <= writeData; 
    end // xori
    6'd15:begin 
    writeEnable = 0;
    readAddress1 <= rt;
    writeData <= {rd, shamt, func, data1[15:0]};
    writeAddress <= rt;
    readAddress1 <= 5'd0;
    writeEnable <= 1;
    out <= writeData; 
    end // lui
//    6'd32:begin end // lb
//    6'd33:begin end // lh
//    6'd34:begin end // lwl
    6'd35:begin 
    // (a,d,dpra,clk,we,dpo);
    writeEnable = 0;
    readAddress1 <= rs;
    writeData <= data1;
    writeAddress <= rt;
    writeEnable <= 1;
    out <= writeData;
    end // lw
//    6'd36:begin end // lbu
//    6'd37:begin end // lhu
//    6'd38:begin end // lwr
//    6'd40:begin end // sb
//    6'd41:begin end // sh
//    6'd42:begin end // swl
    6'd43:begin 
    we = 0;
    readAddress1 <= rt;
    a <= {shamt[3:0], func};
    d <= data1;
    we<=1;
    
    end // sw
    
//    6'd46:begin end // swr
    default: out <= 0;
    endcase
end


endmodule
