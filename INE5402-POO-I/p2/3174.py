# Número de elfos/gnomos
n = int(input())

# Quantidade de presentes
gifts = 0

# Quantidade total de horas
musicos = 0
arquitetos = 0
bonecos = 0
desenhistas = 0

for i in range (n):
  name, job, h = input().split()
  h = int(h)
  # Checagem de qual o trabalho e respectivos cálculos que determinam quantos presentes são produzidos
  if job == "bonecos":
    # O valor de h é adicionado à variável que armazena as horas daquele trabalho
    bonecos += h
    # Enquanto um trabalho tiver 8 horas ou mais, um presente será produzido
    while bonecos >= 8:
      bonecos -= 8
      gifts += 1
  if job == "arquitetos":
    arquitetos += h
    while arquitetos >= 4:
      arquitetos -= 4
      gifts += 1
  if job == "musicos":
    musicos += h
    while musicos >= 6:
      musicos -= 6
      gifts += 1
  if job == "desenhistas":
    desenhistas += h
    while desenhistas >= 12:
      desenhistas -= 12
      gifts += 1

print(gifts)