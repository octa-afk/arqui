# Resumen: tamaño total de una caché de mapeo directo

> Fuente: `humanos/teorico/resumen_cache_mapeo_directo.pdf` (resumen de estudio, FaMAF).
> **Corrección detectada**: el PDF dice que la respuesta es "≈ 22,9 KiB". Con sus propios números, 183 296 bits = 22 912 bytes = **22,375 KiB** (≈ 22,4 KiB). El resto del cálculo es correcto.

## 1. Idea central

El tamaño total de la caché incluye los datos y también los bits de overhead de cada línea: tag, bit válido y, si la política es write-back, bit dirty. Para calcularlo hacen falta el número de bloques, el tamaño del bloque y el tamaño de la dirección.

## 2. Procedimiento

| Paso | Qué calcular | Fórmula |
|---|---|---|
| 1 | Bits de datos | Capacidad (bytes) × 8 |
| 2 | Tamaño de bloque en bytes | Palabras por bloque × bytes por palabra |
| 3 | Número de bloques (líneas) | Capacidad / tamaño de bloque |
| 4 | Bits de índice | log₂(nº de bloques) |
| 5 | Bits de offset | log₂(bytes por bloque) |
| 6 | Bits de tag | Dirección − índice − offset |
| 7 | Bits por línea | Datos del bloque + tag + 1 (válido) [+1 dirty] |
| 8 | Tamaño total | Nº de bloques × bits por línea |

## 3. Datos clave

- 1 KiB = 1024 bytes; 1 byte = 8 bits. "16K × 8 bits" = 16 KiB.
- Potencias de 2: 2¹⁰ = 1024; 2²⁰ = 1 Mi; 2³⁰ = 1 Gi.
- Palabra de 32 bits = 4 bytes: el offset en bytes necesita 2 bits extra para elegir el byte dentro de la palabra.
- El tag se calcula sobre la dirección completa (en el enunciado, 64 bits).
- Tag = A − log₂(bloques) − log₂(bytes por bloque).

## 4. Resolución del Ejercicio 3

**Datos**: caché de datos de 16 KiB (16K × 8 bits); bloque de 4 palabras de 32 bits; direcciones de 64 bits; mapeo directo.

1. Bits de datos: 16 384 bytes × 8 = 131 072 bits.
2. Tamaño de bloque: 4 × 32 bits = 128 bits = 16 bytes.
3. Número de bloques: 16 384 / 16 = 1024 (2¹⁰).
4. Bits de índice: log₂(1024) = 10.
5. Bits de offset: log₂(16) = 4 (2 bits de palabra + 2 bits de byte).
6. Bits de tag: 64 − 10 − 4 = 50.
7. Bits por línea: 128 datos + 50 tag + 1 válido = 179.
8. Tamaño total: 1024 × 179 = **183 296 bits** (≈ 22,4 KiB).

**Desglose**: 131 072 bits de datos + 52 224 bits de overhead (1024 × 51: 50 de tag + 1 válido).

## 5. Verificación

| Componente | Cálculo | Bits |
|---|---|---|
| Datos | 1024 × 128 | 131 072 |
| Tags | 1024 × 50 | 51 200 |
| Bits válidos | 1024 × 1 | 1 024 |
| **Total** | | **183 296** |

## 6. Variantes frecuentes en parciales

- **Bit dirty** (write-back): +1 bit por línea → 1024 × 180 = 184 320 bits.
- **Direcciones de 32 bits**: tag = 32 − 14 = 18; total = 1024 × 147 = 150 528 bits.
- **Solo datos**: 131 072 bits (16 KiB).
- **Solo overhead**: 183 296 − 131 072 = 52 224 bits.
- **Bloques de 1 palabra**: offset = 2 bits; cambian el número de bloques y el tag.

## 7. Errores comunes

- Olvidar los 2 bits de byte dentro de la palabra (el offset es 4, no 2).
- Calcular el tag sin restar el índice.
- Confundir bytes con bits (16 KiB ≠ 16 Kbits) o bloques con palabras.
- Olvidar el bit válido en cada línea.
