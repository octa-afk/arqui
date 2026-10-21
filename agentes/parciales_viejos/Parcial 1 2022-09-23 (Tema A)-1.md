# Parcial 1 2022-09-23 (Tema A)-1

> **Fuente:** `Parcial 1 2022-09-23 (Tema A)-1.pdf`
> **Método:** OCR sobre páginas renderizadas

## Nota de legibilidad

La fuente no contiene texto extraíble; el contenido fue obtenido por OCR. Los caracteres poco legibles, fórmulas, subíndices, superíndices y símbolos pueden requerir verificación contra el PDF. Si una lectura concreta no pudo confirmarse, se marca como [ilegible/incierto: ...].

## Contenido



<!-- Página 1 -->

Pes 7 eee a
,  Arquitectura de computadores 2022 - Parcial 1A (nu Oe
j Nombre: Tv Keniso : rs a
v Ejercicio 1 : rae |
V7 2) Dibujer el circuito resultante de la sintesis del siguiente cédigo en SystemVerilog: ee |
module circuito |
(input logic clk, r, enable, 1, i q
input logic [7:8] A, 8,” [Rsuelto al final 4e| todo se
output logic [7:6] Q, |
output logic [3:0] L); |
logic [7:0] Q temp;
always_ff @ (posedge clk, negedge r)
begin
if (-r) |
Qtenp <= 8'b9;
else if (enable) 7.
if (sel)
Qtenp <= Q temp * A;
else |
Qtemp <= Q temp & 8;
end
assign L = A[7:4]; |
assign Q = Q temp;
endmodule
v f 'b) Acontinuacién se describe en SystemVerilog el test bench del médulo "circuito".
Completar las lineas con los elementos faltantes para obtener las formas de onda de
respuesta que se muestran en la figura.
module circuito_tb();
logic. clk, reset, enable, s; |
tog:¢ C6) 1;
logic [7:8] a, b, 3
Grito dut (ck ress enaples 5 > 4 4 fi yi;
always
begin
clk = 5 #100; clk = _4 5 #100;
end |
initial
begin
reset = 0; enable=0;s = 10255  ;
reset #1;
a Re #005
b Ob 1411914 5 7 ty
s = 0; FDIS 5 i 4
$stop; ser ea
— eeteotle Eee — ak ee
Qewewe oe ee ee ee
(Piz stent 6 SE Em area Ge 2:
Sometimes | a ee ate
Fe By (ore a A SY at |
eT a
eee a ge 2! Dye Rae:


<!-- Página 2 -->



<!-- Página 3 -->

Meme 3055 hens 5m “a
see Seccin Oe cédigy Ory of vector de excepciones de un microprocessor Be
$2Gi6 (hw S45, srstar 1 plemented on ot Prictco 2 Feta rate dede |
£1 @ case de une excepcibn por interrupeiée externa ‘yecutar un procedimiento aloado en |
SS SNECCIEM GRAAPPUNDS, vnarids XO como srqumentc que contenga la dreccién de relomo |
See eecageitn :
+ «cans die ine excepcin por OpCode inwalido, Se debera reemplazar dicha instruccién ‘
A $e bw vsthucci6n ‘MOD Kar, XO, XO" y retornar de la excepcién normalmente.
F Ee sealable ot tee, retorar de ia excepcién rommalmente sin realizar accion alguna
oe) Complete @ cece cor las ineas 0 arqumentos faltantes
pen yeeren mss, DA O66 VY ‘
SOBIS 472, 4}, #1
S.N2 tise
fEs vo $46. 9.690 ef
Awe x0, DA Ls #16
B2 £10
cist. SORTS “ZR, 49, BY
Be BSe_ewo
WS X10, $2_0.¢1_co_o y,
eer. Ake 18, # oh s060 s0110ly 00000, 1s #16 //
MOVE 410, #OKOOIF, tet #0
STP Lh, (KO, HOt
184 300: aaet
+ GiAdliadbadr to setpviatacenecia ce tessguteese temnacone
4 “S) supemeros aus fa posicién de memoria con la instruccién de label ‘tricky’ esta
concragida en mersoria en forma permanente (generando un OpCode invalido),
réierar do 8 eplementacién particular de nuestro procesador, el mismo.”
Genera un comportamiento impredecible, porque este caso no esté contemplado
an a Wigjea 4 excapciones:
SD  soreatiza ninguna accion porque ya esta en el vector de excepciones y retorna
soreamente
Dante cuaiquier excepeitn queda atrapado en ef bucle infnito.
7 Bh. se 09 e120 960 yor OpCade waldo queda atrapedo en e! bucle nfinto.
2D Mnquna 2s corecta
Zz “inte 9 coriercla 38 ura excepeién no contemplada, este cédigo...” : P
6. (areca 9 Seeccite o mamaria d's nstrvccion que gener le excepcién. oe =
| o _ Mee 49 SeAC to aera Goa watvecien eu gener sath eg g
LL ipatenent  F saas «aa


<!-- Página 4 -->

: Arquitectura de computadores 2029 Pereiel 1A
Nombre: Twin Ken say
LOS LE
V 1b) Mostrar et orden de ejecucidn considierande un procenadter que cuenta Onmanente eo”
‘stall (Sin forwarding).
{Chm dene retro prntnnrn pie ot sigh tn piatn 99.24. =
Bjercicio 4
En la siguiente wecuencia de codigo el regina XS 4e enevenira hvelahiado 60” el valor 0,
ademas, antes de la ejecucion del eden la poniiin de memoria apuntade po NB Here
Too de deperdencia (eginia) | watiecionen
2> ES: ADOT XA, X2R, wa om % 4
» ADUR X2, (XS, #0) Daag pacer
» AND XO, X1, x2 nce
> ce xe, i .
> ‘SUBI X2, X2, #1 Lakai: | Mei aad Sek
7> EL: SUBI X3, XB, #1 wl i
8> E2; CBNZ X3, E8 Drins eene 9 i
| 9) STURXD, [x5 90) Dates CWonduccgnall x3 Soe
) dont) oD eee
| ; Dd Ceondiignall Xb et a
\V>_@) Completar ia tabla con las dependencias
J 5b) Mostrar el orden de ejecucidn de una iteracién del lazo (hasta que ¥e termine de ejecutar :
{a instrucci6n de salto), considerando un procesador LEGV8 (similar al moatrade en el aA
diagrama del ejercicio 2) pero con forwarding-stall, Dejar correctamente indioados los my
caminos de forwarding,
v/ ©) eCuantos cilos de rela) tarda el procesador en ejecutar el codigo del punto b? 1S a
af) Considerando que las etapas del procesador tiene lan siguientes latencias o
Completar la siguiente tabla ; ae
me if £5 ART epee 7 ae
| rmcuncn et rtoyminima a | ope pie 4
Perret —amnas Lien]
eo ee : hee


---

> Si una parte del texto resulta ambigua, conservar la marca `[ilegible/incierto: ...]` y consultar el PDF original antes de usarla como fuente.
