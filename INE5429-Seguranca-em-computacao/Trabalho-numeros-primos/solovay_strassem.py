import random
import math

def jacobi(a, n):
    # Calcula o simbolo de Jacobi (a/n), usado para comparacao com a^((n−1)/2)
    if n <= 0 or n % 2 == 0:
        return 0  # n precisa ser impar e positivo

    result = 1
    a = a % n  # Reduz a modulo n

    while a != 0:
        # Remove fatores de 2 de a
        while a % 2 == 0:
            a //= 2
            # Aplica a regra do simbolo de Jacobi para fatores de 2
            if n % 8 in [3, 5]:
                result = -result

        # Aplica reciprocidade quadrática
        a, n = n, a
        if a % 4 == 3 and n % 4 == 3:
            result = -result

        a %= n  # Reduz novamente

    return result if n == 1 else 0

def is_prime(n, k=10):
    # Teste de primalidade de Solovay-Strassen com k iteracoes
    if n < 2:
        return False
    if n == 2 or n == 3:
        return True
    if n % 2 == 0:
        return False  # Numeros pares > 2 sao compostos

    for _ in range(k):
        # a = random.randrange(2, n - 1)  # Escolhe a base aleatoria
        a = 10
        x = jacobi(a, n)  # Calcula o simbolo de Jacobi

        # Se simbolo de Jacobi for 0 ou nao bater com a potencia modular, n e composto
        if x == 0 or pow(a, (n - 1) // 2, n) != (x % n):
            return False

    return True  # Provavelmente primo

known_pseudoprimes = [9, 33, 91, 99, 259, 451, 481, 561, 657, 703, 909, 1233, 1729, 2409, 2821, 2981, 3333, 3367, 4141, 4187, 4521, 5461, 6533, 6541, 6601, 7107, 7471, 7777, 8149, 8401, 8911, 10001, 11111, 11169, 11649, 12403, 12801, 13833, 13981, 14701, 14817, 14911, 15211]
for pseudoprime in known_pseudoprimes:
    if is_prime(pseudoprime):
        print(f"{pseudoprime} foi identificado incorretamente como primo.")
    else:
        print(f"{pseudoprime} foi identificado corretamente como composto.")
