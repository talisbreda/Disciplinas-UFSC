#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <pthread.h>

// Lê o conteúdo do arquivo filename e retorna um vetor E o tamanho dele
// Se filename for da forma "gen:%d", gera um vetor aleatório com %d elementos
//
// +-------> retorno da função, ponteiro para vetor malloc()ado e preenchido
// | 
// |         tamanho do vetor (usado <-----+
// |         como 2o retorno)              |
// v                                       v
double* load_vector(const char* filename, int* out_size);


// Avalia o resultado no vetor c. Assume-se que todos os ponteiros (a, b, e c)
// tenham tamanho size.
void avaliar(double* a, double* b, double* c, int size);

typedef struct Range {
    int start;
    int end;
    double* v1;
    double* v2;
    double* v3;
} Range;

typedef struct Distribution {
    int valor;
    int indiceTroca;
} Distribution;

void* worker(void* arg) {
    Range* range = (Range*)arg;
    for (int i = range->start; i < range->end; i++) {
        range->v3[i] = range->v1[i] + range->v2[i];
    }
    return NULL;
}

Distribution distributeThreads(int n_threads, int a_size) {
    int resto = n_threads % a_size;
    Distribution d;
    d.valor = n_threads / a_size;
    if (resto == 0) {
        d.indiceTroca = -1;
        return d;
    }
    d.indiceTroca = a_size - resto;
    return d;
}

int main(int argc, char* argv[]) {
    // Gera um resultado diferente a cada execução do programa
    // Se **para fins de teste** quiser gerar sempre o mesmo valor
    // descomente o srand(0)
    srand(time(NULL)); //valores diferentes
    //srand(0);        //sempre mesmo valor

    //Temos argumentos suficientes?
    if(argc < 4) {
        printf("Uso: %s n_threads a_file b_file\n"
               "    n_threads    número de threads a serem usadas na computação\n"
               "    *_file       caminho de arquivo ou uma expressão com a forma gen:N,\n"
               "                 representando um vetor aleatório de tamanho N\n",
               argv[0]);
        return 1;
    }
  
    //Quantas threads?
    int n_threads = atoi(argv[1]);
    if (!n_threads) {
        printf("Número de threads deve ser > 0\n");
        return 1;
    }
    //Lê números de arquivos para vetores alocados com malloc
    int a_size = 0, b_size = 0;
    double* a = load_vector(argv[2], &a_size);
    if (!a) {
        //load_vector não conseguiu abrir o arquivo
        printf("Erro ao ler arquivo %s\n", argv[2]);
        return 1;
    }
    double* b = load_vector(argv[3], &b_size);
    if (!b) {
        printf("Erro ao ler arquivo %s\n", argv[3]);
        return 1;
    }
    
    //Garante que entradas são compatíveis
    if (a_size != b_size) {
        printf("Vetores a e b tem tamanhos diferentes! (%d != %d)\n", a_size, b_size);
        return 1;
    }
    //Cria vetor do resultado 
    double* c = malloc(a_size*sizeof(double));

    // Calcula com uma thread só. Programador original só deixou a leitura 
    // do argumento e fugiu pro caribe. É essa computação que você precisa 
    // paralelizar

    pthread_t threads[n_threads];
    Range* ranges[n_threads];
    Distribution d = distributeThreads(n_threads, a_size);
    for (int i = 0; i < n_threads; i++) {
        Range* range = (Range*)malloc(sizeof(Range));
        if (d.indiceTroca == i) {
            d.valor++;
        }
        range->start = i * d.valor;
        range->end = (i + 1) * d.valor;
        range->v1 = a;
        range->v2 = b;
        range->v3 = c;
        ranges[i] = range;
        pthread_create(&threads[i], NULL, worker, (void*)range);
    }
    for (int i = 0; i < n_threads; i++) {
        pthread_join(threads[i], NULL);
        free(ranges[i]);
    }

    // for (int i = 0; i < a_size; ++i) 
    //     c[i] = a[i] + b[i];

    //    +---------------------------------+
    // ** | IMPORTANTE: avalia o resultado! | **
    //    +---------------------------------+
    avaliar(a, b, c, a_size);
    

    //Importante: libera memória
    free(a);
    free(b);
    free(c);

    return 0;
}
