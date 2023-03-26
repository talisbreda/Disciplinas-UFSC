# -*- coding: utf-8 -*-
import random
import unicodedata

# A progressão das falhas
forca = [
    ''' 
     ______
    |      |
    |     
    |      
    |      
    |      
    |
    |
   _|_
    ''',
    ''' 
     ______
    |      |
    |     ( )
    |      
    |      
    |      
    |
    |
   _|_
    ''',
    ''' 
     ______
    |      |
    |     ( )
    |      |
    |      |
    |      |
    |
    |
   _|_
    ''',
    ''' 
     ______
    |      |
    |     ( )
    |    __|
    |      |
    |      |
    |
    |
   _|_
    ''',
    ''' 
     ______
    |      |
    |     ( )
    |    __|__
    |      |
    |      |
    |
    |
   _|_
    ''',
    ''' 
     ______
    |      |
    |     ( )
    |    __|__
    |      |
    |      |
    |     /
    |    /
   _|_
    ''',
    ''' 
     ______
    |      |
    |     ( )
    |    __|__
    |      |
    |      |
    |     / \\
    |    /   \\
   _|_
    ''',
    ''' 
     ______
    |      |
    |    (* *)
    |    __|__
    |      |
    |      |
    |     / \\
    |    /   \\
   _|_
    ''',
    '''
    ---GAME OVER---
    '''
    ]

lista_palavras = ['amarelo', 'amiga', 'amor', 'ave', 'bolo', 'branco', 'cama', 'caneca', 'celular', 'clube', 'copo', 'doce', 'elefante', 'escola', 'estojo', 'faca', 'foto', 'garfo', 'geleia', 'girafa', 'janela', 'limonada', 'meia', 'noite', 'ovo', 'pai', 'parque', 'passarinho', 'peixe', 'pijama', 'rato', 'umbigo']

while True:
    print("____JOGO DA FORCA____")
    print("1 - 1 jogador")
    print("2 - 2 jogadores")
    escolha = input()

    if escolha == '1':
        multiplayer = False
    else:
        multiplayer = True

    print("1 - palavra aleatória")
    print("2 - escolher palavra")
    escolha = input()

    if escolha == "1":
        n = random.randint(0,31)
        palavra = lista_palavras[n]
        break
    elif escolha == "2":
        print("escreva a palavra:")
        palavra = input()
        break
    else:
        continue

def removerAcentos(s):
   return ''.join(c for c in unicodedata.normalize('NFD', s)
                  if unicodedata.category(c) != 'Mn')

palavra = removerAcentos(palavra)
palavra = palavra.lower()
letrasEncontradas = list(palavra)
c = len(palavra)
saida = ['_']*c

# estabelecendo o critério para mais de uma palavra
while ' ' in letrasEncontradas:
    l = letrasEncontradas.index(' ')
    saida[l] = ' '
    letrasEncontradas[l] = '*'


# transformando em string e printando o template vazio 
r = ''.join(saida)
print(forca[0])
print(r)

status = {'Jogador 1': [0, list(r), letrasEncontradas.copy()], 'Jogador 2': [0, list(r), letrasEncontradas.copy()]}

def play(player):
    print("Vez de %s" % player)
    print("Progresso atual: %s" % (''.join(status[player][1])))
    letra = input().lower()
    chance = status[player][0]
    status[player] = swapLetters(player, letra, chance)
    chance = status[player][0]

    # atualizar o template com a última tentativa
    print(forca[chance])
    print(player)
    r = ''.join(status[player][1])

    if chance < 8: 
        print(r)
        print("")

    if status[player][1] == list(palavra):
        print("Parabéns, %s!" % (player))

def swapLetters(player, letra, chance):
    restante = status[player][2]
    completo = status[player][1]
    if letra in palavra:

        # após verificar quantas vezes a letra aparece, substituir '_' pela letra
        while letra in restante:
            l = restante.index(letra)
            completo[l] = letra
            restante[l] = '*'
    else: 
        chance += 1

    return[chance, completo, restante]

jogadorDaVez = 'Jogador 1'

# critérios para continuar o jogo
while (status['Jogador 1'][1] != list(palavra) and status['Jogador 2'][1] != list(palavra)) and (status['Jogador 1'][0] < 8 and status['Jogador 2'][0] < 8):
    play(jogadorDaVez)

    if multiplayer:    
        if jogadorDaVez == 'Jogador 1': jogadorDaVez = 'Jogador 2'
        else: jogadorDaVez = 'Jogador 1'