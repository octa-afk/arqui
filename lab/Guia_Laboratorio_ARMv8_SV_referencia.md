# Arquitectura de Computadoras 2026

# Laboratorio ARMv8 en SystemVerilog

> **Versión de referencia técnica editada a partir de la guía PDF original.** Este Markdown no es una transcripción íntegra del documento oficial. Se omitieron algunas condiciones administrativas; consultá el PDF original para conocer todas las condiciones de cursado y entrega. Las figuras gráficas del PDF no se reproducen aquí, por lo que se indican sus referencias cuando corresponde.

## Objetivos

- Desarrollar códigos en lenguaje SystemVerilog para describir circuitos secuenciales y combinacionales vistos en el teórico y el práctico.
- Utilizar la herramienta Vivado para analizar y sintetizar el código SystemVerilog.
- Aprender a reutilizar código SystemVerilog mediante módulos estructurales.
- Mediante el uso de test bench, analizar las formas de onda y testear los resultados.
- Aplicar los conceptos aprendidos sobre microprocesadores y la técnica de mejora de rendimiento: segmentación de cauce (*pipeline*).

## Formato de entrega

- Utilizar los nombres de los módulos y señales indicados en las guías del práctico.
- Al repositorio se debe subir el proyecto de Vivado completo y el README que funcionará de informe (en formato Markdown). Este último debe incluir el nombre de los integrantes del laboratorio, una aclaración de qué ejercicios resolvieron y los requerimientos descriptos al final de cada ejercicio.
- El trabajo es incremental: se pide entregar un único procesador con todas las modificaciones correspondientes a los ejercicios que se decidieron resolver.
- El código se entrega mediante el repositorio creado por la cátedra mediante tags: para el ejercicio 1, `LAB_ej1`; para el ejercicio 2, `LAB_ej2`.
- Se pueden usar distintas ramas (*branches*) si se desea, pero todo código entregable debe estar en la rama principal.

## Calificación

El ejercicio 1 es obligatorio. Su resolución debe estar aprobada para obtener la regularidad de la materia. Quienes resuelvan el ejercicio 2, partiendo del procesador modificado en el ejercicio 1, estarán habilitados para promocionar si cumplen con los demás requisitos.

## Desarrollo

> **Importante:** verificar que no se produzcan advertencias de la herramienta durante el proceso de síntesis relacionadas con una mala interpretación del circuito a implementar.

El laboratorio está basado en la implementación del microprocesador ARMv8 en versión reducida obtenida en el trabajo práctico 2. El repositorio ya incluye, en los mismos archivos, la descripción de ambas versiones del procesador (con y sin *pipeline*), seleccionable mediante el parámetro `PIPELINE` (`0 = single-cycle`, `1 = pipeline`) presente en los módulos `processor_core`, `processor_arm` y `datapath`.

Para simular, alcanza con cambiar ese parámetro a `1` en el testbench (`processor_core_tb.sv` o `processor_arm_tb.sv`, que ya lo exponen como `#(parameter bit PIPELINE = 1)`).

Para sintetizar e implementar en la placa, el top de síntesis es directamente `processor_arm` (sin testbench de por medio). Hay que cambiar ahí el valor por defecto del parámetro (`parameter bit PIPELINE = 1` en la declaración del módulo, en `processor_arm.sv`) antes de correr síntesis/implementación. Finalmente, verificar las conexiones resultantes según los diagramas de las figuras 1 y 2 del PDF original.

### Recomendaciones importantes

- Recordar inicializar los registros `X0` a `X30` con los valores `0` a `30` respectivamente en la implementación del bloque `regfile`, o con los valores que consideren necesarios para la resolución de los problemas.
- El bloque `decode` ya incluye el puerto de entrada resaltado con un círculo rojo en la figura 2 (`wa3_D`); usarlo para conectar la escritura de `regfile` con la lectura, según se explica en el punto siguiente.
- Se debe modificar el bloque `regfile` a fin de que, si alguno o ambos registros leídos por una instrucción en la etapa `decode` están siendo escritos como resultado de una instrucción anterior en la etapa `writeback`, se obtenga a la salida de `regfile` el valor actualizado del registro.

**Figuras del PDF original:** figura 1, esquema del `top_level_entity`; figura 2, diagrama de conexiones mencionado en la guía. Las imágenes no están incluidas en este archivo Markdown.

## Programa de verificación del procesador con pipeline

Una vez concluida la implementación del procesador completo con *pipeline*, se debe verificar su correcto funcionamiento utilizando el siguiente código. Los comentarios indican la dirección/valor esperado en memoria.

