size = int(input())
pieces = 1

while size >= 2:
    size /= 2
    pieces *= 4
print(pieces)