class Fracao:
    def __init__(self, numerador, denominador) -> None:
        self.numerador = numerador
        self.denominador = denominador

class Format:
    end = '\033[0m'
    underline = '\033[4m'

def printFracao(f1):
    print(Format.underline + str(f1.numerador) + Format.end)
    print(f1.denominador)

def soma(f1, f2):
    if f1.denominador == f2.denominador:
        return Fracao(f1.numerador + f2.numerador, f1.denominador)
    else:
        num = (f1.numerador * f2.denominador) + (f2.numerador * f1.denominador)
        denom = f1.denominador * f2.denominador
        return Fracao(num, denom)
    
def subtracao(f1, f2):
    if f1.denominador == f2.denominador:
        return Fracao(f1.numerador - f2.numerador, f1.denominador)
    else:
        num = (f1.numerador * f2.denominador) - (f2.numerador * f1.denominador)
        denom = f1.denominador * f2.denominador
        return Fracao(num, denom)

def multiplicacao(f1, f2):
    num = f1.numerador * f2.numerador
    denom = f1.denominador * f2.denominador
    return Fracao(num, denom)

def divisao(f1, f2):
    num = f1.numerador * f2.denominador
    denom = f1.denominador * f2.numerador
    return Fracao(num, denom)


def inverterFracao(f1):
    f1.numerador, f1.denominador = f1.denominador, f1.numerador
    return f1

def valorReal(f1):
    return f1.numerador / f1.denominador

def realParaFracao(num):
    if int(num) == num:
        return Fracao(num, 1)
    else:
        cont = 2
        while True:
            if num*cont == int(num*cont):
                return Fracao(int(num*cont), cont)
            cont += 1

def main():
    a = Fracao(2, 5)
    b = Fracao(4, 3)

    printFracao(soma(a, b))
    printFracao(subtracao(a, b))
    printFracao(multiplicacao(a, b))
    printFracao(divisao(a, b))
    printFracao(inverterFracao(a))
    print(valorReal(b))
    printFracao(realParaFracao(567.658))

if __name__ == "__main__":
    main()
