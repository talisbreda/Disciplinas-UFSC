#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <omp.h>

void init_matrix(double* m, int rows, int columns) {
    #pragma omp parallel for schedule(guided)
    for (int i = 0; i < rows; ++i)
        for (int j = 0; j < columns; ++j)
            m[i*columns+j] = i + j;
}

/*
O problema está no segundo loop, da variável j. Quando é criado o primeiro loop, ele é automaticamente
paralelizado pelo OpenMP, executando corretamente. Porém, cada uma das threads que executam esse primeiro
loop criam outro loop, o que envolve o j. Como as variáveis i, j e k são declaradas fora do escopo dos loops,
essas threads acabam acessando e incrementando o valor de j simultaneamente, provocando uma condição de corrida.

A solução foi, simplesmente, paralelizar também o segundo loop. Dessa forma, o OpenMP já lida com os problemas
de condição de corrida que podem existir, criando cópias de j para cada thread e acabando com o problema anterior.

*/

void mult_matrix(double* out, double* left, double *right, 
                 int rows_left, int cols_left, int cols_right) {
    int i, j, k;
    #pragma omp parallel for schedule(dynamic, 1)
    for (i = 0; i < rows_left; ++i) {
        #pragma omp parallel for schedule(dynamic, 1)
        for (j = 0; j < cols_right; ++j) {
            out[i*cols_right+j] = 0;
            #pragma omp parallel for firstprivate(i, j) schedule(guided)
            for (k = 0; k < cols_left; ++k) 
                out[i*cols_right+j] += left[i*cols_left+k]*right[k*cols_right+j];
        }
    }
}

void print_matrix(int sz, double* c) {
    /* ~~~ imprime matriz ~~~ */
    char tmp[32];
    int max_len = 1;
    for (int i = 0; i < sz; ++i) {
        for (int j = 0; j < sz; ++j) {
            int len = sprintf(tmp, "%ld", (unsigned long)c[i*sz+j]);
            max_len = max_len > len ? max_len : len;
        }
    }
    char fmt[16];
    if (snprintf(fmt, 16, "%%s%%%dld", max_len) < 0) 
        abort();
    for (int i = 0; i < sz; ++i) {
        for (int j = 0; j < sz; ++j) 
            printf(fmt, j == 0 ? "" : " ", (unsigned long)c[i*sz+j]);
        printf("\n");
    }
}

int main (int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s tam_matriz\n", argv[0]);
        return 1;
    }
    int sz = atoi(argv[1]);
    double* a = malloc(sz*sz*sizeof(double));
    double* b = malloc(sz*sz*sizeof(double));
    double* c = calloc(sz*sz, sizeof(double));

    init_matrix(a, sz, sz);
    init_matrix(b, sz, sz);

    //          c = a * b
    print_matrix(sz, a);
    printf("\n");
    print_matrix(sz, b);
    printf("\n");
    mult_matrix(c,  a,  b, sz, sz, sz);
    print_matrix(sz, c);

    free(a);
    free(b);
    free(c);

    return 0;
}
