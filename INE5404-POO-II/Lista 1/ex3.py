# Problema 3
class Polinomio:
    def __init__(self, coeficientes:list) -> None:
        self.coef = coeficientes
    
    # Criar a string do polinômio no formato padrão
    def create(coef):
        out = ''
        for i in range(len(coef)):
            if i == 0:
                out += "%d" % (coef[i])
            elif i == 1:
                out += " + %dx" % (coef[i])
            else:
                out += " + %dx**%d" % (coef[i], i)
        return out
    
    # Converte a string do polinômio para um dicionário para facilitar as outras operações
    def toDict(poli):
        poli = poli.split(' + ')
        a = poli[1][:len(poli[1])-1]
        d = {0: int(poli[0]), 1: int(a)}
        for i in range(2, len(poli)):
            limite = len(poli[i])-4
            d[i] = int(poli[i][:limite])
        return d

    # Resolve a equação para um dado valor de x
    def solve(self, polinomio:str, x:int):
        d = self.toDict(polinomio)
        total = 0
        for i in d:
            total += d[i]*(x**i)
        return total
    
    # Soma dois polinômios
    def soma(self, poli1:list, poli2:list):
        d1 = self.toDict(poli1)
        d2 = self.toDict(poli2)
        d = {}
        menor = min(len(d1), len(d2))

        for i in range (menor):
            d[i] = d1[i] + d2[i]

        if len(d2) > len(d1):
            for i in range (menor, len(d2)):
                d[i] = d2[i]
        elif len(d1) > len(d2):
            for i in range (menor, len(d1)):
                d[i] = d1[i]
        
        # Cria o polinômio com base nos valores do dicionário
        return self.create(list(d.values()))
    
    # Multiplica dois polinômios
    def multi(self, poli1:list, poli2:list):
        d1 = self.toDict(poli1)
        d2 = self.toDict(poli2)
        d = {}

        for i in d1:
            for j in d2:
                if (i+j) in d:
                    d[i+j] += d1[i]*d2[j]
                else:
                    d[i+j] = d1[i]*d2[j]
        
        return self.create(list(d.values()))


coef = list(map(int, input().split()))
coef2 = list(map(int, input().split()))
polinomio1 = Polinomio.create(coef)
polinomio2 = Polinomio.create(coef2)

# Resolver o polinômio 1 para x=3
print(Polinomio.solve(Polinomio, polinomio1, 3))

# Somar e multiplicar os polinômios
print(Polinomio.soma(Polinomio, polinomio1, polinomio2))
print(Polinomio.multi(Polinomio, polinomio1, polinomio2))