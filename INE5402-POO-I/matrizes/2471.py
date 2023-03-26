n = int(input())

v = [None] * n
mat = [None] * n
m = [0] * n
soma = 0
pos = [0, 0]
value = 0
for i in range (n):
    mat[i] = input().split()
    m[i] = [0] * n

for i in range (n):
    for j in range (n):
        mat[i][j] = int(mat[i][j])
        
for i in range (n):
    for j in range (n):
        soma += mat[i][j]
    if soma in v:
        value = soma
        soma = 0
        break
    else:
        v[i] = soma
        soma = 0
        
for i in range (n):
    for j in range (n):
        soma += mat[i][j]
        
    if soma != value:
        pos[0] = i
    soma = 0
    
    for j in range (n):
        m[j][i] = mat[i][j]

for i in range (n):    
    for j in range (n):
        soma += m[i][j]
    if soma != value:
        pos[1] = i
    soma = 0 
    
for i in range (n):
    soma += mat[pos[0]][i]

fake = mat[pos[0]][pos[1]]
    
print("%d %d" % (fake + (value - soma), fake))
    

# for i in range (n):
#     print(mat[i])
# print("")
# for i in range (n):
#     print(m[i])