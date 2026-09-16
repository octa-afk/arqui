`timescale 1ns / 1ps

module execute_tb();

    logic AluSrc;
    logic [3:0] AluControl;
    logic [63:0] PC_E;
    logic [63:0] signlmm_E;
    logic [63:0] readData1_E;
    logic [63:0] readData2_E;
    logic [63:0] PCBranch_E;
    logic [63:0] aluResult_E;
    logic [63:0] writeData_E;
    logic zero_E;

    execute dut(AluSrc, AluControl, PC_E, signlmm_E, readData1_E, readData2_E, PCBranch_E, aluResult_E, writeData_E, zero_E);

    initial begin
        //Caso 1: alusrc = 0 (uso readdata2)
        AluSrc = 0;
        AluControl = 4'b0010; //ADD

        PC_E = 64'd80;
        signlmm_E = 64'd20;

        readData1_E = 64'd5;
        readData2_E = 64'd2;

        #10;

        if(aluResult_E == 64'd7)
            $display("correcto : resultado caso 1");
        else
            $display("error : resultado caso 1");
        
        if(writeData_E == 64'd2)
            $display("correcto: write data caso 1");
        else
            $display("error: write data caso 1");

        if(PCBranch_E == 64'd160)
            $display("correcto: Branch_E");
        else
            $display("error: Branch_E");
        
        //caso 2: alusrc = 1 (uso signlmm_e)
        AluSrc = 1;
        AluControl = 4'b0010; //ADD

        PC_E = 64'd80;
        signlmm_E = 64'd20;

        readData1_E = 64'd5;
        readData2_E = 64'd10;

        #10;

        if(aluResult_E == 64'd25)
            $display("correcto : resultado caso 2");
        else
            $display("error : resultado caso 2");
        
        if(writeData_E == 64'd10)
            $display("correcto: write data caso 2");
        else
            $display("error: write data caso 2");

        //caso 3: Flag zero
        AluSrc = 0;
        AluControl = 4'b0110; //SUB

        readData1_E = 64'd10;
        readData2_E = 64'd10;

        #10;

        if((aluResult_E == 64'd0) && (zero_E == 1))
            $display("correcto : flag zero");
        else
            $display("error : flag zero");


        $stop;
    end
endmodule