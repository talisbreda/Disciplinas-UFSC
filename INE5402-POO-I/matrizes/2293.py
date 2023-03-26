while True:
    try:
        n, m = input().split()
        n = int(n)
        m = int(m)
    
        mat = [None] * n
        for i in range (n):
            mat[i] = input().split()
    
        done = False
        xpos = ""
        out = ""
        direct = ""
    
        for i in range (n):
            for j in range (m):
                if mat[i][j] == 'X':
                    xpos = str(i)+str(j)
                    break
                
        while not done:
            
            if xpos[0] != '0':
                if mat[int(xpos[0])-1][int(xpos[1])] == '0': 
                    mat[int(xpos[0])][int(xpos[1])] = '1'
                    mat[int(xpos[0])-1][int(xpos[1])] = 'X'
                    xpos = str(int(xpos[0])-1) + xpos[1]
                    if direct == "L":
                        out += "L F "
                    elif direct == "R":
                        out += "R F "
                    else: out += "F "
                    direct = "B"
                    continue
            if xpos[1] != '0':
                if mat[int(xpos[0])][int(xpos[1])-1] == '0': 
                    mat[int(xpos[0])][int(xpos[1])] = '1'
                    mat[int(xpos[0])][int(xpos[1])-1] = 'X'
                    xpos = str(int(xpos[0])) + str(int(xpos[1])-1)
                    if direct == "R":
                        out += "F "
                    elif direct == "B":
                        out += "L F "
                    else: out += "R F "
                    direct = "R"
                    continue
            if int(xpos[0]) != n-1:
                if mat[int(xpos[0])+1][int(xpos[1])] == '0': 
                    mat[int(xpos[0])][int(xpos[1])] = '1'
                    mat[int(xpos[0])+1][int(xpos[1])] = 'X'
                    xpos = str(int(xpos[0])+1) + xpos[1]
                    
                    if direct == "L":
                        out += "R F "
                    elif direct == "R":
                        out += "L F "
                    else: out += "F "
                    direct = "F"
                    continue
            if int(xpos[1]) != m-1:        
                if mat[int(xpos[0])][int(xpos[1])+1] == '0': 
                    mat[int(xpos[0])][int(xpos[1])] = '1'
                    mat[int(xpos[0])][int(xpos[1])+1] = 'X'
                    xpos = str(int(xpos[0])) + str(int(xpos[1])+1)
                    
                    if direct == "L":
                        out += "F "
                    elif direct == "B":
                        out += "R F "
                    else: out += "L F "
                    direct = "L"
                    continue
            out += "E"
            done = True
    
        print(out)
    except EOFError: break