# Parcial 2 2023-11-08 (Tema A)

> **Fuente:** `Parcial 2 2023-11-08 (Tema A).pdf`
> **Método:** OCR sobre páginas renderizadas

## Nota de legibilidad

La fuente no contiene texto extraíble; el contenido fue obtenido por OCR. Los caracteres poco legibles, fórmulas, subíndices, superíndices y símbolos pueden requerir verificación contra el PDF. Si una lectura concreta no pudo confirmarse, se marca como [ilegible/incierto: ...].

## Contenido



<!-- Página 1 -->

14)
iguiente
fpal para la CACHE dada y completar. le siguien
9 iteraciones del loop:
—— - Index Word
“Ciclos, calcular el ol lel Yoxt | KT
aS Condiciones de! punto eee aero Al
| > [hs |
ie fe fp me? | ova | lve
4% ©) Ahora considere que puede : aay |
; Cambiar el tamafio del bloque y la Sita ane (XY ? »
ore eas toon > Th Pad ovat oleae
conjunto de N-vias. Determine el ene oe :
4 mt _§ bs ! =) 3
Vias OPTIMOS para minimizar la :
Coreen (> |. altel
no se generan beneficios C4 a Sas
adicionales). A
Tamano de bloque: { L bytes.
Numero de vias: yi vias. Ve
a7 d) Calcular el AMAT de 2 iteraciones del lazo para las condiciones del punto c).
aay see ae
Ejercicio 2
Dado un procesador de arquitectura LEGv8 2-issue, que predice los saltos perfectamente
(de modo que los hazard de. control on manejados por hardware), con una modificacién
que permite ejecutar dos instrucciones aritméticas/légicas juntas (es decir, una instruccién
i Smee
a |
“~
i
i]


<!-- Página 2 -->

Pe Fcial 2 - Arquitectura de computadoras 2023
in Paquete puede ser de cualquier tipo -/ssueA-, pero la otra debe ser una instruccig, _
limetica o ldgica -/ssueB-). Para el siguiente fragmento de oédigo LEGv8, donde Xo=,
ireccion base del arreglo A, de elementos de 1 Byte), X1=N (cantidad de elementos de}
aireglo), X2=1 y los demas registros se encuentran inicializados con “O": '
Oi ST PS Pee
2>  loop:LDURB X9, (x0, #0] fare DNS eS jostes
3> SUB X12, X9, X2 [yo (loos)
4> LDURB X10, [X3, #0] a plc :
t 5> STURB X12), [(X3, #0) Pe Sl ee
; 6> SUBI X3, X3;~#1 es ole aa
. 1> ADDI XO, X0, #1 [ons a ee
r B> ADD X11, X10, X2 tie | KD |
, 10> SUBS X11, X0, X3 Sees |
; = pane Lecce Daal a ca
rf fea raid
i 4/ _ a) Analizar en el codigo las dependencias de datos que NO sean condicionales y luego
te completar la siguiente tabla:
|
| ee ee ee
me ee)
ea ere
eee
| to =n aj) Sa ia
=) | a a
a
BSS ES ead
| [hw eee ee. | ee
Wn (ieee, a ee
+4} -— b) Sin alterar el orden de las instrucciones, mostrar en la tabla junto al cédigo como
organizaria los issue packets para ejecutar el programa en la menor cantidad posible de
ciclos de clock (cada instruccién sdlo puede agruparse con la inmediata anterior. la
inmediata posterior 0 una nop). El compilador asume toda la responsabilidad de insertar
instrucciones nop para que el cédigo se ejecute sin necesidad de generacidn de stalls. Usar
los numeros correspondientes para referirse a las instrucciones del cédigo.


<!-- Página 3 -->

A eur de computadoras 2023
Rc issue con ie ee Yen aon del ebdgo dado en ee
tae sube alle er B60 pro ig y en el procesador LEGva 2-issue
hazard de (a ranciad Cesadores los saltos son Perfectamente predichos y los
ENGR orar'- ‘Oia a por hardware (no hay flush de instrucciones). Suponer
P: ee ac @ las iteraciones reali adas. Luego completar:
~ — Hempo de €JEcucion en 1-issue= 5 Claas Az
HM. Tiempo de ejecucién eh 2-issue= 33, CHAS CH
) ii. Ganancia en velocidad = [. 3#5
peices ando un microprocesador out-of-order execution implementado mediante el
eo a [s) de Tomasulo, el cédigo en assembler en el ejercicio 2, muestre el contenido de las
hie de estado de las Reservation stations y registros para el 5to clock de ejecucion
inclusive). El procesador cuenta con el siguiente hardware: .
|
|
:
ALU punto flotante = 4 RS / 2 clk
Multiplicacién punto flotante = 2 RS/3 clk
Ejercicio 4
Se cuenta con un predictor global con un GR de 8 bits, considerando el siguiente segmento ’
de codigo en LEGv8:
.org @x@a PHT predictor global
@x2> udiv x2, x@, x1 //Se verifica
@x4> sub x3, x3, x2 //mUltiplo de 3
@x5>  cbnz x3, s1 ae ae)
@x6>s1: add x1, xzr, #5 ae a Vena
@x8> mul x3, x1, x@ //si x@ es ae /,
@x9> sub x3, x3, x2 //mdltiplo de 5
@xD> b.ne L


<!-- Página 4 -->

> a> 8! /
er ie® ”
at "Arquitectura de computadoras 2023
ef ictor global que
iciones de la PHT del predic :
8 en hexadecimal en las posiciones siderando que esta
Eoistscione to de la posicién OxD, con
Brimer instruccin del cédigo. i i da dos
siderando que inicialmente X0=0 y que existe un patron Laan multiplo de 4).
ferasiones del cédigo aparece un ntimero par, y cada 4 aparece un nar el patron del salto
lus ca ntidad de bits deberfa tener como minimo el GR para almace
Bela posicion 0x5? 2 para el salto de la posicién OxA?
> IS
Ox5> | ~ — OxA> ak Se
x Ejercicio 5
as aot or una
Completar el siguiente kernel de openCL que multiplique un vector de N elementos p
constante alpha.
j
— kernel void parallelVMult(
const int N, const float alpha,
— global float *a_g)
{ E
int i= 0
float tmp = 0.@f;
}
El kernel debe corresponderse con el siguiente cédigo de host:
plataform list = cl.get platforms ()
devices = Plataform list[0]. get_devices (device type =
[afl See device type.GPU)
context = cl.Context (devices=devicés)
| queue = cl,CommandQueue (context)
a np = np.arange(N) .astype (np. float32)
@_g = cl.Buffer(context, cl -mem_ flags. READ WRITE |
cl.mem_flags.COPY HOST PTR, hostbuf = a np)
program = cl.Program(context, KernelSource) - build ()
kernel = program.parallelVMult
kernel -Set_scalar arg dtypes([np. int32, np. float32, None])
kernel.set_args(N, alpha, ag)
globalRange = a_np.shape
localRange = a_np.shape
ev = cl.engueue nd range kernel (queue, kernel, globalRange, localRange)
cl.enqueue copy (queue, a_np, ag)


---

> Si una parte del texto resulta ambigua, conservar la marca `[ilegible/incierto: ...]` y consultar el PDF original antes de usarla como fuente.
