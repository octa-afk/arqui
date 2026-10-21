# Ejemplos de simulación de caché (estilo Parcial 2)

> Configuración común a todos los ejemplos:
> - Procesador de 8 bits, direcciones de 16 bits, direccionamiento a byte.
> - Caché 2: 2 vías, 2 conjuntos, bloques de 16 bytes, política LRU, inicialmente vacía.
> - Campos (Caché 2): **tag = bits 15 a 5 (11 bits)**, **index = bit 4 (1 bit)**, **word = bits 3 a 0 (4 bits)**, OffsetByte = 0 bits.
> - Datos: el rango del bloque se escribe de mayor a menor, como en el enunciado: `M[base+0xF] .. M[base]`.
> - Cada fila muestra el **estado de la caché después del acceso**.

---

## Ejemplo 0: Consigna original (Parcial 2 2025, ej. 1 b, Caché 2)

**Consigna:** Simule la secuencia de accesos SOLO en Caché 2. Para cada acceso indique si fue Hit o Miss, el número de conjunto involucrado y su estado final (contenidos de Tag y Datos).

**Secuencia:** 0x0A10, 0x0A52, 0x0A18, 0x0A5C, 0x0A10, 0x0B10

**Resolución**

| Acc | Address | Tag (bits) | Index | Word | Set | H/M | Tag V0 | Datos V0 | Tag V1 | Datos V1 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 0x0A10 | 00001010000 (050) | 1 | 0000 | 1 | M | 050 | M[0x0A1F] .. M[0x0A10] | – | – |
| 2 | 0x0A52 | 00001010010 (052) | 1 | 0010 | 1 | M | 050 | M[0x0A1F] .. M[0x0A10] | 052 | M[0x0A5F] .. M[0x0A50] |
| 3 | 0x0A18 | 00001010000 (050) | 1 | 1000 | 1 | H | 050 | M[0x0A1F] .. M[0x0A10] | 052 | M[0x0A5F] .. M[0x0A50] |
| 4 | 0x0A5C | 00001010010 (052) | 1 | 1100 | 1 | H | 050 | M[0x0A1F] .. M[0x0A10] | 052 | M[0x0A5F] .. M[0x0A50] |
| 5 | 0x0A10 | 00001010000 (050) | 1 | 0000 | 1 | H | 050 | M[0x0A1F] .. M[0x0A10] | 052 | M[0x0A5F] .. M[0x0A50] |
| 6 | 0x0B10 | 00001011000 (058) | 1 | 0000 | 1 | M | 050 | M[0x0A1F] .. M[0x0A10] | 058 | M[0x0B1F] .. M[0x0B10] |

**Claves del razonamiento:**
- Acc 3 y 4 son hits porque su bloque (0x0A10 y 0x0A50) ya estaba cargado en el mismo conjunto.
- Acc 6 es miss y reemplaza **V1**, porque después del acceso 5 la vía 0 fue la más recientemente usada (LRU = V1).

**Resultado:** 3 misses, 3 hits.

---

## Ejemplo 1: Hits en el mismo bloque y conjunto diferente

**Consigna:** Simule la secuencia en Caché 2. Indique H/M, conjunto y estado final de cada acceso.

**Secuencia:** 0x0A00, 0x0A20, 0x0A04, 0x0A30, 0x0A08

**Resolución**

Las direcciones van a dos conjuntos distintos, así que la tabla muestra el estado de ambos conjuntos en cada fila.

| Acc | Address | Tag | Index | Word | Set | H/M | Set 0: V0 | Set 0: V1 | Set 1: V0 | Set 1: V1 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 0x0A00 | 050 | 0 | 0000 | 0 | M | 050 | – | – | – |
| 2 | 0x0A20 | 051 | 0 | 0000 | 0 | M | 050 | 051 | – | – |
| 3 | 0x0A04 | 050 | 0 | 0100 | 0 | H | 050 | 051 | – | – |
| 4 | 0x0A30 | 051 | 1 | 0000 | 1 | M | 050 | 051 | 051 | – |
| 5 | 0x0A08 | 050 | 0 | 1000 | 0 | H | 050 | 051 | 051 | – |

(Cada celda muestra el tag guardado en esa vía. Los datos siguen el mismo patrón de rangos que en los ejemplos anteriores.)

