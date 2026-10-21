# Parcial 1 2022-09-23 (Tema A)

> **Fuente:** `Parcial 1 2022-09-23 (Tema A).pdf`
> **Método:** OCR sobre páginas renderizadas

## Nota de legibilidad

La fuente no contiene texto extraíble; el contenido fue obtenido por OCR. Los caracteres poco legibles, fórmulas, subíndices, superíndices y símbolos pueden requerir verificación contra el PDF. Si una lectura concreta no pudo confirmarse, se marca como [ilegible/incierto: ...].

## Contenido



<!-- Página 1 -->

OTSTSSS SSS
es \
_  Arquitectura de computadoras 2022 - Parcial 1A Y (nueve)
Nombre: Tyah Ke hisan
 Ejercicio 1
~ 2) Dibujar el circuito resultante de la sintesis del siguiente codigo en SystemVerilog:
"module circuito
(input logic clk, r, enable, sel,
input logic [7:0] A, B, Resuelto al finyl Ar | fodo
output logic [7:8] Q,
output logic [3:0] L);
logic [7:0] Q temp;
always_ff @ (posedge clk, negedge r)
begin
if (+r)
Q temp <= 8'bo; |
else if (enable) ‘
if (sel)
Q temp <= Q temp * A;
else
Q temp <= Q temp & B;
end
assign L = A[7:4];
assign Q = Q temp;
endmodule
/ 6) Acontinuacién se describe en SystemVerilog el test bench del médulo "circuito".
Completar las lineas con los elementos faltantes para obtener las formas de onda de
respuesta que se muestran en la figura.
module circuito_tb();
logic clk, reset, enable, s; /
Log: ( ce) L; vs
logic: [7:0], sale b>. gs =
Grtod o dut (clk, re5es, pha pley 5, 9.4 q) 0 5
always
begin
clk = ) LOO Cli=) eK 5 #100;
end
initial
begin
reset = 8; enable=0;s=1F0.25n5_ ;
reset ala
a =,8'be1010101;
b #b11411174 ; FOG ;
enrble = 1; #0,05n5 ;
s = 0; FFD) bS 5)
$stop;
endmodule eee eis Roapaes
pues p—] fe ee
5 an a es Os aN SE
> lacs thence 9 PRR, ARG ES RNAS eR SN Se Pe ee ee eee SS TS
Year 1 ee Maras Mania seme Soa fT SS | a pea ee |
£9 eu _b cues Rn Ee ese cg) a Le ee
2d pute ob coonoea | ; 7 *
sv uth om : ; co . u : -
apo Ww, O56 iy Bi oe 03 fire _. She OG ns Rone ee
se Cars 0.15108
4 : St es


<!-- Página 2 -->



<!-- Página 3 -->

Pac aHtS enya aa
{EGG iW SA), sees a1 erphamertiade on ot Précico 3 Esta nana debe ey
W Sirecotn WnA4FPN000 usando X0 como argument que contenga la direccién de retono a.
SH 6 cane de une sucepcion por OpCode invalide, se deber4 reemplazar dicha instruccién =
VANES 90H le ieithuccisn ‘AOD Kar, XO, XO" y retornar de la excepcién normaimente. |
if 4) Comopetian a cédigo cor 'as \ineas 0 argumentos faltantes.
S39 victow: WS *%, 54.6. OF. €6_§ L 4
SUBIS K7#, x}, #1
M2 tise
MES » 4.51. ¢9-¢o_0 i
howe x0 AMFF SL SL #4
BR x10
tise. DORIS “2H, £5, HEP
BNE BSR _gwo
wes ¥0, $2.01 co 6 1 ;
| sesees. Nie <16, wesags sto 00090, 15k #16 /
WONK KAO, HOXOCLF, Let #6
STORW 4m, {x0, #0}
St p02 zee?
/ 9) Seleccionar ia respuesta correcta de las siguientes afirmaciones:
s “S suporemcs que la posicién de memoria con la instruccién de label “tricky” esta
comorpida en memoria en forma permanente (generando un OpCode invalido),
Corsidstar do \a inplermentacién particular de nuestro procesador, el mismo.”
0. genera un comporiamiento impredecible, porque este caso no esta contemplado ;
2” ia \6gica de excapciones, =
ie] _ to realiza ninguna accién porque ya esta en el vector de excepciones y retorna Rae
“@ _ ante una s1cepcitn por OpCode mvalide queda atrapado en el bucte infin me
bt QD wnercmmmunmcsneitm
Eo eee eee + de ee eee
Ce eae: eee eRe ore ee ee ee a
ee eee Ne og ee ba ts ae
fot a eee ae Seat ord is Oe gare hailey 2 Ropes 7 pee aoe as . er erage ees Spd
IG eae, ais ee PRC tr eee ee
eee 8 ee a ae ee aa eee


<!-- Página 4 -->

» Arquitectura de computmdores 202° Pereia! VA .
| a Avian Re, 59, q
+ iran li tain eesnntnnsian ens paora rates .
/ b) Mostrar ef orden de ejecucidn coneiderande un procesader que evenia Uneaniente enn
Stall (sin forwarding).
/ ©) {Cudntos ciclos de rela) tarda ei procemador en efecutar ei codige del punto nL)
Ejercicio 4
demas artes oe ania 2° coz regio XB He eneventra weakens 6 el alo 0,
Seernas erten we Me gjomuotin CddIgO Is PORIOINN Ge HeNora apuntade por xf HERE e!
To de depeneieneia (reguatra). WRTUCEIONGS vel
i> E3: ADOT Xa, XZR, #2 Dea x4
2» LDUR X2, [XS, #0) Dates ‘ 6
a» AND X@, Xi, x2 Ae ca a meee
a> cer Xe, €1 d hog ses all :
5> SUBI X2, X2, #1 Condyg| ees ae ee
7> El: SUBI x3, XB, #2 imap. fe pt inte eo
Dring cond XS :
| 8> E2: CBNZ X3, E83 tne omen , : i
> STUR X3, [X5, #0] Datos Condi .gaal) x3 Et
F Datos (eonditgnall x4 +-4 e.
Vv a) Completar la tabla con las dependencias :
vb) Mostrar el orden de ejecucidn de una iteracion del laze (hasta que ee termine de ejeoutar Be
la instruccién de salto), considerando un procesador LEGVS (similar al nontrade en el .
diagrama del ejerciclo 2) pero con forwarding-stall, Dejar correctamente indioados los ecue
caminos de forwarding, a.
v ©) ¢Cuantos ciclos de reloj tarda el procesador en ejecutar el eddige del punto ois ae
a*/—9) Considerando que las etapas del procesadar tiene laa siguientes latencias Rene y ae
Compietar la siguiente tabla, : aes i oe
| Brgcuencia dei reloj minima | ee ae
. racodgo elpuod —[eOV0n; | iden |o


---

> Si una parte del texto resulta ambigua, conservar la marca `[ilegible/incierto: ...]` y consultar el PDF original antes de usarla como fuente.
