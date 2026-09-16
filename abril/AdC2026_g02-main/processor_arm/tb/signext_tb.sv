module signext_tb();
    logic [31:0] a;
    logic [63:0] y;
    int errores = 0;

    signext dut (.a(a), .y(y));

    task automatic probar(input logic [31:0] instr,
                          input logic [63:0] esperado,
                          input string       nombre);
        a = instr;
        #10;
        if (y !== esperado) begin
            $display("[ERROR] %-34s a=%h -> y=%h (esperado %h)", nombre, instr, y, esperado);
            errores++;
        end else begin
            $display("[  OK ] %-34s a=%h -> y=%h (%0d dec)", nombre, instr, y, $signed(y));
        end
    endtask

    initial begin
        $display("\n===== Ejercicio 2b: test bench de signext =====");
        probar({11'b111_1100_0010, 9'd8,            2'b00, 5'd2,  5'd1},   64'sd8,
               "LDUR inmediato positivo (+8)");
        probar({11'b111_1100_0010, 9'd255,          2'b00, 5'd2,  5'd1},   64'sd255,
               "LDUR inmediato positivo (+255)");
        probar({11'b111_1100_0010, 9'b1_1111_1000,  2'b00, 5'd30, 5'd25}, -64'sd8,
               "LDUR inmediato negativo (-8)");
        probar({11'b111_1100_0010, 9'b1_0000_0000,  2'b00, 5'd2,  5'd1},  -64'sd256,
               "LDUR inmediato negativo (-256)");
        probar({11'b111_1100_0000, 9'd8,            2'b00, 5'd0,  5'd2},   64'sd8,
               "STUR inmediato positivo (+8)");
        probar({11'b111_1100_0000, 9'd136,          2'b00, 5'd0,  5'd21},  64'sd136,
               "STUR inmediato positivo (+136)");
        probar({11'b111_1100_0000, 9'b1_1111_1000,  2'b00, 5'd30, 5'd25}, -64'sd8,
               "STUR inmediato negativo (-8)");
        probar({11'b111_1100_0000, 9'b1_1111_1111,  2'b00, 5'd2,  5'd1},  -64'sd1,
               "STUR inmediato negativo (-1)");
        probar({8'b1011_0100, 19'd4,      5'd0},  64'sd4,
               "CBZ inmediato positivo (+4)");
        probar({8'b1011_0100, 19'd100,    5'd5},  64'sd100,
               "CBZ inmediato positivo (+100)");
        probar({8'b1011_0100, 19'h7_FFFC, 5'd2}, -64'sd4,
               "CBZ inmediato negativo (-4)");
        probar({8'b1011_0100, 19'h4_0000, 5'd2}, -64'sd262144,
               "CBZ inmediato negativo (minimo)");
        probar(32'hb4ffff82, -64'sd4, "CBZ real (b4ffff82) = -4");
        probar(32'hb4000040,  64'sd2, "CBZ real (b4000040) = +2");
        probar(32'h8b050083, 64'd0, "ADD X3,X4,X5     -> y = 0");
        probar(32'hcb050083, 64'd0, "SUB X3,X4,X5     -> y = 0");
        probar(32'h8a1f0145, 64'd0, "AND X5,X10,XZR   -> y = 0");
        probar(32'haa1f0166, 64'd0, "ORR X6,X11,XZR   -> y = 0");
        probar(32'h00000000, 64'd0, "Todo ceros       -> y = 0");
        probar(32'hFFFFFFFF, 64'd0, "Opcode inexistente -> y = 0");
        probar(32'h14000001, 64'd0, "B (no implementada) -> y = 0");
        $display("\n===== FIN: %0d errores =====", errores);
        if (errores == 0) $display(">>> TEST SIGNEXT: PASA");
        else              $display(">>> TEST SIGNEXT: FALLA");
        $finish;
    end
endmodule
