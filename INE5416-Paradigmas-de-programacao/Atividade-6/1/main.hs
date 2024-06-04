type Nome = String
type Disciplina = String
type Nota = Float
type Aluno = (Nome, Disciplina, Nota, Nota, Nota)
type Notas = (Nota, Nota, Nota)

aluno :: Int -> Aluno
aluno 1 = ("Joao", "SO", 4, 5, 6)
aluno 2 = ("Pedro", "ES", 7, 9, 8)
aluno 3 = ("Bianca", "Calculo", 6, 4, 10)
aluno 4 = ("Amanda", "ED", 10, 9, 9)
aluno 5 = ("Jonas", "Org", 6, 7, 10)

notas :: Nota -> Nota -> Nota -> Notas
notas a b c = (a, b, c)

getNome :: Aluno -> String
getNome (nome, _, _, _, _) = nome

calculaMedia :: Notas -> Nota
calculaMedia (a, b, c) = (a+b+c)/3

getNotas :: Aluno -> Notas
getNotas (_, _, a, b, c) = notas a b c

getMedia :: Int -> Float
getMedia n = calculaMedia ( getNotas ( aluno n ) )

calculaMediaTurma :: Int -> Nota
calculaMediaTurma x = ( getMedia (x) + calculaMediaTurma(x-1) )
calculaMediaTurma 1 = getMedia 5

main = do
    let indice = 3
    print (getNome (aluno indice))
    print ( getMedia indice )
    print ( calculaMediaTurma 1 )