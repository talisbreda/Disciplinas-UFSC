from ClienteView import ClienteView
from Cliente import Cliente
import PySimpleGUI as sg 

class ClienteController:
    def __init__(self):
        self.__telaCliente = ClienteView(self)
        self.__clientes = {'aaa': Cliente(2, 'aaa'),
                           'bbb': Cliente(3, 'bbb')} #lista de objetos Cliente

    def inicia(self):
        self.__telaCliente.tela_consulta()
        
        # Loop de eventos
        rodando = True
        resultado = ''
        while rodando:
            event, values = self.__telaCliente.le_eventos()
            if event == sg.WIN_CLOSED:
                rodando = False
            elif event == 'cadastro':
                #FIX ME - implementar lógica de cadastro
                pass
            elif event == 'consulta':
                if values['nome'] != '':
                    if values['nome'] in self.__clientes:
                        result = "Nome: %s      Código: %s" % (values['nome'], self.__clientes[values['nome']].codigo)
                    else:
                        result = "Não encontrado"
                elif values['codigo'] != '':
                    nome = ''
                    for cliente in self.__clientes:
                        if self.__clientes[cliente].codigo == int(values['codigo']):
                            nome = cliente
                            break
                    if nome == '':
                        result = "Não encontrado"
                    else:
                        result = "Nome: %s      Código: %s" % (nome, values['codigo'])            
                self.__telaCliente.mostra_resultado(result)

            if resultado != '':
                dados = str(resultado)
                self.__telaCliente.mostra_resultado(dados)

        self.__telaCliente.fim()


    def busca_codigo(self, codigo):
        try:
            return self.__clientes[codigo]
        except KeyError:
            raise KeyError

    # cria novo OBJ cliente e adiciona ao dict
    def adiciona_cliente(self, codigo, nome):
        self.__clientes[codigo] = Cliente(codigo, nome)
    
    def busca_nome(self, nome):
        for key, val in self.__clientes.items():
            if val.nome == nome:
                return key 

        raise LookupError
