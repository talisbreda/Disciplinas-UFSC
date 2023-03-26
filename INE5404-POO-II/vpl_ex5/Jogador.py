from Carta import *


class Jogador():

    def __init__(self, nome: str):
        self.__nome = nome
        self.__cartas = []

    @property
    def nome(self) -> str:
        return self.__nome

    
    def baixa_carta_da_mao(self) -> Carta:
        carta = self.__cartas.pop()
        return carta

    
    @property
    def mao(self) -> list:
        return self.__cartas

    
    def inclui_carta_na_mao(self, carta:Carta):
        if isinstance(carta, Carta):
            self.__cartas.append(carta)
