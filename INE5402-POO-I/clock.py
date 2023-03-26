while True:
    try:
        hourAngle, minuteAngle = input().split()
        hourAngle = int(hourAngle)
        minuteAngle = int(minuteAngle)

        hour = hourAngle / 30
        minute = minuteAngle / 6

        print("%0.2d:%0.2d" % (hour, minute))
    except EOFError:
        break