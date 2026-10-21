# ej_localidad.s
#
# Workshop: Memoria Caché — Arquitectura de Computadoras II
#
# Objetivo: comparar el miss rate al recorrer un array con
# acceso SECUENCIAL vs acceso con STRIDE grande.
#
# ============================================================
# Configuración de caché en RIPES (Memory -> Cache settings)
# ============================================================
#
#   Ways=1  Lines=16  Words/Line=4
#   → Mapeo directo, capacidad 256 B, bloque 16 B
#
# ============================================================
# Experimentos
# ============================================================
#
#   STRIDE = 1 → lw a0, 0(t1)  lw a0, 4(t1)  lw a0, 8(t1) ...
#               acceso secuencial: cada bloque cargado se usa 4 veces
#               miss rate ≈ 25%
#
#   STRIDE = 4 → lw a0, 0(t1)  lw a0, 16(t1)  lw a0, 32(t1) ...
#               salta un bloque entero en cada acceso
#               miss rate ≈ 100%
#
#   Modificar la constante STRIDE (li t6) para cambiar el experimento.
#
# ============================================================

.data
.align 4
array: .space 256     # 64 enteros de 32 bits = 256 B (llena la caché)

.text
.globl main
main:
    # ── Inicializar array: array[i] = i + 1 ───────────────
    la   s0, array
    li   t4, 0          # i = 0
    li   t5, 64         # N = 64 elementos

init:
    bge  t4, t5, run
    slli t0, t4, 2      # offset = i * 4
    add  t1, s0, t0
    addi t2, t4, 1
    sw   t2, 0(t1)      # array[i] = i + 1
    addi t4, t4, 1
    j    init

    # ── Kernel: suma = sum(array[i]) con STRIDE ───────────
run:
    la   s0, array
    li   t4, 0          # i = 0
    li   t5, 64         # límite
    li   s1, 0          # acumulador

    # <<< MODIFICAR AQUÍ para el experimento >>>
    li   t6, 1          # STRIDE = 1  → acceso secuencial (miss rate bajo)
    # li   t6, 4        # STRIDE = 4  → salta bloques    (miss rate alto)

loop:
    bge  t4, t5, done
    slli t0, t4, 2      # offset = i * 4
    add  t1, s0, t0
    lw   a0, 0(t1)      # carga array[i]
    add  s1, s1, a0     # acumula
    add  t4, t4, t6     # i += STRIDE
    j    loop

done:
    mv   a0, s1         # resultado en a0 (visible en registros de RIPES)
    li   a7, 10
    ecall
