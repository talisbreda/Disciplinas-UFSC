import PySimpleGUI as sg

# View do padrão MVC
class ClienteView():
    def __init__(self, controlador):
        self.__controlador = controlador
        self.__container = []
        self.__window = sg.Window("Consulta de clientes", self.__container ,font=("Helvetica", 14))

    def tela_consulta(self):
        self.__container = []
        self.__container.append([sg.Text("Digite o código ou o nome do cliente e clique na ação desejada")])
        self.__container.append([sg.Text("Nome: "), sg.InputText("", key='nome')])
        self.__container.append([sg.Text("Código "), sg.InputText("", key='codigo')])
        self.__container.append([sg.Button("Cadastrar", key='cadastro'), sg.Button("Consultar", key='consulta')])
        self.__container.append([sg.Text("", key="resultado")])
        
        self.__window = sg.Window("Consulta de clientes", self.__container ,font=("Helvetica", 14))

    def mostra_resultado(self, resultado): 
        self.__window.Element('resultado').Update(resultado)

    def le_eventos(self):
        return self.__window.read()

    def fim(self):
        self.__window.close()
