from datetime import date

day, month = input().split()
date1 = date(2022, int(month), int(day))
day, month = input().split()
date2 = date(2022, int(month), int(day))

diff = date2 - date1
print(diff.days)