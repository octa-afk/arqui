`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 08/20/2026 07:01:58 PM
// Design Name:
// Module Name: maindec_tb
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

module maindec_tb();
    logic [10:0] Op;
    logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    logic [1:0] ALUOp;

    maindec dut(Op, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead,
        MemWrite, Branch, ALUOp);

    initial begin
        Op = 11'b100_0101_1000; #10; // ADD
        if (Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 || RegWrite != 1
            || MemRead != 0 || MemWrite != 0 || Branch != 0 || ALUOp != 2'b10)
            $display("ADD fallo");
        Op = 11'b110_0101_1000; #10; // SUB
        if (Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 || RegWrite != 1
            || MemRead != 0 || MemWrite != 0 || Branch != 0 || ALUOp != 2'b10)
            $display("SUB fallo");
        Op = 11'b100_0101_0000; #10; // AND
        if (Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 || RegWrite != 1
            || MemRead != 0 || MemWrite != 0 || Branch != 0 || ALUOp != 2'b10)
            $display("AND fallo");
        Op = 11'b101_0101_0000; #10; // ORR
        if (Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 || RegWrite != 1
            || MemRead != 0 || MemWrite != 0 || Branch != 0 || ALUOp != 2'b10)
            $display("ORR fallo");
        Op = 11'b111_1100_0010; #10; // LDUR
        if (Reg2Loc != 0 || ALUSrc != 1 || MemtoReg != 1 || RegWrite != 1
            || MemRead != 1 || MemWrite != 0 || Branch != 0 || ALUOp != 2'b00)
            $display("LDUR fallo");
        Op = 11'b111_1100_0000; #10; // STUR
        if (Reg2Loc != 1 || ALUSrc != 1 || MemtoReg != 0 || RegWrite != 0
            || MemRead != 0 || MemWrite != 1 || Branch != 0 || ALUOp != 2'b00)
            $display("STUR fallo");
        Op = 11'b101_1010_0000; #10; // CBZ con 0s
        if (Reg2Loc != 1 || ALUSrc != 0 || MemtoReg != 0 || RegWrite != 0
            || MemRead != 0 || MemWrite != 0 || Branch != 1 || ALUOp != 2'b01)
            $display("CBZ0 fallo");
        Op = 11'b101_1010_0111; #10; // CBZ con 1s
        if (Reg2Loc != 1 || ALUSrc != 0 || MemtoReg != 0 || RegWrite != 0
            || MemRead != 0 || MemWrite != 0 || Branch != 1 || ALUOp != 2'b01)
            $display("CBZ1 fallo");
        Op = 11'b111_1111_0100; #10; // OPcode random (no matchea a un opcode valido)
        if (Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 || RegWrite != 0
            || MemRead != 0 || MemWrite != 0 || Branch != 0 || ALUOp != 2'b00)
            $display("OP random fallo");
    end
endmodule
