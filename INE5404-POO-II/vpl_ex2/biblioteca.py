from livro import Livro
from editora import Editora
from autor import Autor
from capitulo import Capitulo
class Biblioteca:
    def __init__(self) -> None:
        self.__livros = []

    def incluirLivro(self, livro:Livro) -> None:
        if livro not in self.__livros and isinstance(livro, Livro):
            self.__livros.append(livro)
            print(self.__livros)
    
    def excluirLivro(self, livro:Livro) -> None:
        if isinstance(livro, Livro):
            for i in self.__livros:
                if i.codigo == livro.codigo and i.titulo == livro.titulo:
                    print(self.__livros)
                    self.__livros.remove(livro)
                    print(self.__livros)
    
    @property
    def livros(self) -> list:
        return self.__livros