**Resultado:** 3 misses (accesos 1, 2, 4) y 2 hits (accesos 3, 5).

---

## Ejemplo 2: Reemplazo LRU en un conjunto lleno (conflict misses)

**Consigna:** Simule la secuencia en Caché 2. Indique H/M, conjunto y estado final de cada acceso. Explique qué vía se reemplaza en cada miss.

**Secuencia:** 0x0A00, 0x0A20, 0x0A40, 0x0A00, 0x0A20

Todas las direcciones van al conjunto 0 (bit 4 = 0).

**Resolución**

| Acc | Address | Tag | Set | H/M | Tag V0 | Datos V0 | Tag V1 | Datos V1 | Reemplazo |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 0x0A00 | 050 | 0 | M | 050 | M[0x0A0F] .. M[0x0A00] | – | – | (V0 libre) |
| 2 | 0x0A20 | 051 | 0 | M | 050 | M[0x0A0F] .. M[0x0A00] | 051 | M[0x0A2F] .. M[0x0A20] | (V1 libre) |
| 3 | 0x0A40 | 052 | 0 | M | 052 | M[0x0A4F] .. M[0x0A40] | 051 | M[0x0A2F] .. M[0x0A20] | V0 (LRU) |
| 4 | 0x0A00 | 050 | 0 | M | 052 | M[0x0A4F] .. M[0x0A40] | 050 | M[0x0A0F] .. M[0x0A00] | V1 (LRU) |
| 5 | 0x0A20 | 051 | 0 | M | 051 | M[0x0A2F] .. M[0x0A20] | 050 | M[0x0A0F] .. M[0x0A00] | V0 (LRU) |

**Detalle del LRU:**
- Después del acceso 2: V1 es la más reciente, V0 la menos reciente.
- Acceso 3 reemplaza V0 (la menos reciente). Después: V0 es la más reciente.
- Acceso 4 reemplaza V1 (la menos reciente). Después: V1 es la más reciente.
- Acceso 5 reemplaza V0 (la menos reciente).

**Resultado:** 5 misses y 0 hits. Es un caso de conflict misses: las tres direcciones compiten por el mismo conjunto, y la caché de 2 vías no alcanza.

---

## Ejemplo 3: Hit que cambia el LRU y decide el reemplazo

**Consigna:** Simule la secuencia en Caché 2. Indique H/M, conjunto y estado final. Explique qué vía se reemplaza en cada miss.

**Secuencia:** 0x0A10, 0x0A30, 0x0A10, 0x0A50, 0x0A30

- 0x0A10 → conjunto 1 (bit 4 = 1), tag 050
- 0x0A30 → conjunto 1 (bit 4 = 1), tag 051
- 0x0A50 → conjunto 1 (bit 4 = 1), tag 052

**Resolución**

| Acc | Address | Tag | Set | H/M | Tag V0 | Datos V0 | Tag V1 | Datos V1 | Reemplazo |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 0x0A10 | 050 | 1 | M | 050 | M[0x0A1F] .. M[0x0A10] | – | – | (V0 libre) |
| 2 | 0x0A30 | 051 | 1 | M | 050 | M[0x0A1F] .. M[0x0A10] | 051 | M[0x0A3F] .. M[0x0A30] | (V1 libre) |
| 3 | 0x0A10 | 050 | 1 | H | 050 | M[0x0A1F] .. M[0x0A10] | 051 | M[0x0A3F] .. M[0x0A30] | – |
| 4 | 0x0A50 | 052 | 1 | M | 050 | M[0x0A1F] .. M[0x0A10] | 052 | M[0x0A5F] .. M[0x0A50] | V1 (LRU) |
| 5 | 0x0A30 | 051 | 1 | M | 051 | M[0x0A3F] .. M[0x0A30] | 052 | M[0x0A5F] .. M[0x0A50] | V0 (LRU) |

**Detalle del LRU:**
- Después del acceso 2: V1 es la más reciente, V0 la menos reciente.
- Acceso 3 es hit en V0: V0 pasa a ser la más reciente, V1 la menos reciente.
- Acceso 4 reemplaza **V1**, no V0, porque el hit del acceso 3 hizo que V0 fuera la más reciente. Después: V1 es la más reciente.
- Acceso 5 reemplaza **V0** (la menos reciente).

**Resultado:** 4 misses y 1 hit.

