from editora import Editora
from autor import Autor
from capitulo import Capitulo

class Livro:
    def __init__(self, codigo:int, titulo:str, ano:int, autor:Autor, editora:Editora, numeroCapitulo:int, tituloCapitulo:str) -> None:
        self.__codigo = codigo
        self.__titulo = titulo
        self.__ano = ano
        self.__editora = editora
        self.__autores = [autor]
        self.__capitulo = [Capitulo(numeroCapitulo, tituloCapitulo)]

    @property
    def codigo(self) -> int:
        return self.__codigo
    
    @codigo.setter
    def codigo(self, codigo:int) -> None:
        self.__codigo = codigo
    
    @property
    def titulo(self) -> str:
        return self.__titulo
    
    @titulo.setter
    def titulo(self, titulo:str) -> None:
        self.__titulo = titulo
    
    @property
    def ano(self) -> int:
        return self.__ano
    
    @ano.setter
    def ano(self, ano:int) -> None:
        self.__ano = ano
    
    @property
    def editora(self) -> Editora:
        return self.__editora
    
    @editora.setter
    def editora(self, editora:Editora) -> None:
        if isinstance(editora, Editora):
            self.__editora = editora
    
    @property
    def autores(self) -> list:
        return self.__autores
     
    @property
    def capitulo(self) -> list:
        return self.__capitulo
    
    def incluirAutor(self, autor:Autor) -> None:
        if isinstance(autor, Autor):
            for i in self.__autores:
                if i.nome == autor.nome or i.codigo == autor.codigo:
                    return
            self.__autores.append(autor)

    def excluirAutor(self, autor:Autor) -> None:
        if autor in self.__autores:
            self.__autores.remove(autor)

    def incluirCapitulo(self, numero:int, tituloCapitulo:str) -> None:
        for capitulo in self.__capitulo:
            if capitulo.titulo == tituloCapitulo:
                return
        self.__capitulo.append(Capitulo(numero, tituloCapitulo))

    def excluirCapitulo(self, tituloCapitulo:str) -> None:
        for capitulo in self.__capitulo:
            if capitulo.titulo == tituloCapitulo:
                self.__capitulo.remove(capitulo)
                break
    
    def findCapituloByTitulo(self, tituloCapitulo:str) -> Capitulo:
        for capitulo in self.__capitulo:
            if capitulo.titulo == tituloCapitulo:
                return capitulo
def main():
    a1 = Autor(5, 'e')
    a2 = Autor(6, 'r')
    a3 = Autor(7, 'g')
    a4 = Autor(8, 'd')
    e1 = Editora(3, 'a')
    l1 = Livro(1, 'rrr', 2, a1, e1, 4, 'ff')
    print(l1.ano)
    print(l1.autores)
    print(l1.capitulo)
    print(l1.codigo)
    print(l1.editora)
    print(l1.titulo)
    l1.incluirAutor(a2)
    l1.incluirAutor(a3)
    l1.incluirAutor(a4)
    l1.excluirAutor(a1)
    l1.titulo = 'c'
    for i in l1.autores:
        print(i.nome)

if __name__ == "__main__":
    main()