n = int(input())

for k in range (n):
    s = input().split()
    s1 = []
    printed = False
    
    for i in range (len(s)):
        if len(s[i]) in s1:
            continue
        else:
            s1.append(len(s[i]))
    
    s1.sort(reverse=True)
    for i in range (len(s1)):
        for j in range (len(s)):
            if len(s[j]) == s1[i]:
                if printed:
                    print(" %d" % (s[j]), end="")
                else:
                    print("%d" % (s[j]), end="")
                    printed = True
    print("")
# 4
# Top Coder comp Wedn at midnight
# one three five
# I love Cpp
# sj a sa df r e w f d s a v c x z sd fd
