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
        multijogador = False
    else:
        multijogador = True

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

# Tratamento de espaços entre palavras
while ' ' in letrasEncontradas:
    l = letrasEncontradas.index(' ')
    saida[l] = ' '
    letrasEncontradas[l] = '*'


# Transformando em string e printando o template vazio 
r = ''.join(saida)
print(forca[0])
print(r)

# Status de cada jogador: vidas perdidas, progresso atual e letras encontradas
status = {'Jogador 1': [0, list(r), letrasEncontradas.copy()], 'Jogador 2': [0, list(r), letrasEncontradas.copy()]}

# Função para mostrar turno dos jogadores, e tratar a letra inserida
def jogar(jogador):
    print("Vez de %s" % jogador)
    print("Progresso atual: %s" % (''.join(status[jogador][1])))

    letra = input().lower()
    chance = status[jogador][0]

    status[jogador] = substituirLetras(jogador, letra, chance)

    chance = status[jogador][0]

    # atualizar o template com a última tentativa
    print(forca[chance])
    print(jogador)
    r = ''.join(status[jogador][1])

    if chance < 8: 
        print(r)
        print("")

    if status[jogador][1] == list(palavra):
        print("Parabéns, %s!" % (jogador))

# Função que contabiliza a letra inserida caso ela existe, ou tira uma vida do jogador caso ela não exista
def substituirLetras(jogador, letra, chance):
    restante = status[jogador][2]
    completo = status[jogador][1]
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
    jogar(jogadorDaVez)

    # Se o modo multijogador foi escolhido, dá a vez para o próximo jogador
    if multijogador:    
        if jogadorDaVez == 'Jogador 1': jogadorDaVez = 'Jogador 2'
        else: jogadorDaVez = 'Jogador 1'