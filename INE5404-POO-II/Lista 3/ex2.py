# Exercício 2
d = {}
stopwords = set(open(r'C:/Users/talis/OneDrive/Área de trabalho/Workspace/Python/POO II/Lista 3/stopwords.txt', encoding='UTF-8').read().split())
text = open(r'C:/Users/talis/OneDrive/Área de trabalho/Workspace/Python/POO II/Lista 3/input.txt', encoding='UTF-8').read().split()
    
for word in text:
    if word in d:
        d[word] += 1
    else:
        d[word] = 1

keys = list(d.keys())

for i in keys:
    if i in stopwords:
        del d[i]
    else:
        print("%s: %d" % (i, d[i]))