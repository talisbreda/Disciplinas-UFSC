xor :: Bool -> Bool -> Bool
xor a b | (a && not b) = True
        | (b && not a) = True
        | otherwise = False

convertToBool :: Int -> Bool
convertToBool a | (a == 1) = True
                | otherwise = False

main = do
    print "Digite o primeiro booleano (0 ou 1)"
    a <- getLine
    print "Digite o segundo booleano (0 ou 1)"
    b <- getLine

    let boolA = convertToBool (read a :: Int)
    let boolB = convertToBool (read b :: Int)

    print (xor boolA boolB)


