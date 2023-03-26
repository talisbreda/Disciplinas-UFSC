from abc import abstractmethod
from animal import Animal

class Ave(Animal):
    @abstractmethod
    def __init__(self, tamanho_passo: int, altura_voo: int) -> None:
        self.__tamanho_passo = tamanho_passo
        self.__altura_voo = altura_voo
        super().__init__(tamanho_passo)
    
    @property
    def altura_voo(self) -> int:
        return self.__altura_voo
    
    @altura_voo.setter
    def altura_voo(self, altura_voo) -> None:
        self.__altura_voo = altura_voo
    
    def mover(self) -> str:
        return ("ANIMAL: DESLOCOU %d VOANDO" % (self.__tamanho_passo))
    
    def produzir_som(self) -> str:
        return "AVE: PRODUZ SOM: PIU"