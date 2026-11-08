/*
 * workshop_array.c
 *
 * Artefacto de la parte práctica del workshop de memoria caché.
 *
 * Compilar para RISC-V y observar el assembler generado:
 *   riscv32-unknown-elf-gcc -O1 -march=rv32im -mabi=ilp32 \
 *       -S workshop_array.c -o workshop_array_gcc.s
 *
 * Modificar STEP para los experimentos de stride:
 *   STEP = 1  → acceso secuencial  (máxima localidad espacial)
 *   STEP = 4  → 1 acceso por bloque (bloque de 16 B = 4 palabras)
 *   STEP = 8  → miss garantizado en cada acceso (bloque de 16 B)
 */

#define N     64    /* número de elementos en cada array  */
#define STEP   1    /* paso entre accesos (modificar para experimentos) */

static int A[N], B[N], C[N];

int main(void)
{
    int i, suma = 0;

    /* --- inicialización --- */
    for (i = 0; i < N; i++) {
        A[i] = i + 1;
        B[i] = N - i;
    }

    /* --- kernel: C[i] = A[i] + B[i], con paso STEP --- */
    for (i = 0; i < N; i += STEP) {
        C[i] = A[i] + B[i];
        suma += C[i];
    }

    /* evitar dead-code elimination */
    return suma & 0xFF;
}
