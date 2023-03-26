from Model.Personagem import Personagem
from Singleton.Animacao import Animacao
from View.Sprite import Sprite
from DAO.PersonagemDAO import PersonagemDAO
from DAO.JogoDAO import JogoDAO
import random as random
from View.Tela import Tela

class BatalhaModel:
    def __init__(self, tela:Tela, inimigos:list[Personagem]) -> None:

        self.__personagemSelecionado = None
        self.__personagensDAO = PersonagemDAO()

        self.__aliados = self.__personagensDAO.get_all()
        self.__inimigos = inimigos
        
        self.__nivel = JogoDAO().get()

        w, h = tela.display.get_size()

        self.__posicoesPersonagens = [
            (w/5, h/5 + h/10), 
            (w/10, h/2), 
            (w/5, h/2 + h/5),
            (w - w/5, h/5 + h/10), 
            (w - w/10, h/2), 
            (w - w/5, h/2 + h/5)
        ]

        self.__posicoesSlots = [
            (600, 850), (650, 850), (700, 850), (750, 850),
            (800, 850), (850, 850), (900, 850), (950, 850)
        ]

        self.__setPosicoes()

        self.__spritesAliados = [i.sprite for i in self.__aliados]
        self.__spritesInimigos = [i.sprite for i in self.__inimigos]
        self.__habilidades: list[Sprite] = []

    def __setPosicoes(self):
        i = 0
        for aliado in self.__aliados:
            aliado.posicao = self.__posicoesPersonagens[i]
            i += 1
        for inimigo in self.__inimigos:
            inimigo.posicao = self.__posicoesPersonagens[i]
            i += 1
        
    def ataque(self, atacante: Personagem, alvo: Personagem, index: int):
        dano = atacante.atacar(index, alvo.sprite.posicao)
        if Animacao().fase == 2:
            alvo.defender(dano)
    
    def inimigoAtaca(self):
        atacante = self.selecionaPersonagem(self.__inimigos)
        alvo = self.selecionaPersonagem(self.__aliados)
        index = random.randint(0, len(atacante.habilidades)-1)
        Animacao().inicia(atacante, alvo, index)
        self.ataque(atacante, alvo, index)
        
        return atacante.habilidades[index].projetil

    def checaVencedor(self):
        cont = 0
        for aliado in self.__aliados:
            if aliado.saude > 0:
                cont += 1
        if cont == 0:   
            return 'enemies'
        cont = 0
        for inimigo in self.__inimigos:
            if inimigo.saude > 0:
                cont += 1
        if cont == 0:
            JogoDAO().add(self.__nivel + 1)
            return 'allies'
        
        return ''
    
    def reset(self):
        for inimigo in self.__inimigos:
            inimigo.reset()

    def evoluiAliados(self, nivel:int):
        for aliado in self.__aliados:
            aliado.fim_da_batalha(nivel)
            self.__personagensDAO.add(aliado)

    def selecionaPersonagem(self, personagens: list[Personagem]):
        personagem = random.choice(personagens)
        while personagem.saude <= 0:
            personagem = random.choice(personagens)
        
        return personagem
    
    def personagemClicado(self, posicao:list[int]):
        for index, aliado in enumerate(self.__spritesAliados):
            cond = posicao is not None
            cond = cond and aliado.rect.collidepoint(posicao)
            cond = cond and self.__aliados[index].saude > 0
            if cond:
                self.__personagemSelecionado = self.__aliados[index]
                habilidades = self.__aliados[index].habilidades
                habilidades = [i.projetil for i in habilidades]
                self.__habilidades = habilidades
                return habilidades
        
    def habilidadeClicada(self, posicao:list[int]):
        for index, sprite in enumerate(self.__habilidades):
            if posicao is not None and sprite.rect.collidepoint(posicao):
                alvo = self.selecionaPersonagem(self.__inimigos)
                if self.__personagemSelecionado.saude > 0:
                    Animacao().inicia(self.__personagemSelecionado, alvo, index)
                    self.ataque(self.__personagemSelecionado, alvo, index)

    
    @property
    def posicoesSlots(self):
        return self.__posicoesSlots
    
    @property
    def posicoesPersonagens(self):
        return self.__posicoesPersonagens
    
    @property
    def nivel(self):
        return self.__nivel

    @property
    def aliados(self):
        return self.__aliados
    
    @property
    def inimigos(self):
        return self.__inimigos
    
    @property
    def spritesAliados(self):
        return self.__spritesAliados
    
    @property
    def spritesInimigos(self):
        return self.__spritesInimigos

    @property
    def habilidades(self):
        if self.__personagemSelecionado is not None:
            habil = self.__personagemSelecionado.habilidades
            skills = [i.projetil for i in habil]
            return skills
