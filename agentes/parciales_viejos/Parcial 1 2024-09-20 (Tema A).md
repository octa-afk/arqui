# Parcial 1 2024-09-20 (Tema A)

> **Fuente:** `Parcial 1 2024-09-20 (Tema A).pdf`
> **Método:** OCR sobre páginas renderizadas

## Nota de legibilidad

La fuente no contiene texto extraíble; el contenido fue obtenido por OCR. Los caracteres poco legibles, fórmulas, subíndices, superíndices y símbolos pueden requerir verificación contra el PDF. Si una lectura concreta no pudo confirmarse, se marca como [ilegible/incierto: ...].

## Contenido



<!-- Página 1 -->

. Parcial 1- Arquitectura de computadoras 2024 a
Nombre: Ye Mas Ketaune, Meer P if Grae
, (i
ff Ejercicio 1 é y
We, ; : , nNwety
4 7 a) Dibujar en el recuadro el circuito resultante de la sintesis del siguiente cédigo en
SystemVerilog:
: : module parcial
(input logic clk, reset, load,
3 input logic [3:0] init,
z Output logic [3:0] q,
; output logic pout);
3 always_ff @(posedge clk) | -
3 if (reset) q <= 4'b0;
sf else if (load) q <= init; ee
else q <= q + 4'b0001; =
- assign pout = q[0]; j
= endmodule
ra i es
2 /?) é Qué nombre le pondria a este médulo en lugar de “parcial”, que sea mas representativo 5
; del circuito descripto? _ r
ee ie Acontinuacion se describe en SystemVerilog el test bench del médulo parcial. Completar So
<= ? las lineas con los elementos faltantes para obtener las formas de onda de respuesta que se ines
5 i muestran en la figura.
Sica SE ee es Seen OS ee Oe
£ iperceB_thkeset a i if i i
DO fewsie wid 8 ee | ee pep a pe |
29 acu jen 0000 EE a a SS a eT
ae oer ee) ——— re
H — ed | oa Be co tt a oes eae oes
g module parcialB_tb;
legic clk, reset,load, _ ,
logic __ We init, a;
; i dut (.clk(clk),.reset(reset),.load( load),
i -pout(pout), ss, (9) );
; always LK = ~clk; |
4 initial
: clk = 0; reset = 1; load = 0; ——
; #9; _ __; #1; init = 4'b0010;
aj load = 47 #10; load = 0; #20; S|; |
: i #10; load = 1; ; /
4 $display("Valor final de q: eee)
ea $stop; ,
qj end bist
|
3
:


<!-- Página 2 -->



<!-- Página 3 -->

o8st4C
Parcial 4s 2)
Nombre: Tomy peg’ 1- Arquitec ,
oe ROWNIN Berzerg tura de computadoras 2024 |
ulere analizar las 5
A odificaci
: manejo de Exc re neaciones necesarias
sistema (0 EPCIONES (Prctico 3) afin de al procesador LEGv8 de un ciclo con
(EXtiRQ) ty code invatido para nuestro caso), di vee l0s vectores de excepciones de
i OS NUEVOS vectores son: » del vector de interrupeiones por periféricos
PCode Invalido
i -  Interrupcién de E/ = One
’ | S externa (ExtIRQ) = Ox00F8
NOTA: La sefial de r
espuesta
ISR de una ieneeronsien de een Solo debe ponetse en "1" en caso de ejecutarse la
J erna. Caso contrario debe permanecer en “O".
5 Propon F
B ‘Oponga una modificacidn al procesador y fesponda: ia
rf ~
. 7a gare agregar sefiales de control extras?
: beans Sit... Nombre #Origen #Destino F
. eases gl dha es Oe Se. in ta a }
b) Enumere qué médulés existentes deben ser modificados (si los hubiera)
Aas ESRI siemens
i 3 —— SS _—_—
-§ en e) Se requiere agregar alguno de estos médulos? De ser afirmativo, especificar et
F : - nombre de las sefiales involucradas. Caso contrario, tachar el/los modules.
= | SS : Aflopre)
Taga a lla 2 sel & = a
Bs —_ — a) es >
see — 2 ; #. LL fable J| ;
ee — > eau x |
3 5a a ; = so . |
oe 7 as jue el contenido de la direcci6n de memoria OxO0FC no conyene una
; i y ‘valida. Que ocurre en nuestro nuevo procesador si ocurre una }
: e de E/S externa? (marcar la correcta)
: ISR de interrupcion de E/S externa se ejecuta normaimente
ocesador se queda en un bucle infinito sobre el vector OxOOF8
j dor se queda en un bucle infinito sobre el vector 0x00D8
s anteriores |


<!-- Página 4 -->

Ejercicio 3 ; sador tienen las siguientes _
Asumiendo que las etapas individuales del pipeline de un proce
Ja) Completar:
Tipo de Maxima frecuencia de reloj Latencia de una instruccion
procesador {Hz] [ns]
Asuma que quiero ejecutar un fragmento de cddigo que tiene 2E6 instrucciones, las cuales
ee presentan hazards: \v.2900000 es
b) gCuanto tiempo llevaria ejecutar dicho fragmento de cédigo? _ .
/e) ECuanto tiempo llevaria ejecutar el mismo fragmento si el procesador no tuviese
pipeline? ae ~
Tipo de dependencia
| ONE ee SS es an Eee
- . ee Pe - ee 2 2
FIG epee Consider ando ente el segmento de codigo encertado en el rectangulo:
sical 4c) Comp pletar la tabla. con las dependencias.
a2) Mostrar el orden © e ejecucion considerando que inicialmente el registro XO es igual a
- cero y para un | proce: ado rLEGv8 con stall.
3) Mostrar el orden de eject cién considerando que el inicialmente el registro XO es distinto
ae de cero y para un pre cesador LEGv8 con forwarding stall.
i xb) Considerando el codig 6 completo, que inicialmente el registro x9 esta inicializado en
= 1000, x0 es distinto de cero y para un procesador LEGv8 con forwarding stall: j
bel) eCuan os cick os di > clock tomaria ejecutar este cddigo? .
ind Ree) £Cuétos cil de clock tomaria ejecutar este codigo en e| microprocesador
ieee oBrs) CReU Ane ie velocidad entre los puntos b-1 y b-2: — ,
cai Meee ROS DMeS Ae Re i -3 en la siguiente hoja aS
; are aa :
in 1


<!-- Página 5 -->



---

> Si una parte del texto resulta ambigua, conservar la marca `[ilegible/incierto: ...]` y consultar el PDF original antes de usarla como fuente.