**Lección:** un hit cambia el orden LRU aunque no cambie tags ni datos. Sin registrar ese cambio, el reemplazo del acceso 4 saldría mal.

---

## Checklist para resolver cualquiera de estos ejemplos

1. Pasá cada dirección a binario (4 bits por dígito hex).
2. Separá: word = bits 3–0, index = bit 4, tag = bits 15–5.
3. Pasá el tag a hex (agrupá de a 4 bits, con ceros a la izquierda para completar 12 bits).
4. Mirá el conjunto indicado por el index y comparás el tag con las vías **válidas**.
5. Si hay hit: no cambian tag ni datos, pero **actualizá el LRU**.
6. Si hay miss: si hay una vía libre, la usás; si no, reemplazás la **menos recientemente usada**.
7. Completá **todas** las columnas en cada fila, porque cada fila es el estado después del acceso.

---

# Ejemplos con otros tipos de caché

> Estos ejemplos cambian la organización de la caché. Antes de simular, escribí los campos de la dirección para ese tipo de caché.

---

## Ejemplo 4: Caché directa (4 líneas, bloques de 16 bytes)

**Caché:** directa, 64 bytes, bloques de 16 bytes, direcciones de 16 bits, direccionamiento a byte.
- Word = bits 3–0 (4 bits)
- Index = bits 5–4 (2 bits, 4 líneas)
- Tag = bits 15–6 (10 bits)

**Consigna:** Simule la secuencia en la caché. Indique H/M y el estado de las 4 líneas después de cada acceso.

**Secuencia:** 0x0A10, 0x0A20, 0x0A14, 0x0A30, 0x0A12, 0x0A54

**Resolución:**

| Acc | Address | Tag (hex) | Index | Word | H/M | Línea 0 | Línea 1 | Línea 2 | Línea 3 |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 0x0A10 | 028 | 01 | 0000 | M | – | 028, M[0x0A1F]..M[0x0A10] | – | – |
| 2 | 0x0A20 | 028 | 10 | 0000 | M | – | 028, M[0x0A1F]..M[0x0A10] | 028, M[0x0A2F]..M[0x0A20] | – |
| 3 | 0x0A14 | 028 | 01 | 0100 | H | – | 028, M[0x0A1F]..M[0x0A10] | 028, M[0x0A2F]..M[0x0A20] | – |
| 4 | 0x0A30 | 028 | 11 | 0000 | M | – | 028, M[0x0A1F]..M[0x0A10] | 028, M[0x0A2F]..M[0x0A20] | 028, M[0x0A3F]..M[0x0A30] |
| 5 | 0x0A12 | 028 | 01 | 0010 | H | – | 028, M[0x0A1F]..M[0x0A10] | 028, M[0x0A2F]..M[0x0A20] | 028, M[0x0A3F]..M[0x0A30] |
| 6 | 0x0A54 | 029 | 01 | 0100 | M | – | 029, M[0x0A5F]..M[0x0A50] | 028, M[0x0A2F]..M[0x0A20] | 028, M[0x0A3F]..M[0x0A30] |

**Resultado:** 4 misses, 2 hits. **Tasa de miss = 4/6 ≈ 66,7 %.**

**Claves:**
- Los accesos 3 y 5 son hits porque su bloque ya estaba cargado en la línea 1.
- El acceso 6 tiene index 01 (línea 1) pero tag 029 ≠ 028, así que reemplaza la línea 1. En una caché directa no hay otra opción.

---

## Ejemplo 5: Caché totalmente asociativa (4 bloques, LRU)

**Caché:** totalmente asociativa, 4 bloques de 16 bytes, direcciones de 16 bits.
- Word = bits 3–0 (4 bits)
- Tag = bits 15–4 (12 bits). No hay index: un bloque puede ir a cualquier línea.

**Consigna:** Simule la secuencia con política LRU. Indique H/M y el bloque que queda en cada acceso. Si hay reemplazo, indique qué bloque se reemplaza.

**Secuencia:** 0x0A10, 0x0B20, 0x0A18, 0x0C00, 0x0D00, 0x0B2C, 0x0E00, 0x0A10

**Resolución:**

