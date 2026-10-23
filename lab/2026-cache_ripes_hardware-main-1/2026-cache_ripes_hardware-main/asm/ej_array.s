# ej_array.s
#
# Ejercicio RIPES: workshop de memoria caché.
# Implementa C[i] = A[i] + B[i] con paso configurable.
#
# Cargar en RIPES: File -> Load program -> ej_array.s
# Procesador: Single-Cycle RV32IM
#
# Para los experimentos de la parte práctica, modificar STEP:
#   li t6, 1   -> secuencial:  A[0], A[1], A[2], A[3], ...
#   li t6, 4   -> stride-4:    A[0], A[4], A[8], A[12], ...
#   li t6, 8   -> stride-8:    A[0], A[8], A[16], ...
#
# Con bloque de 16 B (4 palabras), stride-1 aprovecha el bloque completo,
# stride-4 genera 1 miss por bloque, stride>=4 genera miss en cada acceso.

.data
.align 4            # alinear A a 16 bytes (un bloque de caché de 16 B)
A: .space 256       # array A: 64 enteros de 32 bits = 256 bytes
B: .space 256       # array B
C: .space 256       # array C (resultados)

.text
.globl main
main:

    # -------------------------------------------------------
    # Inicialización: A[i] = i+1, B[i] = 64-i
    # -------------------------------------------------------
    la   s0, A
    la   s1, B
    li   t5, 64         # límite: N = 64 elementos
    li   t4, 0          # i = 0

init_loop:
    beq  t4, t5, compute
    slli t0, t4, 2          # byte offset = i * 4
    add  t1, s0, t0         # &A[i]
    add  t2, s1, t0         # &B[i]
    addi t3, t4, 1
    sw   t3, 0(t1)          # A[i] = i + 1
    sub  t3, t5, t4
    sw   t3, 0(t2)          # B[i] = 64 - i
    addi t4, t4, 1
    j    init_loop

    # -------------------------------------------------------
    # Kernel: C[i] = A[i] + B[i]
    #
    # MODIFICAR EL VALOR DE t6 PARA CAMBIAR EL STEP:
    #   li t6, 1  -> acceso secuencial  (STEP = 1)
    #   li t6, 4  -> stride de 4 palabras (STEP = 4)
    #   li t6, 8  -> stride de 8 palabras (STEP = 8)
    # -------------------------------------------------------
compute:
    la   s0, A
    la   s1, B
    la   s2, C
    li   t5, 64             # límite de índice (N = 64)
    li   t4, 0              # i = 0
    li   t6, 1              # <<< STEP: modificar aquí para el experimento
    li   s3, 0              # acumulador (evita dead-code elimination)

loop:
    bge  t4, t5, done       # si i >= 64, terminar
    slli t0, t4, 2          # byte offset = i * 4
    add  t1, s0, t0         # &A[i]
    add  t2, s1, t0         # &B[i]
    add  t3, s2, t0         # &C[i]
    lw   a0, 0(t1)          # a0 = A[i]
    lw   a1, 0(t2)          # a1 = B[i]
    add  a2, a0, a1
    sw   a2, 0(t3)          # C[i] = A[i] + B[i]
    add  s3, s3, a2         # acumular resultado (anti dead-code)
    add  t4, t4, t6         # i += STEP
    j    loop

done:
    li   a7, 10
    ecall                   # exit (RIPES syscall 10)
