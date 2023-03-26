tests = int(input())

for i in range(0, tests):
    x, y, u, v = input().split()
    if int(x) > int(u):
        if int(y) > int(v):
            # x,y top right / u, v bottom left
        elif int(y) < int(v):
            # x,y bottom right / u,v top left