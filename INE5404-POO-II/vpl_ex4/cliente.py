from pessoa import Pessoa

class Cliente(Pessoa):
    def __init__(self, nome: str, codigo: int):
        super().__init__(nome, codigo)
        self.__codigo = codigo
        self.__nome = nome