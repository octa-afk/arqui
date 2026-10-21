# Parcial 1 2023

> **Fuente:** `Parcial 1 2023.pdf`
> **Método:** extracción de texto embebido

## Nota de legibilidad

No se detectaron incertidumbres adicionales durante la extracción automática. Verificar visualmente fórmulas o símbolos especiales si se necesita fidelidad tipográfica exacta.

## Contenido

Ejercicio 1

Dibujar el circuito resultante de la síntesis del siguiente código en SystemVerilog:

Module ejercicio1
(input logic clk, rst,
input logic [7:0] a, b,
output logic [7:0] y,
output logic [3:0] z);

         logic [7:0] x;

         assign x = ~(a&b);

         always_ff @(posedge clk, negedge rst)
         begin
                if (~rst) begin
                          y <= ‘0;
                          z <= ‘0;

                  end else begin
                          y <= x ^ y;
                          z <= x[7:4];
                  end

      end
endmodule
Señal/Tiempo   3ps   8ps   13ps   18ps   23ps   28ps   33ps
      a
      b
 ALUControl
   result
    zero


---

> Si una parte del texto resulta ambigua, conservar la marca `[ilegible/incierto: ...]` y consultar el PDF original antes de usarla como fuente.
