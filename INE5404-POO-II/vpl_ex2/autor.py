class Autor:
    def __init__(self, codigo:int, nome:str) -> None:
        self.__codigo = codigo
        self.__nome = nome

    @property
    def codigo(self) -> int:
        return self.__codigo
    
    @codigo.setter
    def codigo(self, codigo:int) -> None:
        self.__codigo = codigo
    
    @property
    def nome(self) -> str:
        return self.__nome
    
    @nome.setter
    def nome(self, nome:str) -> None:
        self.__nome = nome