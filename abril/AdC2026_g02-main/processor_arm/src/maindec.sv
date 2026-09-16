`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2026 06:44:20 PM
// Design Name: 
// Module Name: maindec
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


module maindec(input logic [10:0] Op,
    output logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,
    output logic [1:0] ALUOp
    );
    always_comb
        casez(Op)
            11'b111_1100_0010 :  begin // LDUR
                Reg2Loc = 0; ALUSrc = 1; MemtoReg = 1; RegWrite = 1; 
                MemRead = 1; MemWrite = 0; Branch = 0; ALUOp = 2'b00;
            end
            11'b111_1100_0000 :  begin // STUR
                Reg2Loc = 1; ALUSrc = 1; MemtoReg = 0; RegWrite = 0; 
                MemRead = 0; MemWrite = 1; Branch = 0; ALUOp = 2'b00;
            end
            11'b101_1010_0??? :  begin // CBZ
                Reg2Loc = 1; ALUSrc = 0; MemtoReg = 0; RegWrite = 0; 
                MemRead = 0; MemWrite = 0; Branch = 1; ALUOp = 2'b01;
            end
            11'b???_0101_???? :  begin // R-format
                Reg2Loc = 0; ALUSrc = 0; MemtoReg = 0; RegWrite = 1; 
                MemRead = 0; MemWrite = 0; Branch = 0; ALUOp = 2'b10;
            end
            default: begin
                Reg2Loc = 0; ALUSrc = 0; MemtoReg = 0; RegWrite = 0; 
                MemRead = 0; MemWrite = 0; Branch = 0; ALUOp = 2'b00;
            end
        endcase
endmodule
