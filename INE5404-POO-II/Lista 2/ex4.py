# Exercício 4

v = ['a', 't', 'r', 'f', 'c', 'u', 'r', 'i', 'd', 'a']
cont = 0
for i in v:
    letra = i.lower()
    if letra != 'a' and letra != 'e' and letra != 'i' and letra != 'o' and letra != 'u':
        cont += 1

print(cont)