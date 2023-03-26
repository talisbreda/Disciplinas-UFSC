while True:
        
    n = int(input())
    
    if n == 0: break
    
    d = {}
    v = tuple(map(int, input().split()))
    for i in v:
        try:
            d[i] += 1
        except:
            d[i] = 1
    for i in d.keys():
        if d[i] % 2 != 0:
            print(i)
            break