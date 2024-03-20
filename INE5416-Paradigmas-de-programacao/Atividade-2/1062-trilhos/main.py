while True:
    n = int(input())
    if (n == 0): break
    trem = [i for i in range(1, n+1)]

    orgs = []
    while True:
        orgInput = input().split()
        if (orgInput[0] == "0"): break
        orgs.append([int(i) for i in orgInput])

    for org in orgs:
        ptrem = 0
        porg = 0
        station = []
        while True:
            if (len(station) > 0 and station[-1] == org[porg]):
                station.pop()
                porg += 1
            elif (trem[ptrem] == org[porg]):
                ptrem += 1
                porg += 1
            else:
                station.append(trem[ptrem])
                ptrem += 1
            
            if (ptrem == n and porg == n and len(station) == 0):
                print("Yes")
                break
                
            if (len(station) > 0 and station[-1] != org[porg] and ptrem == n):
                print("No")
                break
    print()
            
