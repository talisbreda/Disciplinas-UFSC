n = int(input())

# Número de carrinhos e de bonecas
cars = 0
dolls = 0

for i in range (n):
    name, s = input().split()
    # Se for um menino, adiciona um carrinho
    if s == "F": dolls += 1
    # Se for uma menina, adiciona uma boneca
    elif s == "M": cars += 1

print("%d carrinhos" % (cars))
print("%d bonecas" % (dolls))