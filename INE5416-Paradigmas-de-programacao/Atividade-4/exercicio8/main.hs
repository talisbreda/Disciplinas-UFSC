bhaskaraP :: Float -> Float -> Float -> Float
bhaskaraP a b delta = (-b + sqrt (delta)) / 2*a

bhaskaraN :: Float -> Float -> Float -> Float
bhaskaraN a b delta = (-b - sqrt (delta)) / 2*a

getDelta :: Float -> Float -> Float -> Float
getDelta a b c = b^^2 - 4*a*c

main = do
    print "Digite o primeiro coeficiente"
    aStr <- getLine
    print "Digite o segundo coeficiente"
    bStr <- getLine
    print "Digite o terceiro coeficiente"
    cStr <- getLine

    let a = read aStr :: Float
    let b = read bStr :: Float
    let c = read cStr :: Float

    let delta = getDelta a b c
    if delta >= 0 then do
        let x1 = bhaskaraP a b delta
        let x2 = bhaskaraN a b delta
        putStrLn ("Resultado: " ++ show x1 ++ " e " ++ show x2)
    else 
        print "Nao ha resultados reais para essa equacao"