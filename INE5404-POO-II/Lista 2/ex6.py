# Exercício 6

soma = 0
medias = []
for i in range (10):
    notas = list(map(int, input().split()))
    for nota in notas:
        soma += nota
    medias.append(soma/4)
    soma = 0

cont = 0
for i in medias:
    if i >= 7:
        cont += 1

print(cont)