```asm
// Dirección:valor
STUR X1, [X0, #0]       // MEM 0:0x1
STUR X2, [X0, #8]       // MEM 1:0x2
STUR X3, [X16, #0]      // MEM 2:0x3
ADD  X3, X4, X5
STUR X3, [X0, #24]      // MEM 3:0x9
SUB  X3, X4, X5
STUR X3, [X0, #32]      // MEM 4:0xFFFFFFFFFFFFFFFF
SUB  X4, XZR, X10
STUR X4, [X0, #40]      // MEM 5:0xFFFFFFFFFFFFFFF6
ADD  X4, X3, X4
STUR X4, [X0, #48]      // MEM 6:0xFFFFFFFFFFFFFFF5
SUB  X5, X1, X3
STUR X5, [X0, #56]      // MEM 7:0x2
AND  X5, X10, XZR
STUR X5, [X0, #64]      // MEM 8:0x0
AND  X5, X10, X3
STUR X5, [X0, #72]      // MEM 9:0xA
AND  X20, X20, X20
STUR X20, [X0, #80]      // MEM 10:0x14
ORR  X6, X11, XZR
STUR X6, [X0, #88]      // MEM 11:0xB
ORR  X6, X11, X3
STUR X6, [X0, #96]      // MEM 12:0xFFFFFFFFFFFFFFFF
LDUR X12, [X0, #0]
ADD  X7, X12, XZR
STUR X7, [X0, #104]     // MEM 13:0x1
STUR X12, [X0, #112]    // MEM 14:0x1
ADD  XZR, X13, X14
STUR XZR, [X0, #120]    // MEM 15:0x0
CBZ  X0, L1
STUR X21, [X0, #128]    // MEM 16: xxxx...xx (si falla CBZ = 21)
L1:
STUR X21, [X0, #136]    // MEM 17:0x15
ADD  X2, XZR, X1
L2:
SUB  X2, X2, X1
ADD  X24, XZR, X1
STUR X24, [X0, #144]    // MEM 18:0x1 y MEM 19=0x1
ADD  X0, X0, X8
CBZ  X2, L2
STUR X30, [X0, #144]    // MEM 20:0x1E
ADD  X30, X30, X30
SUB  X21, XZR, X21
ADD  X30, X30, X20
LDUR X25, [X30, #-8]
ADD  X30, X30, X30
ADD  X30, X30, X16
STUR X25, [X30, #-8]    // MEM 21:0xA (= MEM 9)

finloop:
CBZ XZR, finloop
```

Se deben tener en consideración los eventuales problemas de *hazard* (de datos y de control) que contiene el programa y plantear las modificaciones de código necesarias para evitar su ocurrencia. Para esto, agregar instrucciones tipo `nop`, que se pueden implementar como `ADD XZR, XZR, XZR`.

## Ejercicio 1 (regularidad)

Sin afectar el funcionamiento de las instrucciones ya implementadas en la versión reducida del microprocesador con *pipeline*, agregar la instrucción `MOVZ`. Introducir en el procesador todas las modificaciones necesarias, tanto en el *datapath* como en las señales de control.

Las especificaciones para esta instrucción pueden obtenerse de la *Reference Data LEGv8* (*GreenCard LEGv8*) del libro *Computer Organization and Design – ARM Edition*. Se resumen a continuación.

### Instrucción MOVZ

`MOVZ` (*Move wide with zero*) carga un valor inmediato en un registro. Los 16 bits del registro destino (`Rd`) toman el valor dado por `MOV_immediate` y el resto de los bits toma valor `0`. La posición del valor inmediato se determina con los 2 bits de `LSL`:

| LSL | Bits que toman el valor inmediato |
|---|---|
| `00` | 0 a 15 |
| `01` | 16 a 31 |
| `10` | 32 a 47 |
| `11` | 48 a 63 |

**Sintaxis:** `MOVZ <Rd>, <MOV_immediate>, <LSL>`  
**Tipo:** `IW`

Formato de instrucción indicado en la guía original:

```text
Bits:    31                 23 22 21 20                 5 4       0
Campos:  opcode                LSL   MOV_immediate        Rd
Opcode:  1 1 0 1 0 0 1 0 1     L L   X X X X X X X X X X X X X X X X R R R R R
```

