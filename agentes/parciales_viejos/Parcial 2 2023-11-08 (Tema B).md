# Parcial 2 2023-11-08 (Tema B)

> **Fuente:** `Parcial 2 2023-11-08 (Tema B).pdf`
> **Método:** OCR sobre páginas renderizadas

## Nota de legibilidad

La fuente no contiene texto extraíble; el contenido fue obtenido por OCR. Los caracteres poco legibles, fórmulas, subíndices, superíndices y símbolos pueden requerir verificación contra el PDF. Si una lectura concreta no pudo confirmarse, se marca como [ilegible/incierto: ...].

## Contenido



<!-- Página 1 -->

E ie, a ae Computadoras 2023
lercici =f 4 \
Con iat CL \ Ded
Sidere
L1 exclusive soo” Procesad
usiva pa or de arquitectura LE
de 2 palate ts INSTRUCCIONES de 2k BiG Ua Gace oe ee te ae
cor (Cada palabra e 1 st © datos, de correspondencia DIRECTA
~T€sponde a DIRECC S 1 instruccién de 32 bits) por bloque. La sigui ista
ejecucién a IONES de acce , iq . siguiente lista
i6n de un lazo cclaea ; od a la memoria de instrucciones (PC) para \a
uestran 32 bits de los 64 bits para abreviar):
1> 0x00...00 00 02 F
2> 0x00,..00 00 02 F8 oop: asm_instruction>
3> 0x00...00 00 02 Fc
4> 0x00...00 00 1A FC
5> 0x00...00 00 1B 00 <cbz loop>
Meee el formato de memoria principal para la CACHE dada y completar la siguiente
abla en formato HEXADECIMAL para 2 iteraciones del loop:
b) Suponiendo que el procesador | acc. | Hit / Index Word
opera con el pipeline en régimen a Miss | & G4 _)bits () bits
1GHz, el tiempo de acceso a CACHE =
es de 1 ciclo y el Miss penalty es de 50 Miss () 10) Tox ta oxo _|
ciclos, calcular el tiempo total de Miss | lox 430. loxo_|
ejecucién (en seg) para las condiciones cal Miss OxO fa Ox9
aang 0x0
Tiempo de Ox Ox is E oxo _| (b
c) Ahora considere que puede cambiar t + ota bo _|
el tamano del bloque y la CACHE pasa
3 p !
numero de vias OPTIMOS para Hit 1x6 Ox\¥ U
arriba del cual no se generan 7 Hit lox oxi ovo.
beneficios adicionales).
I Tamafio de bloque:_— _ bytes.
Numero de vias:_~__—S——_—sVias.
d) Calcular el tiempo de ejecucion de 2 iteraciones del lazo para las condiciones del punto c)
Tiempo total de ejecucion:_——__ Seg.
Ejercicio 2
Dado un procesador de arquitectura LEGv8 2-issue, que predice los saltos perfectamente
(de modo que los hazard de control son manejados por hardware), con una modificacion
que permite ejecutar dos instrucciones aritméticas/idgicas juntas (es decir, una instruccion


<!-- Página 2 -->

Oras #vr~~
F itectura de computad
| Parcial 2 - Arqui
debe ser una instrucci6,
: A-, pero la otra
i 9 -issuer Adi 8, donde X0=
en un paquete puede ser de cualquier IP” samento de cel eee elementos és
ty \ ,  aritmética o légica -Issue6-). Para el a 5 DoubleWord), X1=N (cantidad de .
(direccién base del arregio A, de aE ai inicializados con “O": aanciin
| arreglo) y los demas registros se encuen NW inavecon N rea z
—<— T )
\ 1> BSL X3, Xl, #3 NO
2> ADD x3, X0, X3 mage (37
&> loop: SUBS X12, X0, X3 ; pe NOP | } & pap
71> LDUR . x3, 70] ror | ay |
: 8> SUB X12, x, X2 \ Woe
; 10> STUR X12, [X3, #0]
: 11> STUR X11, (X0, #0] [437 | woe _|
mn end:
a) Analizar en el cddigo las dependencias de datos que NO sean condicionales y luego
~ completar la siguiente tabla:
CNCT Sein ale all em
Bee Xd. [6 ee) el ee ee
Se ee eee a eee
ae | ee eee
ene | ae ae
aa ——_}_|\\—
b) Sin ot el orden de Jas instrucciones, mostrar en la tabla junto al cédigo cémo
el Te bi Pata ejecutar el programa en la menor cantidad posible de
Gada instruccion sdlo puede agruparse : ;
; : con la inmediat i
inmediata posterior o una no : ata anterior, la
4 p). El compilador a BS :
instrucciones nop para que sl! cédigo se oN Sena a as ee RS
los nuimeros co ; S| Sicac Ce generacién de stalls. 1
fréspondiente: i ae; , on ce stalls, Usar
: 'S para referirse a las instrucciones del Codigo.
Tr
y


