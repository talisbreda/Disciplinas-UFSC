from categoriaProduto import CategoriaProduto
from cliente import Cliente


class Produto:
    def __init__(self, codigo_, descricao_, categoria_:CategoriaProduto) -> None:
        self.__codigo = codigo_
        self.__descricao = descricao_
        self.__categoria = categoria_
        self.__cliente = ''
        self.__preco_unitario = 0
        self.__quantidade = 0
    
    @property
    def codigo(self):
        return self.__codigo
    
    @codigo.setter
    def codigo(self, codigo):
        self.__codigo = codigo
    
    @property
    def descricao(self):
        return self.__descricao
    
    @descricao.setter
    def descricao(self, descricao):
        self.__descricao = descricao
    
    @property
    def categoria(self):
        return self.__categoria
    
    @categoria.setter
    def categoria(self, categoria):
        self.__categoria = categoria
    
    @property
    def cliente(self):
        return self.__cliente
    
    @cliente.setter
    def cliente(self, cliente):
        self.__cliente = cliente
    
    @property
    def preco_unitario(self):
        return self.__preco_unitario
    
    @preco_unitario.setter
    def preco_unitario(self, preco_unitario):
        self.__preco_unitario = preco_unitario
    
    @property
    def quantidade(self):
        return self.__quantidade
    
    @quantidade.setter
    def quantidade(self, quantidade):
        self.__quantidade = quantidade

    
    def preco_total(self):
        return self.__quantidade * self.__preco_unitario