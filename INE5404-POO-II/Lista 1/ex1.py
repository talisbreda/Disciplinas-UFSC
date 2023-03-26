class Conta:
    def __init__(self, clientes:list) -> None:
        self.__clientes = clientes
        self.__saldo = 0
        self.__operacoes = []
        pass

    def depositar(self, valor):
        self.__saldo += valor
        self.__operacoes.append('Depósito de R$%.2f' % (valor))
    
    def sacar(self, valor):
        if self.__saldo >= valor:
            self.__saldo -= valor
            self.__operacoes.append('Retirada de R$%.2f' % (valor))
            return "Saque bem-sucedido!"
        else:
            return "Saldo insuficiente"
    
    def verificarSaldo(self):
        saldo = "Saldo atual: R$%.2f" % (self.__saldo)
        return saldo
    
    def mostrarExtrato(self):
        out = ''
        for operacao in self.__operacoes:
            out += "\n" + operacao
        return out
    
    def listarClientes(self):
        out = ''
        for cliente in self.__clientes:
            out += "\n" + cliente.getNome()
        return out
    
    def __str__(self) -> str:
        return "%s\n\nHistórico de operações:%s\n\nCliente(s):%s" % (self.verificarSaldo(), self.mostrarExtrato(), self.listarClientes())
        

class Especial(Conta):
    def __init__(self, clientes: list) -> None:
        super().__init__(clientes)
    
    def sacar(self, valor):
        if self.__saldo >= valor:
            return "Saque bem-sucedido!"
        else:
            a = input("O seu saldo é insuficiente, note que ao sacar essa quantia seu saldo ficará negativo.\nDeseja continuar mesmo assim? (sim ou nao)\n")
            if a.lower() == 'nao':
                return "Saque não realizado"
        self.__saldo -= valor
        self.__operacoes.append('Retirada de R$%.2f' % (valor))
        return "Saque bem-sucedido!"

class Poupança(Conta):
    def __init__(self, clientes: list) -> None:
        super().__init__(clientes)

class Cliente:
    def __init__(self, nome, telefone) -> None:
        self.__nome = nome
        self.__telefone = telefone
    
    def getNome(self):
        return self.__nome
    def getTelefone(self):
        return self.__telefone
    
    def setNome(self, nome):
        self.__nome = nome
    def setTelefone(self, telefone):
        self.__telefone = telefone

cliente1 = Cliente("Jonas", "854891568")
cliente2 = Cliente("Carlos", "854891568")
cliente3 = Cliente("Pedro", "854891568")
cliente4 = Cliente("Edmilson", "854891568")
conta1 = Conta([cliente1, cliente2, cliente3, cliente4])
conta2 = Poupança([cliente1, cliente2, cliente3, cliente4])
conta2.depositar(200)
print(conta2.sacar(300))
print(conta2)

print(conta1)

# Cada conta corrente pode ter um ou mais clientes como titular. 
# O banco controla apenas o nome e o telefone de cada cliente. 
# A conta corrente apresenta um saldo e uma lista de operações de saques e depósitos. 
# Quando o cliente fizer um saque, diminuiremos o saldo da conta corrente. 
# Quando ele fizer um depósito, aumentaremos o saldo. 
# O banco oferece também contas especiais, com limite especial além do saldo, 
# e conta poupança, que oferece um rendimento mensal sempre que o saldo na conta completa um mês. 
# Evidentemente é necessário oferecer aos clientes a possibilidade de verificar saldos, extratos 
# e um resumo com todas as informações da conta e seus respectivos clientes