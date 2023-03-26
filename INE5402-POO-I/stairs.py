# Entrada
# A primeira linha da entrada contém um inteiro N que indica o número de pessoas que o sensor 
# detectou (1 ≤ N ≤ 1.000). As N linhas seguintes representam o instante em que a n-ésima pessoa 
# passou pelo sensor e contém um inteiro T (0 ≤ T ≤ 10.000). Os tempos estão em ordem crescente, 
# sem repetições.

# Salida
# Seu programa deve imprimir uma única linha, contendo o tempo que a escada rolante ficou ligada.

# 3     30
# 0
# 10
# 20

# 5     35
# 5
# 10
# 17
# 20
# 30

# 3     12
# 1
# 2
# 3

people = int(input())
cont = 0
time = 0
lastInstant = 10

while cont < people:   
    instant = int(input())
    if cont == 0:
        time += 10
    if cont != 0:
        time += instant - lastInstant
    lastInstant = instant
    cont += 1

print(time)