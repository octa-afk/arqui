`timescale 1ns/10ps

module fetch_tb();
    logic PCSrc_F, clk, reset;
    logic [63:0] PCBranch_F, imem_addr_F; 
    
    fetch dut(PCSrc_F, clk, reset, PCBranch_F, imem_addr_F);

    always begin
        clk=0; #5; clk=1; #5; 
    end

    initial begin
        reset = 1;
        #50;
        reset = 0;
        PCSrc_F = 0;
        PCBranch_F = 64'd3;
        @(posedge clk);
        #1;

        if(imem_addr_F != 64'd4) $display("Error: debería ser 4");
        PCSrc_F = 1;
        @(posedge clk);
        #1;
        if(imem_addr_F != PCBranch_F) $display("Error: debería ser igual que PCBranch_F");

     end

endmodule