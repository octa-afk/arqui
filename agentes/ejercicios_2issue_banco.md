# Banco de ejercicios — Static 2-issue (LEGv8)

> **Objetivo.** Practicar el *multiple issue estático* de LEGv8 (armado de **issue packets**, dependencias, load-use, reordenamiento y cálculo de ciclos/speedup), que es lo que pide el **Ejercicio 2 del Parcial 2 2025-10-24**.
>
> **Contenido:**
> - **Parte A** — ejercicios casi idénticos tomados de los otros parciales 2 (2023 A, 2023 B, 2024 A) + el del 2025 como referencia.
> - **Parte B** — ejemplos creados y **resueltos** por mí, de dificultad creciente.
>
> **Fuentes.** Los textos de la Parte A provienen de los PDFs de `parciales_viejos/` re-OCReados a 400 dpi (el OCR original era ilegible en tramos). Todo lo dudoso queda marcado `[ilegible/incierto]`. **Verificá contra el PDF** antes de confiar en un registro o número.

---

## 0. Método de resolución (repaso)

**Restricciones del modelo (las de 2024/2025 y del "ejercicio tipo parcial" del Práctico 6):**

| Slot 1 | Slot 2 |
|---|---|
| ALU o salto (ADD, SUB, ADDI, ORR, SUBS, CBZ/CBNZ, B…) | Load o store (LDUR, STUR, LDURB, STURB…) |

**Reglas para armar packets:**
1. Cada instrucción va **a su slot fijo**.
2. **Dentro de un mismo packet no puede haber dependencia** entre las dos instrucciones.
3. **Entre packets** la resuelve el **forwarding** (así que no hace falta separar ALU→ALU).
4. **Load-use:** un `LDUR`/`LDURB` y la instrucción que **usa** su dato necesitan **≥2 packets de separación** (equivale al 1 *stall* del 1-issue: el dato recién está listo al final de MEM). El compilador lo **tapa reordenando** o con **`nop`**.
5. Slot vacío → **`nop`**.

**Convenciones de forwarding asumidas** (verificar con la cátedra; son las estándar P&H):
- **ALU → ALU / dirección / base / condición de salto:** alcanza **gap ≥ 1** packet.
- **Load → uso:** exige **gap ≥ 2** packets.
- **Dato de store (registro fuente de `STUR`):** alcanza **gap ≥ 1** packet desde quien lo produce.

**Ciclos:**
- Régimen (lazo grande): **ciclos por iteración ≈ N° de packets** de la iteración.
- Segmento suelto de `P` packets desde cero: **`P + 4`** ciclos (fill de las 5 etapas).

**Cota inferior:** `N° packets ≥ max(#instrucciones slot 1, #instrucciones slot 2)`. Si los load-use no obligan a nada extra, esa cota se alcanza.

**Speedup:** `S = ciclos(1-issue) / ciclos(2-issue)`.

---

# Parte A — Ejercicios de parciales viejos

## A.1 — Parcial 2 2023-11-08 (Tema A), Ej. 2

> **Configuración distinta:** este parcial **NO** usa el par ALU/store. Permite **dos aritmético/lógicas juntas**: *una instrucción puede ser de cualquier tipo (**IssueA**), pero la otra debe ser aritmética o lógica (**IssueB**)*. Salta perfectamente predichos.

Dado el fragmento LEGv8, con `X0` = dirección base del arreglo `A` (elementos de **1 Byte**), `X1 = N` (cantidad de elementos), `X2 = 1` y el resto de los registros en `0`:

```asm
1>      ADD   X3, X0, X1
2> loop: LDURB X9,  [X0, #0]
3>      SUB   X12, X9, X2
4>      LDURB X10, [X3, #0]
5>      STURB X12, [X3, #0]
6>      SUBI  X3, X3, #1
7>      ADDI  X0, X0, #1
8>      ADD   X11, X10, X2
9>      STURB X11, [X0, #-1]
10>     SUBS  X11, X0, X3
11>     B.GE  end        // >= signado
12>     ADDI  X2, X2, #2
13>     B     loop
end:
```

