o = input()

# Variável para checar se foi encontrado um 1 seguido de 3
mala = False

for i in range (len(o) - 1):
  # Checagem do valor de i e de i+1, para encontrar 1 seguido de 3
  if o[i] == "1" and o[i+1] == "3":
    # Caso seja encontrada a sequência, imprime a saída, muda a variável mala e quebra o loop
    print("%d es de Mala Suerte" % (int(o)))
    mala = True
    break

# Caso a sequência não tenha sido encontrada, imprime outra saída
if not mala:
  print("%d NO es de Mala Suerte" % (int(o)))