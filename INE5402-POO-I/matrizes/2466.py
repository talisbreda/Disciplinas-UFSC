while True:
    l, c, p = input().split()
    l = int(l)
    c = int(c)
    p = int(p)-1
    
    if l == 0 and c == 0 and p == -1: 
        break
    
    mat = [None] * l
    for i in range (l):
        mat[i] = input().split()

    
    v1 = 0
    v2 = 0
    printed = False
    
    for i in range (l):
        if int(mat[i][p]) > 0: 
            print("BOOM %d %d" % (i,p+1))
            printed = True
            break
        
        for j in range (p, -1, -1):
            if int(mat[i][j]) > 0: v1 = int(mat[i][j])
        for j in range (p, c):
            if int(mat[i][j]) > 0: v2 = int(mat[i][j])
        
        p += v1-v2

        if v1-v2 < mat[i].index(str(v1)) - mat[i].index(str(v2)):
            if v1-v2 < 0:
                print("BOOM %d %d" % (i+1, p+1))
            else:
                print("BOOM %d %d" % (i+1, p+1))
            printed = True
            break

    if not printed: print("OUT %d" % (p+1))
            
