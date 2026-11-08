/*
 * matrix_row_col.c
 *
 * Demuestra el efecto del orden de acceso (fila vs. columna) sobre la caché.
 * En C, las matrices 2D se almacenan en row-major order: M[i][0], M[i][1], ...
 * son contiguos en memoria. Recorrer por columnas implica un stride de N*4 bytes.
 *
 * Generar assembly para cargar en RIPES:
 *   make matrix_row_col_gcc.s        (usar el Makefile de este directorio)
 *
 * Equivalente manual:
 *   riscv64-unknown-elf-gcc -O1 -march=rv32im -mabi=ilp32 \
 *       -S matrix_row_col.c -o matrix_row_col_gcc.s
 *
 * Observar en RIPES con L1-D Cache habilitada (4-Way, Line=4 words, LRU):
 *   - fill():    secuencial, miss rate bajo
 *   - row_sum(): secuencial, miss rate bajo   (localidad espacial alta)
 *   - col_sum(): stride = N*4 = 32 bytes      (localidad espacial baja)
 *
 * Con N=8: matriz de 8×8 = 64 enteros = 256 bytes
 */

#define N 8   /* dimensión de la matriz cuadrada NxN */

static int M[N][N];

static void fill(void)
{
    int i, j;
    for (i = 0; i < N; i++)
        for (j = 0; j < N; j++)
            M[i][j] = i * N + j + 1;
}

/* Recorrido fila por fila: M[0][0], M[0][1], ..., M[1][0], M[1][1], ...
 * Stride entre accesos consecutivos = 4 bytes (un entero) → localidad alta */
static int row_sum(void)
{
    int i, j, s = 0;
    for (i = 0; i < N; i++)
        for (j = 0; j < N; j++)
            s += M[i][j];
    return s;
}

/* Recorrido columna por columna: M[0][0], M[1][0], ..., M[0][1], M[1][1], ...
 * Stride entre accesos consecutivos = N*4 = 32 bytes → localidad baja */
static int col_sum(void)
{
    int i, j, s = 0;
    for (j = 0; j < N; j++)
        for (i = 0; i < N; i++)
            s += M[i][j];
    return s;
}

int main(void)
{
    fill();
    int r = row_sum();
    int c = col_sum();
    return r - c;   /* debe ser 0; evita dead-code elimination */
}
