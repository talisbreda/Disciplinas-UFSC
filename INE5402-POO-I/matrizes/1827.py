while True:
    try:
        n = int(input())

        mat = [0] * n
        for i in range (n):
            mat[i] = [0] * n
        
        for i in range (n):
            for j in range (n):
                if i == j: mat[i][j] = 2
                if i == n-j-1: 
                    if mat[i][j] == 2: mat[i][j] = 4
                    else: mat[i][j] = 3
        
        for i in range (int(n/3), n-int(n/3)):
            for j in range (int(n/3), n-int(n/3)):
                if mat[i][j] != 4: mat[i][j] = 1
                   
        
        for i in range (n):
            for j in range (n):
                print(mat[i][j], end="")
            print("")
        print("")


    except EOFError: break