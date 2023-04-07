// Copyright 2023 Tális Breda
// (1) cria um vetor de Alunos a partir de nomes e matriculas:
// Aluno *turma(string nomes[], int matriculas[], int N);

// Exemplo:

// vetor de nomes: ['Fulano', 'Beltrano', 'Cicrano']
// vetor de matriculas: [1010, 2020, 3030]
// vetor t alocado de saída:
// [{'Fulano',1010}, {'Beltrano',2020}, {'Cicrano':3030}]

#include <string>

class Aluno {
 public:
    Aluno() {}  // construtor
    ~Aluno() {}  // destrutor
    std::string devolveNome() {
        return nome;
    }
    int devolveMatricula() {
        return matricula;
    }
    void escreveNome(std::string nome_) {
        nome = nome_;
    }
    void escreveMatricula(int matricula_) {
        matricula = matricula_;
    }
 private:
    std::string nome;
    int matricula;
};

Aluno *turma(std::string nomes[], int matriculas[], int N) {
    Aluno *alunos = new Aluno[N];
    for (int i = 0; i < N; i++) {
        alunos[i].escreveMatricula(matriculas[i]);
        alunos[i].escreveNome(nomes[i]);
    }
    return alunos;
}

/*
(2) cria um novo vetor contendo outros dois vetores de alunos (acrescenta vetor 2 apos o vetor 1); exemplo:
t1 de estrada: [{'Fulano',1010}, {'Beltrano',2020}];  N1 = 2
t2 de entrada: [{'Fulana',7070}, {'Beltrana',8080}, {'Cicrana',9090}];  N2 = 3
tu de saída: [{'Fulano',1010}, {'Beltrano',2020}, {'Fulana',7070}, {'Beltrana',8080}, {'Cicrana':9090}]
*/
Aluno *turmas_uniao(Aluno t1[], Aluno t2[], int N1, int N2) {
    Aluno *tu = new Aluno[N1+N2];

    for (int i = 0; i < N1; i++) {
        tu[i] = t1[i];
    }

    for (int i = 0; i < N2; i++) {
        tu[N1+i] = t2[i];
    }

    return tu;
}

/*
(3) divide uma turma t existente em duas outras (os conteúdos dos ponteiros pt1 e pt2 serão as duas saídas; inicialmente são iguais a 'nullptr'), a primeira com k elementos e a segunda com o restante (N-k elementos); exemplo:
t de entrada: [{'Fulano',1010}, {'Beltrano',2020}, {'Fulana',7070}, {'Beltrana',8080}, {'Cicrana':9090}]
k = 2
conteudo de pt1: [{'Fulano',1010}, {'Beltrano',2020}]
conteudo de pt2: [{'Fulana',7070}, {'Beltrana',8080}, {'Cicrana',9090}]
*/
void turmas_divisao(Aluno t[], int k, int N, Aluno **pt1, Aluno **pt2) {
    Aluno *t1 = new Aluno[k];
    Aluno *t2 = new Aluno[N-k];

    for (int i = 0; i < k; i++) {
        t1[i] = t[i];
    }
    for (int j = 0; j < N-k; j++) {
        t2[j] = t[k+j];
    }

    *pt1 = t1;
    *pt2 = t2;
}
