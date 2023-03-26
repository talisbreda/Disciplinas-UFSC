class CategoriaProduto:

    def __init__(self, titulo_) -> None:
        self.__titulo = titulo_
    
    @property
    def titulo(self):
        return self.__titulo
    
    @titulo.setter
    def titulo(self, titulo):
        self.__titulo = titulo