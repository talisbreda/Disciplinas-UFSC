while True:
    try:
        # Criação de uma string para cada trecho da carta
        v = [None] * 4
        v[0] = input()
        v[1] = input()
        v[2] = input()
        v[3] = input()
        
        # Criação de strings de saída para cada trecho da carta decodificada
        out = [""] * 4
        
        # Checagem de cada uma das cartas para descriptografar
        for i in range (4):
            for j in range (len(v[i])):
                if v[i][j] == "@": out[i] += "a"
                elif v[i][j] == "&": out[i] += "e"
                elif v[i][j] == "!": out[i] += "i"
                elif v[i][j] == "*": out[i] += "o"
                elif v[i][j] == "#": out[i] += "u"
                else: out[i] += v[i][j]
        for i in out:
            print(i)
    except EOFError:
        break