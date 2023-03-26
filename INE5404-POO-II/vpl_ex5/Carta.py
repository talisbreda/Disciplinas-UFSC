from Personagem import *

class Carta():

    def __init__(self, personagem: Personagem):
        self.__personagem = personagem
    
    def valor_total_carta(self) -> int:
        soma = self.__personagem.energia
        soma += self.__personagem.habilidade
        soma += self.__personagem.resistencia
        soma += self.__personagem.velocidade
        soma += self.__personagem.tipo.value
        return soma

    @property
    def personagem(self) -> Personagem:
        return self.__personagem
