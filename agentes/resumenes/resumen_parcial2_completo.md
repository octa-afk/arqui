# Resumen – Parcial 2 de Arquitectura de Computadoras

> Basado en los teóricos de `agentes/teorico/` (Pipeline 2026, Organización de Memorias Caché, ADC Clase T 2026) y en los parciales 2023–2025.
> Lo marcado con **[ext]** no aparece en los apuntes de la carpeta y viene de conocimiento general de la materia (Patterson & Hennessy); verificalo con el libro o la clase.

---

## 1. Memoria caché

### 1.1 Conceptos base
- **Localidad**: temporal (un dato usado se vuelve a usar) y espacial (se usan datos cercanos).
- **Tag + valid bit**: el tag guarda los bits altos de la dirección; el valid bit indica si la línea tiene datos (inicia en 0).
- **Hit**: se sigue normal. **Miss**: se detiene el pipeline, se trae el bloque del siguiente nivel.

### 1.2 Organización
| Tipo | Dónde puede ir un bloque | Comparadores de tag |
|---|---|---|
| Directa | Una sola posición: `(nº de bloque) mod (nº de bloques)` | 1 |
| N-vías (set associative) | Cualquier vía de un conjunto: `(nº de bloque) mod (nº de conjuntos)` | N |
| Totalmente asociativa | Cualquier lugar | Todas las entradas |

### 1.3 Descomposición de la dirección (muy preguntado)
```
| tag | index (conjunto/línea) | offset de bloque (palabra/byte) |
```
- `offset bits = log2(tamaño de bloque en bytes)`
- `index bits = log2(nº de líneas)` (directa) o `log2(nº de conjuntos)` (N-vías)
- `tag bits = bits de dirección – index – offset`
- Totalmente asociativa: no hay index, todo lo demás es tag.
- Ojo con las unidades: en los parciales la dirección puede estar en palabras (w) o bytes; leé bien el enunciado.

### 1.4 Simulación de accesos
Para cada acceso: calculá índice → compará tags en el conjunto → hit/miss → si es miss, cargá el bloque y reemplazá.
- **Reemplazo**: en directa no hay opción. En N-vías: primero una vía inválida; si no, **LRU** (la que hace más tiempo no se usa). En 2 vías, LRU es fácil de simular.
- **Escritura** (**[ext]** parcialmente): write-through vs write-back; write-allocate vs write-around.

### 1.5 Tipos de miss
- **Compulsory** (primer acceso al bloque / cold start).
- **Capacity** (la caché es chica y se reemplazó un bloque que luego se pide).
- **Conflict** (dos bloques compiten por el mismo conjunto; no pasaría en totalmente asociativa del mismo tamaño).

### 1.6 Métricas
- **Miss rate** = misses / accesos. **Hit rate** = 1 – miss rate.
- **AMAT** = tiempo de hit + miss rate × miss penalty.
- **Tiempo total** de ejecución = ciclos × período de reloj (en 1 GHz, cada ciclo = 1 ns).
- Más asociatividad baja el miss rate pero con rendimientos decrecientes (en el teórico: 1-vía 10.3%, 2-vías 8.6%, 4-vías 8.3%, 8-vías 8.1%).
- **Tamaño de bloque**: bloques grandes aprovechan localidad espacial, pero en caché fija hay menos bloques (más competencia) y penalidad de miss mayor. Hay un punto óptimo.

### 1.7 Ejemplo de referencia (del teórico, secuencia de bloques 0, 8, 0, 6, 8)
- Directa (4 bloques): 5 misses.
- 2-vías (2 conjuntos): 4 misses (0 m, 8 m, 0 h, 6 m → reemplaza el 8 por LRU, 8 m).
- Totalmente asociativa: 3 misses (0, 8 y 6 son compulsory; los demás son hit).

---

## 2. Pipeline LEGv8 (5 etapas: IF, ID, EX, MEM, WB)

### 2.1 Idea
- Solapa instrucciones. Con N etapas y sin hazards: CPI ideal = 1. **Speedup ideal ≈ nº de etapas**, pero se reduce por desbalance de etapas y por hazards.

### 2.2 Hazards de datos
- **RAW** es el único que realmente aparece en LEGv8 con lectura después de escritura.
- **Forwarding (bypass)** resuelve la mayoría: EX/MEM → EX y MEM/WB → EX.
- **Load-use**: un `LDUR` seguido de una instrucción que usa el resultado **no** se puede resolver solo con forwarding → **1 stall**.
- **Reordenamiento de código** (scheduling) para evitar stalls: poner instrucciones independientes entre el load y su uso.

