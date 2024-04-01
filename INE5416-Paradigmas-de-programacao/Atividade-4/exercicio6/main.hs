canBuild :: Int -> Int -> Int -> String
canBuild a b c = if (a+b>c && a+c>b && b+c>a) then "true" else "false"

main = do
    print "Digite a medida do primeiro lado"
    a <- getLine
    print "Digite a medida do segundo lado"
    b <- getLine
    print "Digite a medida do terceiro lado"
    c <- getLine

    print(canBuild (read a :: Int) (read b :: Int) (read c :: Int))