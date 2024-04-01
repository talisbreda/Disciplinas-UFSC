exponencial :: Int -> Int -> Int
exponencial x y = x ^ y

main = do
    print "Digite a base"
    x <- getLine
    print "Digite o expoente"
    y <- getLine
    print (exponencial (read x :: Int) (read y :: Int))