<!-- Página 3 -->

Parcial 2 - Arquitectura de computa doras 2023
y ¢) Calcular la cantidad de ciclos de reloj que toma ta ¢} ‘
procesador LEGv8 de 1-issue con forwarding-stall : ee del cédigo dado en We
4 descrito. Suponer que en ambos Procesadores los saltos son ee, LEGv8 2-issue
hazard de control son manejados por hardware (no hay f ee ectamente Predichos y los
que N=5 y considerar la totalidad de las iteraciones feclizedas. Li ib esdeeies SHpones
i. Tiempo de ejecucién en 1-issue=_ ———_ a dase
SS
ii. Tiempo de ejecucién en 2-issue= 13 ~
es /
iii. Ganancia en velocidad = ————
Ejercicio 3 Pr. i
Considerando un microprocesador out-of-order execution implementado mediante el
sc algoritmo de Tomasulo, el codigo en assembler en el ejercicio 2, muestre el contenido de las
tablas de estado de las Reservation stations y registros para el 5to clock de ejecucién
(inclusive). El procesador cuenta con el siguiente hardware:
1 El salto se predice correctamente
Load = 4 RS/ 1 clk
Store = 4 RS/1 clk ;
ALU entera = 4 RS/1 clk
ALU punto flotante = 4 RS / 2 clk
; Multiplicacién punto flotante = 2 RS /3 clk
" Ejercicio 4
Se cuenta con un predictor global con un GR de 8 bits, considerando el siguiente segmento
de codigo en LEGv8:
: -org 8x0e PHT predictor global
@x2> udiv x2, x@, x1 //Se verifica
@x4> Sub x3, x3, x2 //mUltiplo de 2 Soar Ga bean fon = 0 |
@x6>s1: add x1, xzr, #4 J
' 8x9> sub x3, x3, x2 //multiplo de 4
@xD> b.ne L


<!-- Página 4 -->

Parcial 2 - Arquitectura de computadoras 2023
; a) Completar la tabla en hexadecimal en las posiciones dela PHT del Eine ae aS
> se modifican en dos iteraciones del salto de la posicién OxD, considerando que So
4 completamente inicializada en cero y que X0=10 y el GR=0x34 antes de comen
ejecutarse primer instruccién del codigo. J: dados
b) Considerando que inicialmente X0=0 y que existe un patron repetitivo (ca aS lode 4)
iteraciones del cédigo aparece un ntimero par, y cada 4 aparece un numero mu p e :
{Qué cantidad de bits deberia tener como minimo el GR para almacenar el patron del salto
de la posicién 0x5? ZY para el salto de la posicion 0xA?
0x5> ———— NAS a
Ejercicio 5
Completar el siguiente kernel de openCL que multiplique una matriz cuadrada de NxN
elementos por una constante alpha.
__kernel void parallelMMult(
| const int N, const float alpha,
__ global float *a_g) {
ec inti=Ns x«
; antes NS) Se
: float tmp = 0.0f;
SS
= >>
}
‘El kernel debe corresponderse con el siguiente codigo de host:
Pletaform_list = cl.get_platforms()
Mevices = plataform_list[@].get_devices(device_type = cl.device type.GPU)
context = cl.Context(devices=devices)
@ueve = cl. CommandQueue(context)
‘a np = np.arange(N*N).astype(np.float32)
a_g = cl.Buffer(context, cl.mem_flags.READ_WRITE |
cl.mem_flags.COPY_HOST_PTR, hostbuf = a_np)
program = cl.Program(context, KernelSource) .build()
kernel = program.parallelmMMult
kernel.set_scalar_arg_dtypes([np.int32, np.float32, None])
\ kernel.set_args(N, alpha, a_g)
BlobalRange = (N,N)
localRange = (N,N)
ev = cl.enqueue_nd_range_kernel(queue, kernel
ee — globalRange
cl.enqueue_copy(queue, a_np, a_g) : oh aienee)


---

> Si una parte del texto resulta ambigua, conservar la marca `[ilegible/incierto: ...]` y consultar el PDF original antes de usarla como fuente.
