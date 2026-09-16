module fetch(
    input logic PCSrc_F,
    input logic clk,
    input logic reset,
    input logic [63:0] PCBranch_F,
    output logic [63:0] imem_addr_F
);

logic [63:0] output_mux;
logic [63:0] input_add=64'd4;
logic [63:0] output_add;

mux2 mux(output_add, PCBranch_F, PCSrc_F, output_mux);

adder add(input_add, imem_addr_F, output_add);

flopr #(64) flop(clk, reset, output_mux , imem_addr_F);

endmodule