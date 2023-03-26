n = int(input())

# Criação de um vetor de tamanho n+1 e preenchimento com 0
v = [None] * (n+1)
for i in range (1,n+1):
    v[i] = 0

# Criação de outro vetor para os valores de entrada
v1 = input().split()

# Para cada valor no vetor de entrada, altera o valor do vetor de zeros para o próprio valor
for i in v1:
    i = int(i)
    v[i] = i

# Procura uma posição no primeiro vetor cujo valor é 0, e imprime essa posição, que corresponde à peça que não foi encontrada
for i in range (n+1):
    if v[i] == 0: 
        print(i)
        break