**Se pide:**
- **a)** Analizar las dependencias de datos **que NO sean condicionales** y completar una tabla del tipo `tipo (RAW/WAW/WAR) | registro | instrucciones`.
- **b)** **Sin alterar el orden** de las instrucciones, mostrar cómo organizaría los *issue packets* para ejecutar en la **menor cantidad de ciclos** posible (cada instrucción **sólo** puede agruparse con la **inmediata anterior**, la **inmediata posterior** o una **`nop`**). El compilador inserta los `nop`.
- **c)** Calcular la **cantidad de ciclos** del código en un LEGv8 **1-issue** y en el **2-issue** descrito (saltos perfectamente predichos, sin flush). Suponer **N = 5** y considerar **la totalidad de las iteraciones**. Completar:
  - i. Tiempo de ejecución en 1-issue = ____ ciclos.
  - ii. Tiempo de ejecución en 2-issue = ____ ciclos.
  - iii. Ganancia en velocidad = ____.

> *Nota:* el Ejercicio 3 del mismo examen reutiliza este código para Tomasulo (ver "código del Ej. 2").

---

## A.2 — Parcial 2 2023-11-08 (Tema B), Ej. 2

> Misma configuración que A.1 (*IssueA* cualquiera + *IssueB* aritmético/lógica). Salta perfectamente predichos.
> `X0` = dirección base del arreglo `A` (**DoubleWord**, 8 bytes), `X1 = N`, demás registros en `0`.

```asm
1>      LSL   X3, X1, #3
2>      ADD   X3, X0, X3
3>      ORR   X2, X0, X0               // [ilegible/incierto: registros fuente]
4> loop: SUBS  X12, X0, X3
5>      B.GE  end        // >= signado
6>      LDUR  X9,  [X0, #0]            // [ilegible/incierto: registro destino = X9?]
7>      LDUR  X10, [X3, #0]
8>      SUB   X12, X3, X2
9>      ADD   X11, X10, X2
10>     STUR  X12, [X3, #0]
11>     STUR  X11, [X0, #0]
12>     ADDI  X0, X0, #8
13>     SUBI  X3, X3, #8
14>     B     loop
end:
```

**Se pide:** idéntico a A.1 (a: dependencias no condicionales; b: packets sin alterar orden; c: ciclos 1-issue vs 2-issue + ganancia, con N = 5).

---

## A.3 — Parcial 2 2024-10-25 (Tema A), Ej. 2

> El más parecido en **forma** al del 2025: diagrama de procesador LEGv8 **2-issue** con forwarding **incluido el camino a ID** para resolución de saltos; **saltos perfectamente predichos** (sin penalidad); al tomar un salto se hace fetch del paquete correcto (`PC+8` o `PC+offset`).
> **[verificar slots]**: los límites de cada slot están en la figura del enunciado; por el estilo del examen se espera **Slot 1 = ALU/salto**, **Slot 2 = memoria**.

```asm
1>      ORRI  X4, XZR, #0x8
2> loop: CBZ   X0, end
3>      LDUR  X2, [X1, #0]
4>      SUBI  X0, X0, #1
5>      LDUR  X3, [X1, #8]
6>      ADD   X1, X1, X4
7>      STUR  X2, [X1, #0]
8>      ADD   X3, X3, X1
9>      CBZ   XZR, loop
10> end:
```

**Se pide** (con `X0 = 2` antes de empezar):
- **a)** Analizar las dependencias de datos y completar la tabla de la **"RAW condicional"** con: `N° de instrucciones | operando en conflicto` (primer caso de cada una).
- **b)** **Sin alterar el orden**, organizar los *issue packets* para minimizar ciclos (cada instrucción **sólo** con la inmediata anterior, la inmediata posterior o una `nop`). Luego **completar los recuadros del diagrama del pipeline** indicando **qué instrucción está en cada etapa en el ciclo de clock 6** (issue negro y issue gris).

