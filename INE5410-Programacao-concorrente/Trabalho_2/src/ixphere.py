
import sys
from threading import Thread
from StatusIxfera import StatusIxfera
from Cliente import Cliente
from time import sleep, time
import random

def inicializaCliente(ixfera: StatusIxfera, i: int):
    random.seed()
    faixaEtaria = random.randint(0, 2)
    ixfera.qtdClientes[faixaEtaria] += 1
    return Cliente(i, faixaEtaria)

def criaClientes(nPessoas: int, ixfera: StatusIxfera):
    clientesThreads: list[Thread] = []
    for i in range(nPessoas):
        cliente: Cliente = inicializaCliente(ixfera, i)
        thread = Thread(target=threadCliente, args=(cliente, ixfera))

        cliente.setThread(thread)
        clientesThreads.append(thread)
        ixfera.adicionaNaFila(cliente)
        thread.start()

        sleep(geraTempoIntervalo(ixfera))
    
    for thread in clientesThreads:
        thread.join()

def threadCliente(cliente: Cliente, ixfera: StatusIxfera):
    print("[Pessoa %d / %s] Aguardando na fila." % (cliente.id, cliente.getFaixaEtaria()))

    tempoStart = time()
    ixfera.semaforoChegada.release()
    ixfera.filaMensagens.put(1)
    ixfera.semaforoControle.release()
    ixfera.semaforoEntrada.acquire()
    tempoEnd = time()

    ixfera.clienteEntra(cliente)
    sleep(ixfera.permanencia)
    ixfera.clienteSai(cliente)

    ixfera.lockEspera.acquire()
    ixfera.temposEspera[cliente.faixaEtaria] += (tempoEnd - tempoStart)
    ixfera.lockEspera.release()
    return

def geraTempoPermanencia(ixfera: StatusIxfera):
    random.seed(ixfera.semente)
    return random.randint(0, ixfera.permanencia) * (ixfera.unid_tempo/1000)

def geraTempoIntervalo(ixfera: StatusIxfera):
    random.seed(ixfera.semente)
    return random.randint(0, ixfera.max_intervalo) * (ixfera.unid_tempo/1000)

def trataEntrada(argv: list[str]):
    try:
        nPessoas = int(argv[0])
        if (nPessoas <= 0): raise Exception()
        nVagas = int(argv[1])
        if (nVagas <= 0): raise Exception()
        permanencia = int(argv[2])
        if (permanencia <= 0): raise Exception()
        maxIntervalo = int(argv[3])
        if (maxIntervalo <= 0): raise Exception()
        semente = int(argv[4])
        if (semente <= 0): raise Exception()
        unidTempo = int(argv[5])
        if (unidTempo <= 0): raise Exception()
    except:
        print("Erro: argumentos devem ser números inteiros positivos.")
        exit(1)
    return (nPessoas, nVagas, permanencia, maxIntervalo, semente, unidTempo)
    
if (__name__ == "__main__"):
    n = len(sys.argv)
    if (n != 7):
        print("Uso: python3 ixphere.py <N_PESSOAS> <N_VAGAS> <PERMANENCIA> <MAX_INTERVALO> <SEMENTE> <UNID_TEMPO>")
        exit(1)
    
    (nPessoas, nVagas, permanencia, maxIntervalo, semente, unidTempo) = trataEntrada(sys.argv[1:])

    ixfera = StatusIxfera(nPessoas, nVagas, permanencia, maxIntervalo, semente, unidTempo)


    criadora = Thread(target=criaClientes, args=(nPessoas, ixfera))
    criadora.start()
    
    print("[Ixfera] Simulacao iniciada.")
    tempoInicio = time()
    ixfera.iniciaSimulacao()
    criadora.join()
    tempoFim = time()
    print("[Ixfera] Simulacao finalizada.")

    print("\nTempo médio de espera:")
    if (ixfera.qtdClientes[0] == 0): print("Faixa A: -.-- (nenhum cliente A)")
    else: print("Faixa A: %.2f" % (ixfera.temposEspera[0]/(ixfera.qtdClientes[0])))

    if (ixfera.qtdClientes[1] == 0): print("Faixa B: -.-- (nenhum cliente B)")
    else: print("Faixa B: %.2f" % (ixfera.temposEspera[1]/(ixfera.qtdClientes[1])))

    if (ixfera.qtdClientes[2] == 0): print("Faixa C: -.-- (nenhum cliente C)")
    else: print("Faixa C: %.2f" % (ixfera.temposEspera[2]/(ixfera.qtdClientes[2])))

    tempoTotal = tempoFim - tempoInicio
    print("\nTaxa de ocupação: %.2f" % (ixfera.tempoExperiencia/tempoTotal))


