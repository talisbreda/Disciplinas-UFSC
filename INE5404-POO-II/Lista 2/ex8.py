# Exercício 8

pessoas = [()] * 5
for i in range (5):
    idade = int(input())
    altura = int(input())
    pessoas[i] = (idade, altura)

for i in range (4, -1, -1):
    print("Idade: %d, altura: %d" % (pessoas[i][0], pessoas[i][1]))