/*
 * cache_size_test.c
 *
 * Permite distinguir misses compulsorios (1era pasada sobre el array)
 * de misses de capacidad (2da pasada, cuando el working set supera la caché).
 *
 * Ajustar N para controlar el tamaño del working set:
 *   N=32  → working set = 128 bytes  (cabe en caché de 256B)
 *   N=64  → working set = 256 bytes  (límite de una caché de 256B)
 *   N=128 → working set = 512 bytes  (desborda una caché de 256B)
 *   N=256 → working set = 1024 bytes (desborda incluso 512B)
 *
 * Generar assembly para RIPES:
 *   make cache_size_test_gcc.s
 */

#define N 128   /* modificar para ajustar el working set */

static int A[N];

int main(void)
{
    int i, s1 = 0, s2 = 0;

    /* inicialización: acceso secuencial, primera escritura a cada elemento */
    for (i = 0; i < N; i++)
        A[i] = i + 1;

    /* Primera pasada de lectura: misses compulsorios puros */
    for (i = 0; i < N; i++)
        s1 += A[i];

    /* Segunda pasada: hits si A cabe en caché, misses de capacidad si no */
    for (i = 0; i < N; i++)
        s2 += A[i];

    return (s1 + s2) & 0xFF;  /* evita dead-code elimination */
}
