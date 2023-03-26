from comandoInvalidoException import ComandoInvalidoException
from elevador import Elevador

class ControladorElevador():
    def __init__(self) -> None:
        # self.inicializarElevador(0, 2, 2, 0)
        pass
    
    '''
    Faz o elevador subir um andar. Se jah estiver no ultimo andar, dispara excecao
    @return Mensagem informando o que ocorreu com o elevador 
    @throws ElevadorJahNoUltimoAndarException 
    '''
    def subir(self) -> str:
        return self.__elevador.subir()
    
    '''
    Faz o elevador descer um andar. Se jah estiver no terreo, dispara excecao
    @return Mensagem informando o que ocorreu com o elevador
    @throws ElevadorJahNoTerreoException
    '''
    def descer(self) -> str:
        return self.__elevador.descer()

    '''
    Entra uma pessoa no Elevador. Se nao for possivel permitir a entrada da pessoa, dispara excecao
    @return Mensagem informando o que ocorreu com o elevador
    @throws ElevadorCheioException
    '''
    def entraPessoa(self) -> str:
        return self.__elevador.entraPessoa()
	
    '''
    Sai uma pessoa no Elevador. Se nao for possivel permitir a saida de uma pessoa, dispara excecao
    @return Mensagem informando o que ocorreu com o elevador
    @throws ElevadorJahVazioException
    '''
    def saiPessoa(self) -> str:
        return self.__elevador.saiPessoa()
	
    '''
    @return Elevador
    '''
    @property
    def elevador(self) -> Elevador:
        return self.__elevador

    '''
    @param andarAtual andar atual do elevador
    @param totalAndaresPredio total de andares do predio
    @param capacidade capacidade maxima do elevador
    @param totalPessoas total de pessoas atual do elevador
    ''' 
    def inicializarElevador(self, andarAtual: int, totalAndaresPredio: int, capacidade: int, totalPessoas: int):
        try:
            andarAtual = int(andarAtual)
            totalAndaresPredio = int(totalAndaresPredio)
            capacidade = int(capacidade)
            totalPessoas = int(totalPessoas)
        except:
            raise ComandoInvalidoException

        if andarAtual >= 0 and andarAtual < totalAndaresPredio and totalPessoas >= 0 and totalPessoas <= capacidade and capacidade >= 0 and totalAndaresPredio > 0:
            self.__elevador = Elevador(capacidade, totalPessoas, totalAndaresPredio, andarAtual)
        else:
            raise ComandoInvalidoException

a = ControladorElevador()
a.inicializarElevador(0, 4, 2, 0)
print(a.entraPessoa())
print(a.entraPessoa())
print(a.subir())
print(a.subir())
print(a.subir())
print(a.descer())
print(a.descer())
print(a.descer())
print(a.saiPessoa())
print(a.saiPessoa())
