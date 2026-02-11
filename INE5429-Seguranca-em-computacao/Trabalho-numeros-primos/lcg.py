import miller_rabin
import solovay_strassem
import time
import random
import datetime

def lcg(seed, a, c, m, bits):
    x = seed
    while True:
        x = (a * x + c) % m
        if x.bit_length() >= bits:
            return x

# Parâmetros típicos de LCG (podem ser ajustados)
a = 6364136223846793005
c = 1442695040888963407

# Geração de números para diferentes tamanhos em bits
bit_sizes = [40, 56, 80, 128, 168, 224, 256, 512, 1024, 2048, 4096]
seed = random.getrandbits(256)

# for size in bit_sizes:
#     m = 2 ** size
#     start_time = int(time.time() * 1000)
#     prime = lcg(seed, a, c, m, size)
#     end_time = int(time.time() * 1000)

#     print(f"Generated number with {size} bits: {prime}")
#     print(f"Elapsed time: {(end_time - start_time)} milliseconds")
#     print(f"--------------------------------------------------------------------\n")

filename = "generated_primes/lcg/ss/lcg_primes_ss_"

i = 0
j = 0
bits_antigo = 0
while j < 10:
    with open(filename + str(j) + ".txt", "w") as f:
        f.write(f"primes:\n\n")
    while i < len(bit_sizes):
        bits = bit_sizes[i]
        if bits != bits_antigo:
            start_time = time.time()
            bits_antigo = bits

        m = 2 ** bits
        prime = lcg(seed, a, c, m, bits)
        seed = prime  # Atualiza a semente para o próximo número
        if solovay_strassem.is_prime(prime):
            print(f"Prime number with {bits} bits: {prime}")
            i += 1
            with open(filename + str(j) + ".txt", "a") as f:
                f.write(f"--------------------------------------------------\n")
                f.write(f"{bits} bits:\n{prime}\n\n")
                f.write(f"Elapsed time: {time.time() - start_time:.4f} seconds\n")
    j += 1
    i = 0
    bits_antigo = 0