> *Comentario:* acá el inciso b pide además **dibujar el pipeline en un ciclo dado**, algo que el 2025 no pide explícitamente, pero conviene saber hacerlo.

---

## A.4 — Parcial 2 2025-10-24, Ej. 2 (referencia, el que estamos resolviendo)

> **Slot 1** = ALU (ADD, SUB, ADDI, ORR) o salto (B, CBNZ). **Slot 2** = LDUR/STUR. Pipeline de 5 etapas. Todos los caminos de forwarding, **sin stalls por datos** → el compilador inserta `nop` / reordena. Salta: **[verificar]** (el enunciado del Ej. 4 dice que se predice Taken correctamente).

Considerar el **código del Ejercicio 4**:

```asm
        ADD  X5, XZR, XZR
L1:     LDUR X8,  [X0, #0]
        LDUR X7,  [X0, #0]
        ADD  X6, X8, X7
        SUB  X5, X8, X7
        STUR X6,  [X0, #0]
        STUR X5,  [X0, #0]
        ADDI X0, X0, #8
        SUBIS X2, X2, #1
        B.LT L1
```

**Se pide:** aplicando **solo Reordenamiento de Código**, conformar los *issue packets* para **MINIMIZAR los ciclos de clock de una iteración del lazo**.

> *Conteo inicial de slots del cuerpo (`L1`→`B.LT`, 9 instrucciones):* slot 2 = 4 (`LDUR,LDUR,STUR,STUR`); slot 1 = 5 (`ADD,SUB,ADDI,SUBIS,B.LT`) → **cota inferior = 5 packets**.

---

# Parte B — Ejemplos creados (con solución)

> Recordá las convenciones de forwarding de la sección 0.

## B.1 — Calentamiento: slots, cota y packets

```asm
    ADD  X1, X8,  X9     ; 1
    LDUR X2, [X0, #0]    ; 2
    SUB  X3, X10, X11    ; 3
    STUR X1, [X0, #8]    ; 4   (usa X1)
    ORR  X4, X12, X13    ; 5
    ADDI X0, X0, #16     ; 6
```

**a)** Asigná cada instrucción a su slot y calculá la cota inferior de packets.
**b)** Armá los packets y contá los ciclos.

<details>
<summary>Solución</summary>

**a)** Slot 1: 1, 3, 5, 6 → **4**. Slot 2: 2, 4 → **2**. Cota = **max(4,2) = 4 packets**.

**b)** Dependencia: 4 ← 1 (RAW sobre `X1`, dato de store → gap ≥1 alcanza).

| Packet | Slot 1 | Slot 2 |
|:--:|:--|:--|
| P1 | `ADD X1,X8,X9` (1) | `LDUR X2,[X0,#0]` (2) |
| P2 | `SUB X3,X10,X11` (3) | `STUR X1,[X0,#8]` (4) |
| P3 | `ORR X4,X12,X13` (5) | `nop` |
| P4 | `ADDI X0,X0,#16` (6) | `nop` |

**4 packets** = cota inferior ✔ (o **8 ciclos** contando el fill de las 5 etapas).
</details>

---

## B.2 — Load-use y reordenamiento

```asm
    LDUR X1,  [X0, #0]   ; 1
    ADD  X2, X2, X1      ; 2   (usa X1)
    SUB  X3, X4, X5      ; 3
    ADDI X0, X0, #8      ; 4
```

**a)** ¿Cuántos packets si **NO** podés reordenar (mantenés el orden)?
**b)** ¿Cuántos packets como mínimo **reordenando**? Mostrá el scheduling.

<details>
<summary>Solución</summary>

Slot 1: 2, 3, 4 → 3. Slot 2: 1 → 1. Cota = **3 packets**.
Dependencia 2 ← 1 es **load-use** → necesitan **gap ≥ 2**.

**a) Sin reordenar** (el orden obliga a 1 antes que 2):

