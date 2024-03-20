case = 1
while True:

    n, m = map(int, input().split())

    if (n == 0 and m == 0): break

    nums = []

    for i in range (n):
        nums.append(int(input()))

    nums.sort()

    print("CASE# %d:" % case)
    for i in range (m):
        found = False
        a = int(input())
        size = len(nums)
        pos = size//2
        stop = 0
        ajuste = size//4
        while stop < 3:
            if nums[pos] == a:
                while (pos > 0 and nums[pos-1] == a):
                    pos -= 1
                print("%d found at %d" % (a, pos+1))
                found = True
                break
            elif nums[pos] < a:
                pos = pos + ajuste
                if pos >= len(nums):
                    pos = len(nums) - 1
            else:
                pos = pos - ajuste
                if pos < 0:
                    pos = 0
            if ajuste == 1:
                stop += 1
            ajuste = ajuste % 2 == 0 and ajuste//2 or (ajuste//2) + 1
        if not found:
            print("%d not found" % a)
    
    case += 1