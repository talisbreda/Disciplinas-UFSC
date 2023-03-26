# Exercício 7

v = [1, 2, 3, 4, 5]
soma = 0
multi = 1
for i in v:
    soma += i
    multi *= i

print(soma)
print(multi)
print(' '.join(str(i) for i in v))