| Packet | Slot 1 | Slot 2 |
|:--:|:--|:--|
| P1 | `nop` | `LDUR X1,[X0,#0]` (1) |
| P2 | `SUB X3,X4,X5` (3) | `nop` |
| P3 | `ADD X2,X2,X1` (2) | `nop` |
| P4 | `ADDI X0,X0,#8` (4) | `nop` |

**4 packets** (el `ADD` no puede ir en P2: sería load-use a 1 packet).

**b) Reordenando** (adelantamos 3 y 4):

| Packet | Slot 1 | Slot 2 |
|:--:|:--|:--|
| P1 | `SUB X3,X4,X5` (3) | `LDUR X1,[X0,#0]` (1) |
| P2 | `ADDI X0,X0,#8` (4) | `nop` |
| P3 | `ADD X2,X2,X1` (2) | `nop` |

**3 packets** = cota inferior ✔ (1 está en P1, 2 en P3 → gap 2). Reordenar bajó de 4 a **3**.
</details>

---

## B.3 — Lazo completo (estilo parcial)

```asm
LOOP: LDUR X1,  [X0, #0]    ; 1
      LDUR X2,  [X0, #8]    ; 2
      ADD  X3, X1, X2       ; 3   (usa X1 y X2)
      STUR X3,  [X0, #0]    ; 4   (usa X3)
      ADDI X0, X0, #16      ; 5
      SUBI X6, X6, #1       ; 6
      CBNZ X6, LOOP         ; 7
```

**a)** Armá los packets (reordenamiento libre) y dá los **ciclos por iteración**.
**b)** Compará con la cota inferior y explicá por qué se alcanza o no.

<details>
<summary>Solución</summary>

Slot 1: 3, 5, 6, 7 → **4**. Slot 2: 1, 2, 4 → **3**. Cota = **4 packets**.

Dependencias: 3 ← {1, 2} (**load-use**); 4 ← 3 (dato de store, gap ≥1).

| Packet | Slot 1 | Slot 2 | Comentario |
|:--:|:--|:--|:--|
| P1 | `SUBI X6,X6,#1` (6) | `LDUR X1,[X0,#0]` (1) | independientes |
| P2 | `ADDI X0,X0,#16` (5) | `LDUR X2,[X0,#8]` (2) | independientes |
| P3 | `nop` | `nop` | hueco (no hay slot 1 usable antes del branch) |
| P4 | `ADD X3,X1,X2` (3) | `nop` | 2 está en P2 → gap 2 ✔ |
| P5 | `CBNZ X6,LOOP` (7) | `STUR X3,[X0,#0]` (4) | 4: gap 1 desde P4 ✔; 7: gap 4 desde P1 ✔; branch al final ✔ |

**a) 5 packets por iteración.**

**b)** La cota era **4**, pero **no se alcanza**: la cadena `LDUR2 (P2) → ADD (P4) → STUR (P5)` más el `CBNZ` (que debe ir **después** de todo) fuerza **5**. El hueco P3 aparece porque el `ADD` no puede adelantarse (load-use con `LDUR2`).
</details>

---

## B.4 — "Encontrá el error" (revisión de un scheduling)

Un estudiante propone este scheduling. ¿Está bien? Marcá **todos** los problemas.

```asm
    ADD  X1, X2, X3      ; 1
    LDUR X4, [X0, #0]    ; 2
    ADD  X5, X1, X4      ; 3   (usa X1 y X4)
    STUR X5, [X0, #8]    ; 4   (usa X5)
```

| Packet propuesto | Slot 1 | Slot 2 |
|:--:|:--|:--|
| P1 | `LDUR X4,[X0,#0]` (2) | `ADD X1,X2,X3` (1) |
| P2 | `ADD X5,X1,X4` (3) | `STUR X5,[X0,#8]` (4) |

<details>
<summary>Solución</summary>

**Hay 3 errores:**