### 2.3 Hazards de control (saltos)
- Sin predicción, se para el pipeline (stall) hasta conocer la decisión.
- **Predicción**: estática (backward taken, forward not taken) o dinámica.
- Si la predicción falla → **flush** y corregir.
- **Predictor 1 bit**: falla dos veces en un lazo interno.
- **Predictor 2 bits**: cambia de predicción solo tras dos fallos seguidos (estados: 00, 01, 10, 11; 0x = not taken, 1x = taken).
- **BTB (Branch Target Buffer)**: caché de direcciones destino; evita el ciclo de penalidad al tomar un salto.

### 2.4 Predictor global (GR + PHT) — clave para el parcial
- **GR** (Global History Register) de N bits: guarda el historial de los últimos N saltos (1=taken, 0=not taken).
- **PHT** (Pattern History Table): tabla de contadores de 2 bits, indexada por la dirección del salto y/o por el GR (índice = GR XOR PC, por ejemplo **[ext]**, o concatenación según el enunciado).
- Procedimiento: 1) leer el contador en la PHT, 2) predecir según su bit alto, 3) actualizar el contador según el resultado real, 4) desplazar el resultado al GR.
- **Cuántos bits de GR** para capturar un patrón: un patrón de periodo P necesita al menos log2(P) bits de historial si se quiere distinguir cada posición del patrón **[ext]**.

### 2.5 Excepciones (del teórico)
- **Precisas**: se atiende la excepción de la instrucción más vieja; las posteriores se descartan.
- **Imprecisas**: el hardware solo para y guarda el estado; el handler decide. No son viables en pipelines complejos con out-of-order.

---

## 3. Multiple issue (2-issue estático, LEGv8)

### 3.1 Concepto
- **Issue packet**: grupo de instrucciones que se emiten en el mismo ciclo. El compilador los arma.
- **VLIW**: cada paquete es una "instrucción muy larga".
- **IPC** = instrucciones por ciclo (CPI < 1). Pico en 2-issue = 2.
- Esquema del teórico para LEGv8 dual issue:
  - **Slot 1**: ALU o salto.
  - **Slot 2**: load/store.
  - Paquetes alineados a 64 bits; si falta una instrucción se pone `nop`.

### 3.2 Reglas que hay que chequear
- Dentro de un mismo paquete **no puede haber dependencia**: ej. `ADD X0,...` seguido de `LDUR X2,[X0,...]` en el mismo paquete no sirve → hay que separarlos (efectivamente un stall).
- Entre paquetes sí puede haber dependencias, pero el forwarding tiene que estar disponible.
- El compilador debe conocer qué dependencias tolera el ISA.

### 3.3 Cómo calcular ciclos (ejemplo del teórico)
- Contá ciclos hasta que termina la última instrucción: `ciclos = paquetes + (latencia del pipeline – 1)` si el pipeline está lleno, o contá en la tabla de etapas.
- Ejemplo de la clase: lazo de 6 instrucciones reordenado en 6 ciclos → IPC = 7/6 ≈ 1.17 (pico 2).
- **Loop unrolling**: replicar el cuerpo del lazo para exponer más paralelismo, reduciendo el overhead del salto y los nops.

### 3.4 Speedup
- **Speedup = ciclos(1-issue) / ciclos(2-issue)**. Si el enunciado dice "ganancia en velocidad", es esto.
- Ojo con el forwarding-stall del 1-issue: contá los stalls que no existen en el 2-issue.

### 3.5 Procedimiento práctico para armar paquetes
1. Listá las dependencias RAW (y WAW/WAR si las hay).
2. Asigná cada instrucción a su slot (ALU/salto → slot 1; load/store → slot 2).
3. Si una instrucción depende de la anterior, ponela en el paquete siguiente.
4. Rellená con `nop` donde haga falta.
5. Contá paquetes = ciclos de emisión; sumá el fill del pipeline.

---

## 4. Out-of-order – Algoritmo de Tomasulo **[ext]**

(No hay material de Tomasulo en la carpeta; esto es de Patterson & Hennessy.)

