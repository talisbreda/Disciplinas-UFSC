# Exercício 10

a = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
b = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
c = []
for i in range (10):
    c.append(b[i])
    c.append(a[i])

print(' '.join(str(i) for i in c))