1. **Slots invertidos en P1:** el `LDUR` (load) debe ir en **Slot 2**, y el `ADD` en **Slot 1**. Tal como está, no es un packet válido.
2. **`ADD X5` (3) usa `X4`, que carga (2) en el packet inmediato anterior** → **load-use con gap 1**. Necesita gap ≥ 2. (También usa `X1` de (1); ese gap 1 sí es válido.)
3. **`STUR` (4) y `ADD X5` (3) en el mismo packet:** (4) depende de (3) → **dependencia dentro del packet, prohibida**.

**Scheduling corregido** (slots + reordenamiento):

| Packet | Slot 1 | Slot 2 |
|:--:|:--|:--|
| P1 | `ADD X1,X2,X3` (1) | `LDUR X4,[X0,#0]` (2) |
| P2 | `nop` | `nop` |
| P3 | `ADD X5,X1,X4` (3) | `nop` |
| P4 | `nop` | `STUR X5,[X0,#8]` (4) |

Ahora: slots correctos, (3) a gap 2 de (2) ✔, (4) en packet distinto de (3) ✔.
</details>

---

## B.5 — Desafío: 1-issue vs 2-issue (speedup)

Usá el lazo de **B.3**. Suponiendo que corre **miles de iteraciones** y que en ambos procesadores los saltos están perfectamente predichos:

**a)** ¿Cuántos ciclos por iteración en **1-issue con forwarding-stall**?
**b)** ¿Cuántos en **2-issue** (tu scheduling de B.3)?
**c)** ¿Cuál es el **speedup**?

<details>
<summary>Solución</summary>

**a) 1-issue** (7 instrucciones + stalls). Contamos stalls por load-use/dependencias:
- (1)→(3) load-use, pero hay instrucciones en el medio → **sin stall**.
- (2)→(3) load-use: `ADD X3,X1,X2` usa `X2` de `LDUR X2,[X0,#8]` que es la **instrucción inmediata anterior** → **1 stall**.
- (3)→(4) `STUR` usa `X3` de `ADD` inmediato anterior → con forwarding, **0 stalls** (ALU→store, gap ≥1 ya alcanzado por adyacencia… pero (4) es la siguiente a (3): ALU→dato de store con gap 0 → **1 stall** según la convención “dato de store gap ≥1”). → **1 stall**.
- (5),(6),(7) sin dependencias problemáticas.

Entonces ciclos = instrucciones + stalls + (fill−1) = `7 + 2 + 4` … pero en **régimen** (miles de iteraciones) el fill se amortiza:
  **ciclos por iteración (1-issue) ≈ 7 + 2 = 9**.

**b) 2-issue (B.3):** **5** ciclos por iteración.

**c) Speedup ≈ 9 / 5 = 1.8**.

> ⚠️ El número exacto depende de cuántos stalls cuentes (sobre todo el de **dato de store**). Ajustá según la convención que use la cátedra; el **método** es lo importante.
</details>

---

# Parte C — Ej. 2 del Parcial 2 2025 **resuelto** (ambas convenciones)

> Resolución completa del ejercicio de A.4. **La única diferencia entre las dos formas es cómo se trata la WAR del puntero `X0`.**

## C.0 — Slots, cota y dependencias (común)

- Slot 1: `ADD(3), SUB(4), ADDI(7), SUBIS(8), B.LT(9)` → **5**
- Slot 2: `LDUR(1), LDUR(2), STUR(5), STUR(6)` → **4**
- **Cota inferior = max(5,4) = 5 packets.**

| Dependiente | Productor | Tipo | Separación |
|:--|:--|:--|:--|
| 3 `ADD X6` | 1, 2 (`LDUR`) | load-use | **2 packets** |
| 4 `SUB X5` | 1, 2 (`LDUR`) | load-use | **2 packets** |
| 5 `STUR X6` | 3 `ADD X6` | RAW (dato de store) | 1 packet |
| 6 `STUR X5` | 4 `SUB X5` | RAW (dato de store) | 1 packet |
| 9 `B.LT` | 8 `SUBIS` | RAW (flags) | 1 packet |
| 7 `ADDI X0` | 1, 2, 5, 6 (leen `X0`) | **WAR sobre `X0`** | según convención |

