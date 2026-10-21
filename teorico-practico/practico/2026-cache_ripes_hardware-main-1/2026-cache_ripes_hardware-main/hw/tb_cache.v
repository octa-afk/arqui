/*
 * tb_cache.v
 *
 * Testbench básico para verificar cache_comparator con iverilog.
 * Verifica que la lógica de hit y la selección de vía sean correctas.
 *
 * Uso:
 *   iverilog -o tb_cache tb_cache.v cache_comparator.v && ./tb_cache
 */

`timescale 1ns/1ps
`default_nettype none

module tb_cache;

    /* Parámetros de prueba: 2-way, tag 4 bits, datos 8 bits (simplificado) */
    localparam W = 2;
    localparam T = 4;
    localparam D = 8;

    reg  [T-1:0]   addr_tag;
    reg  [W*T-1:0] stored_tags;
    reg  [W-1:0]   valid;
    reg  [W*D-1:0] data_lines;
    wire           hit;
    wire [D-1:0]   data_out;

    cache_comparator #(.W(W), .T(T), .D(D)) dut (
        .addr_tag    (addr_tag),
        .stored_tags (stored_tags),
        .valid       (valid),
        .data_lines  (data_lines),
        .hit         (hit),
        .data_out    (data_out)
    );

    task check;
        input exp_hit;
        input [D-1:0] exp_data;
        input [31:0] test_num;
        begin
            #1;
            if (hit !== exp_hit || (exp_hit && data_out !== exp_data)) begin
                $display("FAIL test %0d: hit=%b (exp %b), data=0x%02X (exp 0x%02X)",
                         test_num, hit, exp_hit, data_out, exp_data);
            end else begin
                $display("PASS test %0d: hit=%b, data=0x%02X", test_num, hit, data_out);
            end
        end
    endtask

    initial begin
        $dumpfile("tb_cache.vcd");
        $dumpvars(0, tb_cache);

        /* Test 1: caché vacía → miss */
        addr_tag    = 4'b1010;
        stored_tags = {4'b0000, 4'b0000};
        valid       = 2'b00;
        data_lines  = {8'hBB, 8'hAA};
        check(1'b0, 8'h00, 1);

        /* Test 2: hit en vía 0 */
        addr_tag    = 4'b1010;
        stored_tags = {4'b0000, 4'b1010};  /* vía 0 tiene tag 1010 */
        valid       = 2'b01;
        data_lines  = {8'hBB, 8'hAA};
        check(1'b1, 8'hAA, 2);

        /* Test 3: hit en vía 1 */
        addr_tag    = 4'b1100;
        stored_tags = {4'b1100, 4'b1010};  /* vía 1 tiene tag 1100 */
        valid       = 2'b11;
        data_lines  = {8'hCC, 8'hAA};
        check(1'b1, 8'hCC, 3);

        /* Test 4: tag coincide pero valid=0 → miss */
        addr_tag    = 4'b1010;
        stored_tags = {4'b0000, 4'b1010};
        valid       = 2'b00;               /* valid=0: no vale el tag */
        data_lines  = {8'hBB, 8'hAA};
        check(1'b0, 8'h00, 4);

        /* Test 5: tag distinto en ambas vías → miss */
        addr_tag    = 4'b0001;
        stored_tags = {4'b1100, 4'b1010};
        valid       = 2'b11;
        data_lines  = {8'hCC, 8'hAA};
        check(1'b0, 8'h00, 5);

        $display("---");
        $display("Testbench completado.");
        $finish;
    end

endmodule
