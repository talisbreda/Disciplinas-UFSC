# Exercício 5

par = []
impar = []
v = []
for i in range (5):
    a = input()
    v.append(a)
    if int(a) % 2 == 0:
        par.append(a)
    else:
        impar.append(a)

print(' '.join(v))
print(' '.join(par))
print(' '.join(impar))