La cota 5 no se alcanza nunca: `ADD`(3) y `SUB`(4) son ambos slot 1 → lo más temprano es P4 y P5, y las dos `STUR` colgando de ellos fuerzan dos packets ≥ P5.

## C.A — Forma "estilo P&H" (NO protege el WAR del puntero) → **6 packets**

Supuesto: se permite adelantar `ADDI X0` por delante de las `STUR`, como en la figura *Scheduling Example* del teórico (P&H, slide 125).

| Packet | Slot 1 | Slot 2 |
|:--:|:--|:--|
| P1 | `SUBIS X2,X2,#1` (8) | `LDUR X8,[X0,#0]` (1) |
| P2 | `nop` | `LDUR X7,[X0,#0]` (2) |
| P3 | `ADDI X0,X0,#8` (7) | `nop` |
| P4 | `ADD X6,X8,X7` (3) | `nop` |
| P5 | `SUB X5,X8,X7` (4) | `STUR X6,[X0,#0]` (5) |
| P6 | `B.LT L1` (9) | `STUR X5,[X0,#0]` (6) |

**Resultado: 6 ciclos/iteración** · IPC = 9/6 = 1,5.
⚠️ Las `STUR` direccionan con el `X0` **ya incrementado** (guardarían en `[X0+8]`).

## C.B — Forma correcta (respeta el WAR del puntero) → **8 packets**

Supuesto: `ADDI X0` va **después** de las dos `STUR`. Criterio que implican los parciales 2023/2024 (piden WAR/WAW) y la figura *Loop Unrolling* (slide 127).

| Packet | Slot 1 | Slot 2 |
|:--:|:--|:--|
| P1 | `SUBIS X2,X2,#1` (8) | `LDUR X8,[X0,#0]` (1) |
| P2 | `nop` | `LDUR X7,[X0,#0]` (2) |
| P3 | `nop` | `nop` |
| P4 | `ADD X6,X8,X7` (3) | `nop` |
| P5 | `SUB X5,X8,X7` (4) | `STUR X6,[X0,#0]` (5) |
| P6 | `nop` | `STUR X5,[X0,#0]` (6) |
| P7 | `ADDI X0,X0,#8` (7) | `nop` |
| P8 | `B.LT L1` (9) | `nop` |

Cadena crítica: `L2 →(+2) ADD/SUB →(+1) STUR →(+1) ADDI →(+1) B.LT = 8`.

**Resultado: 8 ciclos/iteración** · IPC = 9/8 = 1,125.

## C.Comparación

| | Puntero protegido | Packets | IPC | ¿Correcto? |
|:--|:--:|:--:|:--:|:--:|
| **A – estilo P&H** | ❌ | **6** | 1,5 | ✘ |
| **B – estricto** | ✅ | **8** | 1,125 | ✔ |

> **Variante legítima (transformación tipo unrolling):** `ADDI X0,X0,#8` al frente y todos los accesos con offset `#-8`. Recupera la corrección sin dejar el `ADDI` suelto, pero el lazo queda en **7 packets**.

## Pregunta para el profe

> *"Al reordenar, ¿hay que preservar el valor del puntero/base para los accesos del mismo lazo (respetar el WAR sobre `X0`), o alcanza con respetar los RAW y el load-use como en la figura de P&H del teórico?"*

**Evidencia a favor de A:** figura *Scheduling Example* (P&H, slide 125) adelanta el puntero.
**Evidencia a favor de B:** parciales 2023/2024 piden listar WAR/WAW; figura *Loop Unrolling* (slide 127) compensa con offsets.

---

## Próximos pasos

- Confirmar con la cátedra la **convención del puntero** (A vs B) y la de **dato de store** (gap 1 vs 2).
- Confirmar si en 2025 los **saltos** están predichos perfectamente.
- Con eso fijado, resolver A.1/A.2/A.3 (2023 y 2024) con el mismo método.
