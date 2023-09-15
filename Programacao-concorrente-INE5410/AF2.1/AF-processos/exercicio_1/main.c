#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>

//       (pai)      
//         |        
//    +----+----+
//    |         |   
// filho_1   filho_2


// ~~~ printfs  ~~~
// pai (ao criar filho): "Processo pai criou %d\n"
//    pai (ao terminar): "Processo pai finalizado!\n"
//  filhos (ao iniciar): "Processo filho %d criado\n"

// Obs:
// - pai deve esperar pelos filhos antes de terminar!


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
            if (pid) {
                printf("Processo pai criou %d\n", pid);
                fflush(stdout);
            } else {
                printf("Processo filho %d criado\n", getpid());
                fflush(stdout);
                exit(0);
            }
        }
    }
    while(wait(NULL) > 0);
    printf("Processo pai finalizado!\n");   
    return 0;
}
