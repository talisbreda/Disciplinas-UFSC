sensorNumber, capacity = input().split()
sensorNumber = int(sensorNumber)
capacity = int(capacity)
exceeded = False
people = 0;
cont = 0

while cont < sensorNumber:
    leave, enter = input().split()
    leave = int(leave)
    enter = int(enter)
    people -= leave
    people += enter

    if people > capacity:
        exceeded = True

    cont += 1

if exceeded:
    print("S")
else:
    print("N")