- **Reservation Stations (RS)**: buffers por unidad funcional. Cada una tiene: `Op`, `Vj/Vk` (valores), `Qj/Qk` (productores pendientes), `Busy`.
- **Register status / registros**: para cada registro, qué RS lo va a escribir (`Qi`).
- **Tres fases**:
  1. **Issue**: toma una instrucción de la cola; si hay RS libre, la carga; si el operando está pendiente, guarda la RS que lo produce (Q).
  2. **Execute**: cuando los operandos están listos, ejecuta. Los loads calculan la dirección primero.
  3. **Write result**: broadcast del resultado en el CDB; las RS que esperaban lo toman.
- **Renombrado de registros** elimina WAR y WAW.
- Se pide típicamente: el contenido de las RS y registros en el ciclo N. Clave: seguir cuándo cada instrucción entra a RS, empieza a ejecutar y escribe.
- Latencias del ejercicio: por ejemplo "ALU FP = 4 RS / 2 clk" significa 4 estaciones y 2 ciclos de ejecución.

---

## 5. OpenCL (kernels + host) **[ext]**

(Basado en los parciales; no hay material teórico de OpenCL en la carpeta.)

- **Modelo**: el host (Python con PyOpenCL) manda trabajo a un device (GPU). Un **kernel** se ejecuta una vez por **work-item** (hilo).
- **NDRange**: `globalRange` = cantidad total de work-items; `localRange` = tamaño de work-group.
- **Índice del work-item**: `int i = get_global_id(0);` (dimensión 0). En 2D: `get_global_id(0)` = fila/columna, `get_global_id(1)` = la otra.
- **Ejemplo** (vector × alpha):
```c
__kernel void parallelVMult(const int N, const float alpha, __global float *a_g) {
    int i = get_global_id(0);
    if (i < N)
        a_g[i] = a_g[i] * alpha;
}
```
- Para matriz NxN: `i = get_global_id(0); j = get_global_id(1); if (i<N && j<N) a_g[i*N+j] *= alpha;`
- **Buffers**: `cl.Buffer(context, flags, hostbuf=...)`. `COPY_HOST_PTR` copia el array del host al device al crear el buffer.
- **Copiar resultado de vuelta**: `cl.enqueue_copy(queue, host_array, device_buffer)`.
- Cuidado: `globalRange` debe ser múltiplo de `localRange` en OpenCL 1.x.

---

## 6. Checklist para el examen

- [ ] Descomponer dirección (tag/index/offset) en directa y 2-vías, en bits.
- [ ] Simular accesos con LRU en 2-vías, mostrando estado final.
- [ ] Calcular miss rate, AMAT y tiempo total (1 GHz → 1 ns/ciclo).
- [ ] Detectar RAW en código LEGv8 y decidir forwarding vs stall (load-use).
- [ ] Armar issue packets en 2-issue (slot ALU/salto + slot load/store) con nops.
- [ ] Calcular ciclos 1-issue vs 2-issue y speedup.
- [ ] Simular predictor de 2 bits y global (GR + PHT): qué posiciones se modifican.
- [ ] Llenar reservation stations de Tomasulo en el clock N.
- [ ] Completar kernel OpenCL con get_global_id y chequeo de bordes.


---

## 7. Ejercicios resueltos y métodos (prácticos 5 y 6)

> Fuente: `practico/practico_06_...md` (ejercicios 3, 4, 7, 8, 9 y "ejercicio tipo parcial") y `practico/practico_05_...md`.
> Los ejercicios que no están resueltos acá se dejan con el **método**; los resultados finales hay que verificarlos contra la resolución de la cátedra.

---

### A. Predictores de saltos

### A.1 Predictor de 2 bits (práctico 6, ej. 3)
Estados: `00` Strongly NT → `01` Weakly NT → `10` Weakly T → `11` Strongly T.
- Taken: sube un estado (máximo 11). Not taken: baja un estado (mínimo 00).
- Predicción: `T` si el bit alto es 1 (estados 10 y 11), `NT` si es 0.

**Patrón**: T, NT, T, T, NT. Arranca en `00`.

| Salto | Estado antes | Predicción | Real | ¿Acierta? | Estado después |
|---|---|---|---|---|---|
| 1 | 00 | NT | T | ✗ | 01 |
| 2 | 01 | NT | NT | ✓ | 00 |
| 3 | 00 | NT | T | ✗ | 01 |
| 4 | 01 | NT | T | ✗ | 10 |
| 5 | 10 | T | NT | ✗ | 01 |

