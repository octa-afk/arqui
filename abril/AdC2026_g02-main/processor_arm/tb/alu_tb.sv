`timescale 1ns/10ps

module alu_tb();
    logic [63:0] a, b;
    logic [3:0] ALUControl;
    logic zero;
    logic [63:0] result;
    alu dut(a, b, ALUControl, zero, result);
    initial
       begin
         //Ejemplo con AND
           ALUControl = 4'b0000; a=64'd8; b=64'd15 ; #10;
           if (result !== 64'd8) $display("Error: se esperaba 8, pero se obtuvo un %d", result);
           a=-64'd20 ; #10;
           if (result !== 64'd12) $display("Error: se esperaba 12, pero se obtuvo un %d", result);
           b=-64'd61 ; #10;
           if (result !== -64'd64) $display("Error: se esperaba -64, pero se obtuvo un %d", result);

         //Ejemplo con OR
           ALUControl = 4'b0001; a=64'd8 ;b=64'd15; #10; 
           if (result !== 64'd15) $display("Error: se esperaba 15, pero se obtuvo un %d", result);
           a=-64'd20 ; #10;
           if (result !== -64'd17) $display("Error: se esperaba -17, pero se obtuvo un %d", result);
           b=-64'd61 ; #10;
           if (result !== -64'd17) $display("Error: se esperaba -17, pero se obtuvo un %d", result);

         //Ejemplo con add
           ALUControl = 4'b0010; a=64'd8; b=64'd15 ; #10;
           if (result !== 64'd23) $display("Error: se esperaba 23, pero se obtuvo un %d", result);
           a=-64'd4 ; #10;
           if (result !== 64'd11) $display("Error: se esperaba 11, pero se obtuvo un %d", result);
           b=-64'd61 ; #10;
           if (result !== -64'd65) $display("Error: se esperaba -65, pero se obtuvo un %d", result);

         //Ejemplo con input b
           ALUControl = 4'b0111;  a=64'd8; b=64'd15 ; #10;     
           if (result !== 64'd15) $display("Error: se esperaba 15, pero se obtuvo un %d", result);
           a=-64'd4 ; #10;
           if (result !== 64'd15) $display("Error: se esperaba 15, pero se obtuvo un %d", result);
           b=-64'd61; #10;
           if (result !== -64'd61) $display("Error: se esperaba -61, pero se obtuvo un %d", result);
         
         //Ejemplo con sub
           ALUControl = 4'b0110; a=64'd8; b=64'd15 ; #10;
           if (result !== -64'd7) $display("Error: se esperaba -7, pero se obtuvo un %d", result);
           a=-64'd4 ; #10;
           if (result !== -64'd19) $display("Error: se esperaba -19, pero se obtuvo un %d", result);
           b=-64'd61 ; #10;
           if (result !== 64'd57) $display("Error: se esperaba 57, pero se obtuvo un %d", result);

         //Verificacion con la bandera ZERO
           if (result !== '0) begin
                if (zero !== 1'd0) $display("Error: al ser result un valor diferente a cero, se esperaba que ZERO=0");
           end
           a = 64'd61; b = 64'd61; #10;
           if (result == '0) begin
               if (zero !== 1'd1) $display("Error: al ser result igual a cero, se esperaba que ZERO=1");
           end

         //Casos de overflow
          ALUControl = 4'b0010; a = 64'h7FFFFFFFFFFFFF01; b = 64'h00000000000000FF; #10;
          if (result !== 64'h8000000000000000) $display("Error: se esperaba h8000000000000000, pero se obtuvo un %h", result);
          else $display("Analisis: se produjo un overflow a causa de sumar dos numeros positivos que superaron 64bits, obteniendo asi un valor negativo");
          $stop;
      end
endmodule
