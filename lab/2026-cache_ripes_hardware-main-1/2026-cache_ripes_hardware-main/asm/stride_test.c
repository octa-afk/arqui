/*
 * stride_test.c
 *
 * Evalúa el efecto del stride de acceso sobre el miss rate de la caché.
 * Modificar STEP para los experimentos de stride:
 *
 *   STEP = 1  → acceso a A[0], A[1], A[2], ...         (1 miss / 4 accesos con bloque 16B)
 *   STEP = 4  → acceso a A[0], A[4], A[8], ...         (1 miss / 1 acceso con bloque 16B)
 *   STEP = 8  → acceso a A[0], A[8], A[16], ...        (miss garantizado, bloque 16B)
 *   STEP = 16 → acceso a A[0], A[16], A[32], ...       (miss garantizado, bloque 16B o 32B)
 *
 * Generar assembly para cargar en RIPES:
 *   make stride_test_gcc.s           (usar el Makefile de este directorio)
 *
 * Equivalente manual:
 *   riscv64-unknown-elf-gcc -O1 -march=rv32im -mabi=ilp32 \
 *       -S stride_test.c -o stride_test_gcc.s
 *
 * Con N=128 y tres arrays A, B, C:
 *   - Total datos: 3 × 128 × 4 = 1536 bytes
 *   - Bloque 16B (4 words): STEP=1 → MR ≈ 25%; STEP=4 → MR ≈ 100%
 */

#define N    128   /* número de elementos en cada array */
#define STEP   1   /* stride entre accesos consecutivos (modificar para experimentos) */

static int A[N];
static int B[N];
static int C[N];

int main(void)
{
    int i, suma = 0;

    /* --- inicialización secuencial (STEP=1 siempre) --- */
    for (i = 0; i < N; i++) {
        A[i] = i + 1;
        B[i] = N - i;
    }

    /* --- kernel con stride STEP: C[i] = A[i] + B[i] --- */
    for (i = 0; i < N; i += STEP) {
        C[i] = A[i] + B[i];
        suma += C[i];
    }

    return suma & 0xFF;   /* evita dead-code elimination */
}
