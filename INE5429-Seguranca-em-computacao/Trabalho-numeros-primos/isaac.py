import random
import time
import miller_rabin
import solovay_strassem

class ISAAC:
    def __init__(self, chave):
        # O estado do ISAAC: uma lista de 256 numeros (128 registros de 32 bits)
        self.state = [0] * 256
        # Inicializacao da chave: seed + chave fornecida
        self.init_state(chave)

    def init_state(self, chave):
        # Inicializa o estado interno com uma chave ou semente
        for i in range(256):
            self.state[i] = chave[i % len(chave)] ^ i  # Preenchendo o estado com chave e indices
        # Mistura inicial para "embaralhar" o estado
        self.isaac()

    def isaac(self):
        result = [0] * 256 
        a = b = c = 0

        for i in range(256):
            a = self.state[i]  # A variavel 'a' recebe o valor do estado atual
            c = (c + 1) & 0xFFFFFFFF  # Incrementa 'c' e garante que caiba em 32 bits (com mascara de 32 bits)
            b = self.state[(i + 128) % 256]  # A variavel 'b' recebe um valor do estado, mas com um indice deslocado (mistura os valores)

            # A operacao abaixo e um "mix" que combina as variaveis a, b, e c, e gera um novo valor:
            # A mistura inclui soma, shift e XOR. Cada operacao altera os valores de forma nao trivial
            result[i] = (a + b + c) & 0xFFFFFFFF  # Soma a, b e c e aplica uma mascara de 32 bits

            self.state[i] = result[i]  # Atualiza o estado com o novo valor calculado

        # Após o loop, o estado da instancia e atualizado com o novo estado misturado
        self.state = result

    def gerar(self):
        # Gera um numero pseudo-aleatorio a partir do estado
        self.isaac()  # Chama a funcao de mistura (isso vai alterar o estado)
        return self.state[0]  # Retorna o primeiro valor do estado como o numero aleatorio gerado

    def gerar_bits(self, num_bits):
        # Gera um numero aleatorio com exatamente 'num_bits' bits
        num_bytes = (num_bits + 7) // 8  # Calcula quantos bytes sao necessários
        bits = 0
        for _ in range(num_bytes):
            bits = (bits << 32) | self.gerar()  # Concatenar 32 bits a cada iteracao
        # Truncar para o numero exato de bits necessários
        return bits >> (bits.bit_length() - num_bits)  # Ajusta para o tamanho exato de bits

# Função para gerar números aleatórios com o ISAAC e tamanho de bits especificado
def gerar_isaac_bits(chave, num_bits):
    isaac_gen = ISAAC(chave)
    return isaac_gen.gerar_bits(num_bits)

chave = [random.randint(0, 255) for _ in range(8)]  # Chave aleatória de 8 bytes

tamanhos_bits = [40, 56, 80, 128, 168, 224, 256, 512, 1024, 2048, 4096]
resultados = {}
filename = "generated_primes/isaac/ss/isaac_primes_ss_"

i = 0
j = 0
bits_antigo = 0
while j < 10:
    with open(filename + str(j) + ".txt", "w") as f:
        f.write(f"primes:\n\n")
    while i < len(tamanhos_bits):
        if tamanhos_bits[i] != bits_antigo:
            start_time = time.time()
            bits_antigo = tamanhos_bits[i]

        bits = tamanhos_bits[i]
        num = gerar_isaac_bits(chave, bits)
        chave = [num]  # Atualiza a chave para o próximo número
        
        if solovay_strassem.is_prime(num):
            resultados[bits] = num
            print(f"Prime number with {bits} bits: {num}")
            with open(filename + str(j) + ".txt", "a") as f:
                f.write(f"--------------------------------------------------\n")
                f.write(f"{bits} bits:\n{num}\n\n")
                f.write(f"Elapsed time: {time.time() - start_time:.4f} seconds\n")
            i += 1
    j += 1
    i = 0
    bits_antigo = 0