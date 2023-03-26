# A entrada é composta de vários casos de teste, cada um correspondendo a uma 
# partida entre Aldo e Beto. A primeira linha de um caso de teste contém um número 
# inteiro R (1 ≤ R ≤ 1000) que indica quantas rodadas ocorreram na partida. Cada uma 
# das R linhas seguintes contém dois inteiros, A e B (0 ≤ A, B ≤ 100), que correspondem, 
# respectivamente, ao número de figurinhas que Aldo e Beto conseguiram virar naquela rodada. 
# Em todos os casos de teste há um único vencedor (ou seja, não ocorre empate). O final da entrada 
# é indicado por R = 0.

# Saída
# Para cada caso de teste da entrada, seu programa deve produzir três linhas na saída. 
# A primeira linha deve conter um identificador do caso de teste, no formato “Teste n”, onde 
# n é numerado seqüencialmente a partir de 1. A segunda linha deve conter o nome do vencedor 
# (Aldo ou Beto). A terceira linha deve ser deixada em branco. A grafia mostrada no Exemplo de 
# Saída, abaixo, deve ser seguida rigorosamente.

# Exemplo de Entrada	Exemplo de Saída

# 2
# 1 5
# 2 3
# 3
# 0 0
# 4 7
# 10 0
# 0

# Teste 1
# Beto

# Teste 2
# Aldo
testeNum = 1

while True:

    rounds = int(input())
    if rounds == 0:
        break
    cont = 0
    aldo = 0
    beto = 0 

    while cont < rounds:
        a, b = input().split()
        aldo += int(a)
        beto += int(b)
        cont += 1
    cont = 0

    print("Teste", (testeNum))
    testeNum += 1

    if aldo > beto:
        print("Aldo")
    elif beto > aldo:
        print("Beto")
    aldo = 0
    beto = 0

    print("")