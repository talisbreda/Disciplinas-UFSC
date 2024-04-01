fibonacci :: Int -> Int
fibonacci x = if (x == 0 || x == 1) then x else fibonacci (x-1) + fibonacci (x-2)

main = do
    print "Digite um numero"
    x <- getLine

    print (fibonacci (read x :: Int))