class Livro:
    def __init__(self, titulo, autores:list, ano, editora, edicao, volume) -> None:
        self.__titulo = titulo
        self.__autores = autores
        self.__ano = ano
        self.__editora = editora
        self.__edicao = edicao
        self.__volume = volume
    
    def __str__(self) -> str:
        out = '\n'
        out += "Título: %s" % (self.__titulo)
        out += '\nAutor(es): '
        out += ', '.join(self.__autores)
        out += "\nAno: %s, Editora %s, %sª ed, vol %s" % (self.__ano, self.__editora, self.__edicao, self.__volume)
        return out
    
# O dicionário titulos guarda instâncias da classe Livro, usando como chave o próprio título do livro
titulos = {}
# O dicionário nomes guarda os títulos, usando como chave os nomes dos autores
nomes = {}
print("Bem vindo à biblioteca!")

# Loop principal do programa
while True:
    a = input("\nInsira 1 se quiser cadastrar um livro, 2 se quiser procurar um livro, ou 3 se quiser sair\n")

    if a == '1':
        titulo = input("Insira o título do livro\n")
        autores = input("Insira o(s) nome(s) do(s) autor(es) do livro separados por vírgula, caso haja mais de um\n").split(',')
        ano = int(input("Insira o ano em que o livro foi publicado\n"))
        editora = input("Insira o nome da editora\n")
        edicao = int(input("Insira a edição do livro\n"))
        volume = int(input("Insira volume do livro\n"))

        # Insere a nova instância no dicionário
        titulos[titulo] = Livro(titulo, autores, ano, editora, edicao, volume)

        # Coloca o título em mais de uma chave do dicionário, caso o livro tenha mais de um autor
        for i in autores:
            if i in nomes:
                nomes[i].append(titulos[titulo])
            else:
                nomes[i] = [titulos[titulo]]

        print("%s cadastrado com sucesso!" % (titulo))
        print("")

    elif a == '2':
        b = input("Insira uma palavra-chave\n")

        # Caso o item procurado esteja no dicionário dos autores, mostra todos os detalhes dos livros daquele autor cadastrados na biblioteca
        if b in nomes:
            livros = nomes[i]
            for livro in livros:
                print(livro)
        
        # Caso o item esteja no dicionário dos títulos, mostra os detalhes do mesmo
        elif b in titulos:
            print(titulos[b])
            
    elif a == '3':
        break