import random

# Classe que contém apenas um dicionário das cartas disponíveis. Quando uma carta é selecionada, ela é retirada desta dict
# Um jogo pode usar mais de um baralho
class Baralho:
    def __init__(self) -> None:
        self.__dict = {
            'Espada': ['A', '2', '3', '4', '5', '6', '7', "8", "9", '10', 'J', 'Q', 'K'],
            'Copas': ['A', '2', '3', '4', '5', '6', '7', "8", "9", '10', 'J', 'Q', 'K'],
            'Paus': ['A', '2', '3', '4', '5', '6', '7', "8", "9", '10', 'J', 'Q', 'K'],
            'Ouros': ['A', '2', '3', '4', '5', '6', '7', "8", "9", '10', 'J', 'Q', 'K']
        }
    
    def getDict(self):
        return self.__dict
    
    def setDict(self, dict):
        self.__dict = dict

# Classe que contém o naipe e o valor da carta, além do baralho ao qual ela pertence
class Carta:
    def __init__(self, baralho:Baralho) -> None:
        self.__baralho = baralho
        (naipe, valor) = self.definirValor()
        self.__naipe = naipe
        self.__valor = valor

    # Função que define aleatoriamente o valor da carta criada
    def definirValor(self):
        dict = self.__baralho.getDict()
        naipe = random.choice(list(dict.keys()))
        valor = str(random.randint(0, 13))

        while valor not in dict[naipe]:
            naipe = random.choice(list(dict.keys()))
            valor = str(random.randint(0, 13))
        
        dict[naipe].remove(valor)
        return (naipe, valor)
    
    def descartar(self):
        dict = self.__baralho.getDict()
        dict[self.__naipe].append(self.__valor)
        self.__baralho.setDict(dict)
    
    def getAtributos(self):
        return (self.__naipe, self.__valor)
    
    def __str__(self) -> str:
        return "%s de %s" % (str(self.__valor), self.__naipe)


            

def main():
    # Distribuir uma quantidade de cartas para os jogadores
    def distribuirCartas(quantidade, jogadores:list[dict], baralho):
        for i in range (len(jogadores)):
            for j in range (quantidade):
                carta = Carta(baralho)
                (naipe, valor) = carta.getAtributos()
                if naipe in jogadores[i]:
                    jogadores[i][naipe].append(valor)
                else:
                    jogadores[i][naipe] = [valor]
        return


    print("Insira a quantidade de jogadores da partida")
    a = int(input())

    print("Insira a quantidade de cartas que cada jogador recebe")
    n = int(input())

    # A dict jogadores guarda dicionários, cada um contendo as cartas que o respectivo jogador tem em mãos
    jogadores = []
    for i in range(a):
        jogadores.append({})
    baralho1 = Baralho()

    distribuirCartas(n, jogadores, baralho1)

    # Imprime na tela as cartas de cada jogador
    for i in range (len(jogadores)):
        print("\nJogador %d:" % (i+1))
        for j in jogadores[i]:
            print("%s: " % (j), end='')
            s = ' '.join(jogadores[i][j])
            print(s)

if __name__ == "__main__":
    main()
