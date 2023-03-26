# Definição no número de alunos e do número mínimo de participantes
n, k = input().split()
n = int(n)
k = int(k)

# Criação de um vetor para os horários de chegada
v = input().split()
# Quantidade de pessoas atrasadas
late = 0

for i in v:
  i = int(i)
  # Se o tempo de chegada for maior que 0, mais uma pessoa chegou atrasada
  if i > 0: late += 1

# Se o número de pessoas atrasadas for maior que a diferença entre o número total de alunos e o número de participantes, a aula não acontecerá.
if late > (n-k): print("NO")
else: print("YES")