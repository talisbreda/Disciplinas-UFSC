import random

def is_prime(n, k=10):
    if n <= 3:
        return n == 2 or n == 3
    if n % 2 == 0:
        return False

    # Escreve n-1 como 2^s * d
    s, d = 0, n - 1
    while d % 2 == 0:
        d //= 2
        s += 1

    # Executa k testes
    for _ in range(k):
        # Escolha aleatoria (probabilistica) da base
        # a = random.randrange(2, n - 1)
        a = 10
        x = pow(a, d, n)

        # Se x ≡ 1 (mod n) ou x ≡ n-1 (mod n), uma das condicoes do algoritmo
        if x == 1 or x == n - 1:
            continue

        # x ≡ a^(2^r * d) (mod n) para r = 0, 1, ..., s-1
        # Se x != -1, continue testando
        # Se nao encontrar n-1, entao n e composto
        for _ in range(s - 1):
            x = pow(x, 2, n)
            if x == n - 1:
                break
        else:
            return False  # Composto

    return True  # Provavelmente primo

known_pseudoprimes = [9, 33, 91, 99, 259, 451, 481, 561, 657, 703, 909, 1233, 1729, 2409, 2821, 2981, 3333, 3367, 4141, 4187, 4521, 5461, 6533, 6541, 6601, 7107, 7471, 7777, 8149, 8401, 8911, 10001, 11111, 11169, 11649, 12403, 12801, 13833, 13981, 14701, 14817, 14911, 15211]
for pseudoprime in known_pseudoprimes:
    if is_prime(pseudoprime):
        print(f"{pseudoprime} foi identificado incorretamente como primo.")
    else:
        print(f"{pseudoprime} foi identificado corretamente como composto.")