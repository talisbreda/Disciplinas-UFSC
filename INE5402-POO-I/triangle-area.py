# To find the area of a triangle where you know the x and y coordinates of the three vertices, 
# you'll need to use the coordinate geometry formula: area = the absolute value of A
# x(By - Cy) + Bx(Cy - Ay) + Cx(Ay - By) divided by 2.

tests = int(input())

for i in range(0, tests):
    x1, y1, x2, y2, x3, y3 = input().split()
    area = int(x1) * (int(y2) - int(y3)) 
    area += int(x2) * (int(y3) - int(y1)) 
    area += int(x3) * (int(y1) - int(y2)) 
    area /= 2
    if area < 0:
        area *= -1
    print("%.3f" % (area))