| Acc | Address | Tag (hex) | H/M | Bloques en caché (LRU → MRU) | Reemplazo |
|---|---|---|---|---|---|
| 1 | 0x0A10 | 0A1 | M | 0A1 | – |
| 2 | 0x0B20 | 0B2 | M | 0A1, 0B2 | – |
| 3 | 0x0A18 | 0A1 | H | 0B2, 0A1 | – |
| 4 | 0x0C00 | 0C0 | M | 0B2, 0A1, 0C0 | – |
| 5 | 0x0D00 | 0D0 | M | 0B2, 0A1, 0C0, 0D0 | – |
| 6 | 0x0B2C | 0B2 | H | 0A1, 0C0, 0D0, 0B2 | – |
| 7 | 0x0E00 | 0E0 | M | 0C0, 0D0, 0B2, 0E0 | reemplaza 0A1 (LRU) |
| 8 | 0x0A10 | 0A1 | M | 0D0, 0B2, 0E0, 0A1 | reemplaza 0C0 (LRU) |

**Resultado:** 6 misses, 2 hits. **Tasa de miss = 6/8 = 75 %.**

**Claves:** en el acceso 6 el bloque 0B2 se usa de nuevo, así que pasa a ser el más reciente. Por eso en el acceso 7 se reemplaza 0A1, que quedó como el menos reciente.

---

## Ejemplo 6: Caché 2-vías con bloques de 8 bytes (cambia el offset)

**Caché:** 2-vías, 32 bytes, bloques de 8 bytes → 4 líneas, 2 conjuntos. Direcciones de 16 bits, direccionamiento a byte.
- Offset = bits 2–0 (3 bits)
- Index = bit 3 (1 bit, 2 conjuntos)
- Tag = bits 15–4 (12 bits)

**Consigna:** Simule la secuencia con LRU. Indique H/M, conjunto y estado final de cada conjunto (V0 y V1, con tag y datos).

**Secuencia:** 0x0A04, 0x0A0C, 0x0A08, 0x0A00, 0x0A10, 0x0A20

**Campos:**

| Acc | Address | Tag (hex) | Index (conjunto) | Base del bloque |
|---|---|---|---|---|
| 1 | 0x0A04 | 0A0 | 0 | 0x0A00 |
| 2 | 0x0A0C | 0A0 | 1 | 0x0A08 |
| 3 | 0x0A08 | 0A0 | 1 | 0x0A08 |
| 4 | 0x0A00 | 0A0 | 0 | 0x0A00 |
| 5 | 0x0A10 | 0A1 | 0 | 0x0A10 |
| 6 | 0x0A20 | 0A2 | 0 | 0x0A20 |

**Resolución:**

| Acc | H/M | Conjunto 0: V0 | Conjunto 0: V1 | Conjunto 1: V0 | Conjunto 1: V1 | Reemplazo |
|---|---|---|---|---|---|---|
| 1 | M | 0A0 [A07..A00] | – | – | – | – |
| 2 | M | 0A0 [A07..A00] | – | 0A0 [A0F..A08] | – | – |
| 3 | H | 0A0 [A07..A00] | – | 0A0 [A0F..A08] | – | – |
| 4 | H | 0A0 [A07..A00] | – | 0A0 [A0F..A08] | – | – |
| 5 | M | 0A0 [A07..A00] | 0A1 [A17..A10] | 0A0 [A0F..A08] | – | V1 (vacía) |
| 6 | M | 0A2 [A27..A20] | 0A1 [A17..A10] | 0A0 [A0F..A08] | – | V0 (LRU) |

**Detalle del LRU en el conjunto 0:**
- Acceso 1 carga V0. Acceso 4 usa V0 otra vez.
- Acceso 5 carga V1 (libre). Ahora V1 es la más reciente.
- Acceso 6 reemplaza **V0**, porque es la menos reciente.

**Resultado:** 4 misses, 2 hits. **Tasa de miss = 4/6 ≈ 66,7 %.**

---

## Cómo elegir el tipo de ejercicio al estudiar

| Tipo de caché | Qué cambia en la simulación |
|---|---|
| Directa | Un solo lugar posible por bloque: el miss siempre reemplaza. |
| 2-vías | Hay que mirar LRU cuando el conjunto está lleno. |
| Totalmente asociativa | No hay index: comparás el tag contra todas las líneas. |
| Otro tamaño de bloque | Cambia el offset y el tag, y el rango de datos de la línea. |
