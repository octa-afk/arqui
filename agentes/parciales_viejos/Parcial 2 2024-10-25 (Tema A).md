# Parcial 2 2024-10-25 (Tema A)

> **Fuente:** `Parcial 2 2024-10-25 (Tema A).pdf`
> **Método:** OCR sobre páginas renderizadas

## Nota de legibilidad

La fuente no contiene texto extraíble; el contenido fue obtenido por OCR. Los caracteres poco legibles, fórmulas, subíndices, superíndices y símbolos pueden requerir verificación contra el PDF. Si una lectura concreta no pudo confirmarse, se marca como [ilegible/incierto: ...].

## Contenido



<!-- Página 1 -->

Parcial 2 - Arquitectura de computadoras 2024
25/10/24
Apellido, Nombre:
Ejercicio 1
Considere la ejecucién del siguiente segmento de cddigo LSL X9, X3. #2
LEGv8 para i > 0, donde i — X3, y X6 contiene la direccién A
base del arreglo A[ } del tipo uint32_t. ADD X9, X6, X9
loop: SUB X11, X6, x9
El procesador tiene una CACHE exclusiva para DATOS de CBZ X11, end
correspondencia DIRECTA de 64Kbyte y 4 palabras (w,) LDUR X10, [X9, #0]
por linea, sobre un procesador de 32bits, CP] = 1, que ADD X@, x10, X@
resuelve todos los data y control hazard sin necesidad de SUBI x9, x9, #8
Stalls, tiene una memoria principal de 4G palabras (w,,) de 1 B loo
byte cada una. Considerar que el resto de los registros d STUR a x9
estan inicializados en 0 y la CACHE vacia al inicio de la |_“"** > ee
ejecucion del segmento.
vais a) Completar cada casillero con el numero de bits de cada campo del formato de direccién de
memoria principal: .
* Llenar con 0 en el caso que no corresponda
i’ b) Cuantos MISS de CACHE se produjeron en la ejecucion del fragmento de codigo si i=6 y la
direccién base del arreglo A es 0x00F 192B8?. Suponga que los accesos a memoria de escritura y
lectura tienen IDENTICO comportamiento para la CACHE.
Respuesta: ____ Miss
of c) Completar como queda la memoria CACHE al finalizar la ejecucién del segmento para las
condiciones del punto b). Llenar una fila por cada MISS.producido. Se complets la primer linea solo
con fines ilustrativos.
_Andex (hex) tx Tag ihen tN Dat
ag este oe ee eee UNG
wcnca [Oca fs [amn [aro [aor [ae
1


<!-- Página 2 -->

f iderando la
Ejercicio 2 : sador LEGv8 2-issue. Const
En ta figura se muestra un diagrama at ler a (con multiplexores, HDU, unidad de
forma de funcionamiento de la implemeniaciin Scere a ID para la resolucion de saltos, etc.) y
forwarding, los ceminos de forwarding incluso . eT el ciclo de clock posterior al fetch de un
asumiendo que los saltos son perfectamente predichos Os t sequin corresponda, no hay penalidad),
salto se hace fetch del paquete correcto: PC+8 0 PC+toffset, seg
ponder: mas abajo), analizar las
a) Dado el siguiente fragmento de cédigo en assembler vig Bie de cada una de las
dependencias de datos y completar con el primer caso que
siguientes dependencias: Numeros de instrucciones | Operando en conflicto
RAW condicional
b) Mostrar en la tabla cémo organizaria los Issue packels para ejecutar el programa en la menor
cantidad posible de ciclos de clock sin alterar el orden de las instrucciones (cada instruccion
s6lo puede agruparse con la inmediata anterior, la inmediata posterior o una nop). Et compilador
asume toda la responsabilidad de insertar instrucciones nop para que el cédigo se ejecute sin
necesidad de generacién de stalls. Usar los nimeros correspondientes para _referirse a las
instrucciones del cédigo y “nop” para las instrucciones agregadas. Issue gris
1> ORRI X4, XZR, #0x8
2> loop: CBZ X@,end il
3> LDUR X2, [X1, #0] ’ sf
4> SUBI X@, X®, #1
5> LDUR X3, [X1, #8] <
6> ADD X1, X1, X4
7> STUR X2, [X1, #0]
&> ADD X3, X3, X1
9> CBZ XZR, loop | ae
10> end: es eee
Completar en los recuadros vacios del diagrama del procesador qué instruccién se esta
ejecutando en cada etapa del pipeline, tanto en el issue negro como en el gris, en el ciclo de
clock numero 6, considerando que antes de comenzar la ejecucién del programa X0=2.
women pet Lo :
oe Dee Tt
H ; : Ss i g
. Eanes t


<!-- Página 3 -->



<!-- Página 4 -->



---

> Si una parte del texto resulta ambigua, conservar la marca `[ilegible/incierto: ...]` y consultar el PDF original antes de usarla como fuente.
