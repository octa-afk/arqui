# ej_conflictos.s
#
# Workshop: Memoria Caché — Arquitectura de Computadoras II
#
# Objetivo: observar cómo cambia el hit/miss al variar la asociatividad
# cuando cuatro accesos caen siempre en el mismo set.
#
# ============================================================
# Configuración de caché en RIPES (Memory -> Cache settings)
# ============================================================
#
#   Capacidad total: 256 B | Bloque: 16 B | b = 4 bits
#
#   Configuración          Ways  Lines  Words/Line
#   ─────────────────────────────────────────────
#   Mapeo Directo (DM)       1     16       4
#   2-Way Set Associative    2      8       4
#   4-Way Set Associative    4      4       4
#   Totalmente Asociativa   16      1       4
#
# ============================================================
# ¿Por qué los 4 accesos siempre caen en el mismo set?
# ============================================================
#
#   Las direcciones A, B, C, D están separadas 256 B entre sí.
#   256 B = capacidad total de la caché.
#   La función de mapeo es: set_index = (dir / B) mod S
#   Como el stride es igual a la capacidad, el índice siempre es 0.
#
#   → DM   (S=16): (0 mod 16)=0, (16 mod 16)=0, (32 mod 16)=0 ...
#   → 2Way (S= 8): (0 mod  8)=0, (16 mod  8)=0, (32 mod  8)=0 ...
#   → 4Way (S= 4): (0 mod  4)=0, (16 mod  4)=0, (32 mod  4)=0 ...
#
# ============================================================
# Resultado esperado (8 accesos: A B C D A B C D)
# ============================================================
#
#   DM   (1 vía):  8 misses, 0 hits  — thrashing total
#   2Way (2 vías): 8 misses, 0 hits  — aun insuficiente (4 bloques, 2 vías)
#   4Way (4 vías): 4 misses, 4 hits  — caben los 4 bloques juntos
#
# ============================================================

.data
.align 8              # alinea bloque a 256 B (2^8), garantiza que A = base múltiplo de 256
bloque: .zero 1024    # reserva 1024 B: suficiente para los 4 accesos + holgura

.text
.globl main
main:
    la   t0, bloque

    # ── Primera vuelta: A, B, C, D ─────────────────────────
    lw   t1, 0(t0)    # A: bloque + 0x000  → compulsory miss
    lw   t1, 256(t0)  # B: bloque + 0x100  → compulsory miss
    lw   t1, 512(t0)  # C: bloque + 0x200  → compulsory miss
    lw   t1, 768(t0)  # D: bloque + 0x300  → compulsory miss

    # ── Segunda vuelta: A, B, C, D ─────────────────────────
    lw   t1, 0(t0)    # A de nuevo → HIT si 4-way, MISS si DM o 2-way
    lw   t1, 256(t0)  # B de nuevo → HIT si 4-way, MISS si DM o 2-way
    lw   t1, 512(t0)  # C de nuevo → HIT si 4-way, MISS si DM o 2-way
    lw   t1, 768(t0)  # D de nuevo → HIT si 4-way, MISS si DM o 2-way

    li   a7, 10
    ecall              # fin del programa (syscall exit)
