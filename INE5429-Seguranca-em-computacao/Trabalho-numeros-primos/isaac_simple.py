import random
import time
import miller_rabin

SIZE = 256  # Tamanho da memoria interna (numero de inteiros de 32 bits)
MASK = 0xFFFFFFFF  # Mascara de 32 bits para garantir operacoes de 32 bits

class ISAAC:
    def __init__(self, seed):
        self.a = 0
        self.b = 0
        self.c = 0
        self.count = SIZE  # Contador de numeros gerados
        self.results = [0] * SIZE  # Vetor de resultados de numeros aleatorios
        self.memory = [0] * SIZE  # Memoria interna usada para mistura

        # Inicializa o estado com o seed fornecido
        for i in range(len(seed)):
            self.results[i % SIZE] ^= seed[i]  # Mistura o seed com os resultados

        self._initialize()  # Inicializa a memoria e o estado do gerador

    def _initialize(self):
        # Funcao auxiliar para embaralhar os valores internos
        def mix(a, b, c, d, e, f, g, h):
            # Mistura os valores com operacoes XOR, shifts e somas
            a ^= (b << 11) & MASK
            d = (d + a) & MASK
            b = (b + c) & MASK
            b ^= (c >> 2) & MASK
            e = (e + b) & MASK
            c = (c + d) & MASK
            c ^= (d << 8) & MASK
            f = (f + c) & MASK
            d = (d + e) & MASK
            d ^= (e >> 16) & MASK
            g = (g + d) & MASK
            e = (e + f) & MASK
            e ^= (f << 10) & MASK
            h = (h + e) & MASK
            f = (f + g) & MASK
            f ^= (g >> 4) & MASK
            a = (a + f) & MASK
            g = (g + h) & MASK
            g ^= (h << 8) & MASK
            b = (b + g) & MASK
            h = (h + a) & MASK
            h ^= (a >> 9) & MASK
            c = (c + h) & MASK
            a = (a + b) & MASK
            return a, b, c, d, e, f, g, h

        a = b = c = d = e = f = g = h = 0x9e3779b9  # Golden ratio para inicializacao

        # Scramble os valores internos com a funcao de mistura
        for _ in range(4):  # 4 iteracoes para embaralhamento
            a, b, c, d, e, f, g, h = mix(a, b, c, d, e, f, g, h)

        # Mistura o estado da memoria com o seed inicial
        for i in range(0, SIZE, 8):
            a = (a + self.results[i]) & MASK
            b = (b + self.results[i + 1]) & MASK
            c = (c + self.results[i + 2]) & MASK
            d = (d + self.results[i + 3]) & MASK
            e = (e + self.results[i + 4]) & MASK
            f = (f + self.results[i + 5]) & MASK
            g = (g + self.results[i + 6]) & MASK
            h = (h + self.results[i + 7]) & MASK
            # Aplica a mistura a cada bloco de 8 valores
            a, b, c, d, e, f, g, h = mix(a, b, c, d, e, f, g, h)
            self.memory[i:i + 8] = [a, b, c, d, e, f, g, h]

        self._generate()  # Gera os primeiros numeros aleatorios

    def _generate(self):
        self.c = (self.c + 1) & MASK  # Incrementa o contador (c)
        self.b = (self.b + self.c) & MASK  # Mistura com o contador (b)

        # Gera novos numeros aleatorios a partir da memoria
        for i in range(SIZE):
            x = self.memory[i]
            if i & 3 == 0:
                self.a ^= (self.a << 13) & MASK  # Shifts a esquerda (XOR)
            elif i & 3 == 1:
                self.a ^= (self.a >> 6) & MASK  # Shifts a direita (XOR)
            elif i & 3 == 2:
                self.a ^= (self.a << 2) & MASK  # Shifts a esquerda (XOR)
            elif i & 3 == 3:
                self.a ^= (self.a >> 16) & MASK  # Shifts a direita (XOR)

            self.a = (self.memory[(i + 128) % SIZE] + self.a) & MASK  # Mistura com valor de memoria
            y = (self.memory[(x >> 2) % SIZE] + self.a + self.b) & MASK  # Acesso indireto a memoria
            self.memory[i] = y  # Atualiza a memoria
            self.b = (self.memory[(y >> 10) % SIZE] + x) & MASK  # Mistura com o novo valor
            self.results[i] = self.b  # Atualiza os resultados

        self.count = 0  # Reseta o contador de numeros gerados

    def rand(self):
        # Retorna o proximo numero aleatorio gerado
        if self.count >= SIZE:
            self._generate()  # Se necessario, gera mais numeros
        r = self.results[self.count]
        self.count += 1  # Avanca o contador
        return r
    
def rand_n_bits(isaac, n_bits):
    chunks = (n_bits + 31) // 32  # numero de chamadas necessarias
    result = 0
    for _ in range(chunks):
        result = (result << 32) | isaac.rand()
    # Se passou do numero exato de bits, corta o excesso
    result &= (1 << n_bits) - 1
    if (int(str(result)[-1]) % 2) == 0:
        result += 1
    return result


bit_sizes = [40, 56, 80, 128, 168, 224, 256, 512, 1024, 2048, 4096]
seed = [random.randint(0, 256) for _ in range(256)]
isaac = ISAAC(seed)

# for bits in bit_sizes:
#     start_time = time.time()
#     num = rand_n_bits(isaac, bits)
#     print(f"{bits}-bit number:\n{num}\n")
#     end_time = time.time()
#     elapsed_time = (end_time - start_time) * 1000  # em milissegundos
#     print(f"Elapsed time: {elapsed_time} milliseconds")
#     print("--------------------------------------------------------------------\n")

filename = "generated_primes/isaac/mr/isaac_primes_mr_"

i = 0
j = 0
bits_antigo = 0
while j < 10:
    with open(filename + str(j) + ".txt", "w") as f:
        f.write(f"primes:\n\n")
    while i < len(bit_sizes):
        if bit_sizes[i] != bits_antigo:
            start_time = time.time()
            bits_antigo = bit_sizes[i]

        bits = bit_sizes[i]
        num = rand_n_bits(isaac, bits)
        
        if miller_rabin.is_prime(num):
            print(f"Prime number with {bits} bits: {num}")
            with open(filename + str(j) + ".txt", "a") as f:
                f.write(f"--------------------------------------------------\n")
                f.write(f"{bits} bits:\n{num}\n\n")
                f.write(f"Elapsed time: {time.time() - start_time:.4f} seconds\n")
            i += 1
    j += 1
    i = 0
    bits_antigo = 0