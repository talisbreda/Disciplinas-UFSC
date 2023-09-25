#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>

//                          (principal)
//                               |
//              +----------------+--------------+
//              |                               |
//           filho_1                         filho_2
//              |                               |
//    +---------+-----------+          +--------+--------+
//    |         |           |          |        |        |
// neto_1_1  neto_1_2  neto_1_3     neto_2_1 neto_2_2 neto_2_3

// ~~~ printfs  ~~~
//      principal (ao finalizar): "Processo principal %d finalizado\n"
// filhos e netos (ao finalizar): "Processo %d finalizado\n"
//    filhos e netos (ao inciar): "Processo %d, filho de %d\n"

// Obs:
// - netos devem esperar 5 segundos antes de imprmir a mensagem de finalizado (e terminar)
// - pais devem esperar pelos seu descendentes diretos antes de terminar
void cria_processo_filho(int count, pid_t parentPid) {
    for (int i = 0; i < count; i++) {
        if (getpid() == parentPid) {
            pid_t pid = fork();
            if (pid == 0) {
                printf("Processo %d, filho de %d\n", getpid(), getppid());
                fflush(stdout);
                sleep(5);
                printf("Processo %d finalizado\n", getpid());
                fflush(stdout);
                exit(0);
            }
        }
    }
}

int main(int argc, char** argv) {

    // ....

    /*************************************************
     * Dicas:                                        *
     * 1. Leia as intruções antes do main().         *
     * 2. Faça os prints exatamente como solicitado. *
     * 3. Espere o término dos filhos                *
     *************************************************/
    pid_t parentPid = getpid();
    for (int i = 0; i < 2; i++) {
        if (getpid() == parentPid) {
            pid_t pid = fork();
            if (pid == 0) {
                printf("Processo %d, filho de %d\n", getpid(), getppid());
                fflush(stdout);
                cria_processo_filho(3, getpid());
                wait(NULL);
                printf("Processo %d finalizado\n", getpid());
                fflush(stdout);
                exit(0);
            }
        }
    }
    while(wait(NULL) > 0);
    printf("Processo principal %d finalizado!\n", parentPid);   
    fflush(stdout);
    return 0;
}
