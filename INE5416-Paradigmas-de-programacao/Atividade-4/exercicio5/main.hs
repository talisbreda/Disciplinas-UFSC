calculaMedia :: Float -> Float -> Float -> String
calculaMedia n1 n2 n3 = if ((n1+n2+n3)/3 >= 6.0) then "Aprovado" else "Reprovado"

main = do
    print "Digite a primeira nota"
    n1 <- getLine
    print "Digite a segunda nota"
    n2 <- getLine
    print "Digite a terceira nota"
    n3 <- getLine

    print (calculaMedia (read n1 :: Float) (read n2 :: Float) (read n3 :: Float))