- **b) Primeros 4 saltos**: 1 de 4 aciertos → **25%**.
- **c) Patrón repetido infinitamente**: el sistema entra en un ciclo. Empezando en `10`:
  T→11 (✓), NT→10 (✗), T→11 (✓), T→11 (✓), NT→10 (✗). Vuelve a `10`.
  Aciertos: 3 de 5 → **60%** en régimen (sin contar el transitorio inicial).
- **a) Always-taken**: acierta en los 3 T de 5 → **60%**. **Always-not-taken**: acierta en los 2 NT → **40%**.

**Truco de examen**: siempre dibujá la tabla de estados. Es la forma más segura de no equivocarte.

### A.2 Penalidad por mala predicción (práctico 6, ej. 4)
Fórmula: **CPI extra = (fracción de saltos) × (tasa de error) × (penalidad en ciclos)**.

- Fracción de saltos = CBZ/CBNZ (25%) + B (5%) = **30%**.
- Tasas de error: Always-T 55%, Always-NT 45%, 2-bit 15%.
- Supuesto del enunciado: la decisión se conoce en ID y se aplica en EX, así que la penalidad es **1 ciclo** (la instrucción equivocada se descarta). Verificá si la cátedra usa otra penalidad.

| Método | Error | CPI extra |
|---|---|---|
| Always-Taken | 55% | 0.30 × 0.55 × 1 = **0.165** |
| Always-NT | 45% | 0.30 × 0.45 × 1 = **0.135** |
| 2-bit | 15% | 0.30 × 0.15 × 1 = **0.045** |

### A.3 Predictor de dos niveles y local (práctico 6, ej. 5)
- Predictor **local**: usa el historial propio de cada salto. Para un lazo interno que se ejecuta 3 veces (`B.LT` con T, T, NT), el patrón local es T, T, NT, que se predice bien con 2 bits de historial.
- Predictor **global**: usa el historial de los saltos recientes (GR) para indexar la PHT.
- Comparar precisión: contar aciertos sobre el patrón completo después del transitorio.

### A.4 Correlación (práctico 6, ej. 6)
- **Correlación local**: un salto depende de su propio historial. Ej.: en `B1` (el lazo), la condición `i < N` es casi siempre T.
- **Correlación global**: un salto depende de los resultados de otros saltos. Ej.: `B4` (`val % 6 == 0`) está correlacionado con `B2` y `B3`: si `val % 2 == 0` y `val % 3 == 0`, entonces `val % 6 == 0`.

### A.5 Predictor global con GR y PHT (parcial 2023 y 2025)
Procedimiento (mismo para los parciales):
1. Calculá el índice de la PHT: si el enunciado dice "indexado por GR concatenado con bits de la dirección", armá el índice así. Si dice otra cosa, seguí el enunciado.
2. Leé el contador de 2 bits de esa posición.
3. Predecí según el bit alto.
4. Actualizá el contador según el resultado real.
5. Desplazá el resultado al GR.
Hacé siempre una tabla por cada salto ejecutado: `iteración | GR antes | índice PHT | contador antes | predicción | real | contador después | GR después`.

---

### B. Caché (práctico 5)

### B.1 Formato de dirección (ej. 5, 6, 7, 8, 9)
- Dirección en **bytes**: si la palabra es de 32 bits (4 bytes) y el bloque tiene 4 palabras, `offset = log2(4 palabras × 4 bytes) = 4 bits`.
- Dirección en **palabras**: `offset = log2(palabras por bloque)`.
- `index = log2(nº de líneas)` (directa) o `log2(nº de conjuntos)` (N-vías).
- `tag = bits de dirección − index − offset`.
- Verificá siempre si el enunciado direcciona bytes o palabras.

### B.2 Ejemplo: ej. 7 (asociativa 2 vías, bloque 2 palabras, caché 32K palabras, dirección 32 bits)
- Palabra = 32 bits, bloque = 2 palabras = 8 bytes → offset de palabra = 1 bit (y 2 bits de byte si direccionamos bytes).
- Líneas = 32K palabras / 2 palabras por bloque = 16K bloques → conjuntos = 16K / 2 vías = 8K → **index = 13 bits**.
- Tag = 32 − 13 − 1 (en palabras) = 18 bits.
- Tag total = 18 bits × 16K líneas = 294.912 bits.

