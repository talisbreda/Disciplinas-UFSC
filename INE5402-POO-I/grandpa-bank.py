days, balance = input().split()
days = int(days)
balance = int(balance)
lowestValue = balance

for i in range (0, days):
    movement = int(input())
    balance += movement
    if balance < lowestValue:
        lowestValue = balance

print(lowestValue)