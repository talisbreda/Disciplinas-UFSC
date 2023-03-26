class Cliente:

    def __init__(self, nome_, fone_) -> None:
        self.__nome = nome_
        self.__fone = fone_

    @property
    def nome(self):
        return self.__nome
    
    @nome.setter
    def nome(self, nome):
        self.__nome = nome

    @property
    def fone(self):
        return self.__fone
    
    @fone.setter
    def fone(self, fone):
        self.__fone = fone