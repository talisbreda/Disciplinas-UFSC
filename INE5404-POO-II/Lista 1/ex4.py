class Series:
    def __init__(self, num) -> None:
        self.num = num
        self.fibSequence = {}
        self.primeSequence = [2]

    def fib(self, n=-1):
        if n == -1:
            n = self.num-1
        if n == 1 or n == 0:
            return 1
        else:
            if n not in self.fibSequence:
                self.fibSequence[n] = self.fib(n-1) + self.fib(n-2)
            return self.fibSequence[n]
    
    def fatorial(self, n=-1):
        if n == -1:
            n = self.num
        if n == 1:
            return 1
        else:
            return self.fatorial(n-1) * n
    
    def fibonarial(self, n=-1):
        out = 1
        if n == -1:
            n = self.num -1
        for i in range (1, n+1):
            fib = self.fib(i)
            out *= fib
        
        return out
    
    def primos(self, n=-1):
        if n == -1:
            n = self.num-1

        # Inicia a checagem a partir dos números maiores que os já checados
        k = self.primeSequence[-1]+1

        # Enquanto o tamanho da sequência for menor que a posição 
        # (a posição ainda não existe na sequência), continua buscando por primos
        while len(self.primeSequence) <= n:
            prime = True
            for i in range (2, int(k**(1/2))+1):
                if k % i == 0:
                    prime = False
                    k += 1
            if prime:                
                self.primeSequence.append(k)
                k += 1
        
        # Retorna o último elemento da sequência
        return self.primeSequence[-1]
        

while True:
    print("Insira o número")
    a = int(input())
    if a == -1:
        break

    num = Series(a)
    print("Fibonacci: " + str(num.fib()))
    print("\nFatorial: " + str(num.fatorial()))
    print("\nFibonarial: " + str(num.fibonarial()))
    print("\nPrimos: " + str(num.primos()))