Una vez finalizado, agregar al código de verificación anterior instrucciones `MOVZ` con distintos valores numéricos y de `LSL` y verificar su correcta implementación. Se debe analizar que todo el conjunto de instrucciones continúe funcionando correctamente y también `MOVZ`. Para esto, se pueden escribir los resultados en memoria y verificar si se obtienen los valores correctos en `mem.dump` al finalizar la ejecución del código. No olvidar resolver los eventuales problemas de *hazard* agregando instrucciones `nop`.

### Programa assembler para gestionar E/S mediante GPIO

Las instrucciones nuevas serán útiles para implementar la segunda parte del ejercicio. Se debe elaborar un nuevo programa en assembler para gestionar recursos de entrada/salida agregados al microprocesador. Se han mapeado en memoria, a partir de la dirección `0x8000`, los registros de control y estado de un bloque GPIO (*General Purpose I/O*) que tiene conectados 16 LEDs y 16 llaves.

#### Registro GPIO Input — dirección `0x008000`

| Bits | Descripción |
|---|---|
| 15 a 0 | `SW15` a `SW0` |
| 31 a 16 | No utilizados (`N/U`) |

Estado de las llaves: `0` = abierta; `1` = cerrada.

#### Registro GPIO Output — dirección `0x008008`

| Bits | Descripción |
|---|---|
| 15 a 0 | `LED15` a `LED0` |
| 31 a 16 | No utilizados (`N/U`) |

Estado de los LEDs: `1` = encendido; `0` = apagado.

El objetivo del nuevo código assembler es generar un juego simple o algún efecto llamativo utilizando la totalidad de los LEDs (distribuidos en línea) y las llaves que se consideren necesarias. Tener en cuenta los tiempos en que los LEDs permanecen encendidos y apagados al generar el efecto. Se recomienda implementar lazos de espera parametrizables para ajustar dichos tiempos al probarlos en la placa FPGA.

### Requisitos para el README del ejercicio 1

- Describir brevemente qué modificaciones se introdujeron, en qué entidades y con qué finalidad. Mostrar el diagrama del nuevo microprocesador, indicando las señales y entidades agregadas, si corresponde.
- Mostrar el programa en assembler LEGv8 modificado que se utilizó para verificar el comportamiento del procesador.
- Mostrar el nuevo programa en assembler LEGv8 que implementa el juego o efecto visual sobre los LEDs y una breve explicación de su funcionamiento.

## Ejercicio 2 (para promoción)

El procesador LEGv8 desarrollado no tiene la capacidad de detectar la ocurrencia de *hazards* de ningún tipo. En este ejercicio se propone implementar un bloque de detección de *hazards* (*Hazard Detection Unit*, HDU) y otro de *forwarding* (*Forwarding Unit*), para aplicar la técnica *forwarding-stall* cuando ocurre un *data hazard*, hasta que desaparezca.

### Aclaraciones para la implementación

- La HDU debe implementarse en la instancia de *Instruction Decode* (ID).
- Las condiciones para detectar un *data hazard* se analizan en el capítulo 4.7, “Data Hazards: Forwarding vs Stalling”, del libro *Computer Organization and Design – ARM Edition*, de D. Patterson y J. Hennessy. Se deben considerar todas las condiciones para todos los tipos de dependencias de datos.
- Para generar la condición de *stall* en el procesador es necesario:
  - Evitar que el PC avance a la siguiente instrucción en el siguiente ciclo de reloj y evitar que el registro de *pipeline* IF/ID cambie de valor en el siguiente ciclo (congelar su valor). Para esto, diseñar una nueva entidad `FLOPRE`, similar a `FLOPR`, pero agregando una señal de habilitación (`enable`). Funcionamiento: `enable = 1`, funcionamiento normal; `enable = 0`, la salida no cambia al detectar un flanco de reloj (síncrono).
  - Forzar que todas las señales de control a partir del ciclo EX en adelante tomen el valor `0` (ver la implementación de referencia en la figura 4.59 del libro).
- No olvidar que una parte del registro IF/ID está en la entidad `processor_arm`.

### Requisitos para el README del ejercicio 2

- Mostrar un diagrama de bloques general del nuevo procesador, indicando las señales y módulos agregados.
- Correr nuevamente el código desarrollado para el ejercicio 1, sin agregar instrucciones `nop`, y tomar una captura de la pantalla del simulador de Vivado donde se vea un caso de *stall* de instrucciones y otra donde se vea el *forwarding* de datos entre instrucciones. Explicar brevemente qué se observa en cada imagen.

---

**Nota sobre las figuras:** los diagramas, esquemas y dibujos incluidos en el PDF original deben consultarse allí; la extracción textual no permite reconstruirlos fielmente en Markdown.