### B.3 Ej. 4 (secuencia de referencias)
- Para cada dirección: calculá `index = (bloque) mod (nº de líneas)`, `tag = bloque / nº de líneas`, y marcá hit o miss según el contenido de la línea hasta ese momento.
- La caché empieza vacía, así que el primer acceso a cada bloque siempre es miss (compulsory).

### B.4 Ej. 9 (AMAT y misses en segmento de código)
- Contá los accesos a datos por iteración (LDURH de A[] en el segmento 1: 2 por iteración) y mirá qué bloques se tocan.
- Con accesos secuenciales, un bloque de varias palabras genera miss solo en el primer acceso a ese bloque; los siguientes son hit (localidad espacial). Calculá la dirección de cada acceso con la base y el desplazamiento de cada instrucción.

### B.5 AMAT y tiempos (ej. 10, 11, 12)
- **AMAT = hit time + miss rate × miss penalty**.
- En ciclos: si el ciclo es 1 ns y la penalidad es 20 ciclos, `AMAT = 1 + 0.05 × 20 = 2 ciclos`.
- **CPI con memoria** = CPI ideal + (accesos a memoria por instrucción × miss rate × penalidad).
- En ej. 11: 36% de las instrucciones acceden a datos; los accesos por instrucción cuentan loads y stores.

---

### C. Multiple issue (práctico 6, ej. 7, 8, 9 y "ejercicio tipo parcial")

### C.1 Reglas que el enunciado impone (leer siempre)
1. Qué tipo de instrucción va en cada slot (ej.: slot 1 ALU/salto, slot 2 load/store).
2. Si hay forwarding y a qué etapas (en el "tipo parcial" hay forwarding a ID para saltos).
3. Si los saltos están predichos (si sí, no hay penalidad de salto).
4. Si dos instrucciones dependientes pueden ir en el mismo paquete (en el "tipo parcial" **no**).
5. Si un stall paraliza todo el paquete (en ej. 8, sí).

### C.2 Procedimiento
1. Listá las dependencias RAW entre instrucciones. Anotá cuál es el operando y en qué ciclo está disponible.
2. Distribuí las instrucciones en paquetes respetando los slots. Si una depende de la de su paquete, pasala al siguiente.
3. Usá **nops** para completar slots vacíos y para cubrir load-use.
4. Dibujá el diagrama: una fila por instrucción, columnas por ciclo, con IF/ID/EX/MEM/WB. Indicá los caminos de forwarding (EX→EX, MEM→EX, o los de ID si el enunciado los incluye).
5. Contá los ciclos desde la primera instrucción hasta la última en WB.

### C.3 Speedup
- **Speedup = ciclos (1-issue) / ciclos (2-issue)** con el mismo número de iteraciones.
- Si el enunciado dice "miles de iteraciones", el resultado tiende a la razón de los CPIs de régimen.
- En "tipo parcial" c): hacé el cálculo con la cantidad total de iteraciones que indique el código.

### C.4 Loop unrolling (ej. 7c, 8f, 8g, 9d, "tipo parcial" d)
- Si el número de iteraciones es múltiplo de *k*, replicá el cuerpo *k* veces y ajustá el índice y el contador.
- Ventaja: menos saltos y más instrucciones independientes para llenar los paquetes.
- **Número de LDUR por lazo**: si replicás el cuerpo con 2 LDUR cada uno y unrolling ×*k*, hay `2k` LDUR por lazo. Con X10 múltiplo de 4 y 2 iteraciones por lazo, verificá si el código final ejecuta 2 o 4 cuerpos.

### C.5 Qué mirar en el ejercicio tipo parcial (práctico 6)
- Forwarding solo EX→EX vs solo MEM→EX (inciso b): elegí el que cubra más dependencias del código. Contá las dependencias RAW cubiertas por cada opción; la que cubra menos stalls con menos multiplexores es la respuesta.

---

### D. Pendientes (no resueltos acá)
- Práctico 6 ej. 2 (fetch de 5 instrucciones con penalidad de 20 ciclos) y ej. 1 (pipeline profundo, speedup con CPI creciente).
- Práctico 6 ej. 7, 8 y 9: los diagramas completos y los conteos de ciclos.
- Práctico 5 ej. 1, 2, 3 (conceptos y tamaño de caché), 11, 12 (CPI y AMAT).
- Práctico 4 (pipeline): no lo leí en esta sesión.

Para estos, aplicá el método de las secciones B y C y compará con la resolución de la cátedra.
