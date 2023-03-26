from elevadorCheioException import ElevadorCheioException
from elevadorJahNoTerreoException import ElevadorJahNoTerreoException
from elevadorJahNoUltimoAndarException import ElevadorJahNoUltimoAndarException
from elevadorJahVazioException import ElevadorJahVazioException


class Elevador():
    def __init__(self, capacidade, totalPessoas, totalAndares, andarAtual):
        self.__capacidade = capacidade
        self.__totalAndares = totalAndares
        self.__totalPessoas = totalPessoas
        self.__andarAtual = andarAtual

    
    def descer(self) -> str:
        if self.__andarAtual <= 0:
            raise ElevadorJahNoTerreoException
        else:
            self.__andarAtual -= 1
            return "Andar atual: %d" % (self.__andarAtual)
    
    
    def entraPessoa(self) -> str:
        if self.__totalPessoas >= self.__capacidade:
            raise ElevadorCheioException
        else:
            self.__totalPessoas += 1
            return "Pessoas no elevador: %d" % (self.__totalPessoas)
    
    
    def saiPessoa(self) -> str:
        if self.__totalPessoas <= 0:
            raise ElevadorJahVazioException
        else:
            self.__totalPessoas -= 1
            return "Pessoas no elevador: %d" % (self.__totalPessoas)
    
    
    def subir(self) -> str:
        if self.__andarAtual >= self.__totalAndares-1:
            raise ElevadorJahNoUltimoAndarException
        else:
            self.__andarAtual += 1
            return "Andar atual: %d" % (self.__andarAtual)
    
    @property
    def capacidade(self) -> int:
        return self.__capacidade

    @property
    def totalPessoas(self) -> int:
        return self.__totalPessoas
    
    @property
    def totalAndaresPredio(self) -> int:
        return self.__totalAndares
    
    @property
    def andarAtual(self) -> int:
        return self.__andarAtual
