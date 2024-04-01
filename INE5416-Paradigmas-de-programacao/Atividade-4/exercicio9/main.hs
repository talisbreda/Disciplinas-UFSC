distance :: Float -> Float -> Float -> Float -> Float -> Float -> Float
distance x1 y1 z1 x2 y2 z2 = sqrt ((x2-x1)^^2 + (y2-y1)^^2 + (z2-z1)^^2)

main = do
    print "Digite x1"
    x1 <- getLine
    print "Digite y1"
    y1 <- getLine
    print "Digite z1"
    z1 <- getLine
    print "Digite x2"
    x2 <- getLine
    print "Digite y2"
    y2 <- getLine
    print "Digite z2"
    z2 <- getLine

    print (distance (read x1 :: Float) (read y1 :: Float) (read z1 :: Float) (read x2 :: Float) (read y2 :: Float) (read z2 :: Float))