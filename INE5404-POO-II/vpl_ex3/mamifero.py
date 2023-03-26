from abc import ABC, abstractmethod
from animal import Animal

class Mamifero(Animal):
    @abstractmethod
    def __init__(self, volume_som:int, tamanho_passo:int) -> None:
        self.__volume_som = volume_som
        self.__tamanho_passo = tamanho_passo
        super().__init__(tamanho_passo)
    
    @property
    def volume_som(self) -> int:
        return self.__volume_som

    @volume_som.setter
    def volume_som(self, volume_som) -> None:
        self.__volume_som = volume_som
    
    def mover(self) -> str:
        return super().mover()

    def produzir_som(self):
        if self.__class__.__name__ == "Cachorro":
            som = 'AU'
        elif self.__class__.__name__ == "Gato":
            som = 'MIAU'
        return "MAMIFERO: PRODUZ SOM: %d SOM: %s" % (self.__volume_som, som)