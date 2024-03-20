calculaArea :: Float -> Float -> Float
calculaArea base altura = base*altura / 2

main = do
    print "Digite o valor da base"
    base <- getLine
    print "Digite o valor da altura"
    altura <- getLine
    print (calculaArea (read base :: Float) (read altura :: Float))