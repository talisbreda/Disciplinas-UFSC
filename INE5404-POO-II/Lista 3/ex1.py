# Exercício 1
d = {}
text = open(r'C:/Users/talis/OneDrive/Área de trabalho/Workspace/Python/POO II/Lista 3/input.txt', encoding='UTF-8').read().split()
    
for word in text:
    if word in d:
        d[word] += 1
    else:
        d[word] = 1

for i in d:
    print("%s: %d" % (i, d[i]))