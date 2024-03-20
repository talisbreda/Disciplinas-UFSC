absolute :: Int -> Int
absolute x = if x < 0 then -x else x

main = do
    print "Digite um numero"
    x <- getLine
    print (absolute (read x :: Int))