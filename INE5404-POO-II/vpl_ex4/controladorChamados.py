from tipoChamado import TipoChamado
from chamado import Chamado
from datetime import date as Date
from cliente import Cliente
from tecnico import Tecnico
from collections import defaultdict

class ControladorChamados():
    def __init__(self) -> None:
        self.__chamados = []
        self.__tipoChamados = []
    
    def totalChamadosPorTipo(self, tipo: TipoChamado) -> int:
        count = 0
        for chamado in self.__chamados:
            if chamado.tipo == tipo: count += 1
        return count
    
    def incluiChamado(self, data: Date, cliente: Cliente, tecnico: Tecnico, titulo: str, descricao: str, prioridade: int, tipo: TipoChamado) -> Chamado:
        if isinstance(cliente, Cliente) and isinstance(tecnico, Tecnico) and isinstance(tipo, TipoChamado):
            for chamado in self.__chamados:
                if (chamado.data == data and 
                chamado.cliente == cliente and 
                chamado.tecnico == tecnico and 
                chamado.tipo == tipo):
                    return
            c1 = Chamado(data, cliente, tecnico, titulo, descricao, prioridade, tipo)
            self.__chamados.append(c1)
            return c1
    
    def incluiTipoChamado(self, codigo: int, nome: str, descricao: str) -> TipoChamado:
        for tipo in self.__tipoChamados:
            if tipo.codigo == codigo:
                return
        tipo = TipoChamado(codigo, descricao, nome)
        self.__tipoChamados.append(tipo)
        return tipo
    
    @property
    def tipoChamados(self):
        return self.__tipoChamados