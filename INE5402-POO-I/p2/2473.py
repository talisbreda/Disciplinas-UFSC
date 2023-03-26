# Uma lista para a aposta de Flavinho, outra para o resultado do sorteio
bet = input().split()
result = input().split()

# Quantidade de números que Flavinho acertou
corrects = 0

for i in range (6):
    for j in range (6):
        # Para cada número da aposta de Flavinho, confere se ele é igual a qualquer um dos números sorteados
        if bet[j] == result[i]: 
            # Caso for igual, adiciona um ao número de acertos
            corrects += 1

# Imprime o resultado de acordo com a quantidade de acertos
if corrects == 3: print("terno")
elif corrects == 4: print("quadra")
elif corrects == 5: print("quina")
elif corrects == 6: print("sena")
else: print("azar")
