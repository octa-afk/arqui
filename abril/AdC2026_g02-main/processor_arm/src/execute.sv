
module execute(input logic AluSrc,
               input logic [3:0] AluControl,
               input logic [63:0] PC_E,
               input logic [63:0] signlmm_E,
               input logic [63:0] readData1_E,
               input logic [63:0] readData2_E,
               output logic [63:0] PCBranch_E,
               output logic [63:0] aluResult_E,
               output logic [63:0] writeData_E,
               output logic zero_E);

    logic [63:0] mux_output_E; //salida mux
    logic [63:0] sl2_output_E; //salida sl2

    mux2 Mux(readData2_E, signlmm_E, AluSrc, mux_output_E);
    alu Alu(readData1_E, mux_output_E, AluControl, aluResult_E, zero_E);
    sl2 Sl2(signlmm_E, sl2_output_E);
    adder add(PC_E, sl2_output_E, PCBranch_E);

    assign writeData_E = readData2_E;

endmodule