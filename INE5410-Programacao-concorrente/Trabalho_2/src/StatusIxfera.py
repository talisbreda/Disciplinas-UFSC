from threading import Semaphore, Lock, Thread
from multiprocessing import Queue
from Cliente import Cliente
from time import time

class StatusIxfera:
    filaClientes: list = []
    tipoApresentacao: str = None

    semaforoEntrada: Semaphore = None
    semaforoVagas: Semaphore = None
    semaforoControle: Semaphore = None
    semaforoFim: Semaphore = None
    semaforoChegada: Semaphore = None
    semaforoRetornoControle: Semaphore = None
    lock: Lock = None
    pessoasNaApresentacao = 0
    pessoasQueEntraram = 0
    pessoasQueSairam = 0
    filaMensagens: Queue = Queue()
    statusFim: int = 0

    n_pessoas = 0
    n_vagas = 0
    permanencia = 0
    max_intervalo = 0
    semente = 0
    unid_tempo = 0

    qtdClientes = [0, 0, 0]
    temposEspera = [0, 0, 0]
    tempoExperiencia = 0
    lockEspera = Lock()

    primeiraVez = True

    def __init__(self, n_pessoas, n_vagas, permanencia, max_intervalo, semente, unid_tempo):
        self.semaforoEntrada = Semaphore(0)
        self.semaforoFim = Semaphore(0)
        self.semaforoChegada = Semaphore(0)
        self.semaforoControle = Semaphore(0)
        self.semaforoRetornoControle = Semaphore(0)
        self.lock = Lock()

        self.n_pessoas = n_pessoas
        self.n_vagas = n_vagas
        self.permanencia = permanencia
        self.max_intervalo = max_intervalo
        self.semente = semente
        self.unid_tempo = unid_tempo

        self.semaforoVagas = Semaphore(n_vagas)

    def adicionaNaFila(self, cliente):
        self.lock.acquire()
        self.filaClientes.append(cliente)
        self.lock.release()
    
    def clienteEntra(self, cliente: Cliente):
        self.lock.acquire()
        self.pessoasNaApresentacao += 1
        self.pessoasQueEntraram += 1
        print("[Pessoa %d / %s] Entrou na ixfera (quantidade = %d)" % (cliente.id, cliente.getFaixaEtaria(), self.pessoasNaApresentacao))
        self.lock.release()
    
    def clienteSai(self, cliente: Cliente):
        self.lock.acquire()
        self.pessoasNaApresentacao -= 1
        self.pessoasQueSairam += 1
        print("[Pessoa %d / %s] Saiu da ixfera (quantidade = %d)" % (cliente.id, cliente.getFaixaEtaria(), self.pessoasNaApresentacao))
        if (self.pessoasNaApresentacao == 0):
            self.filaMensagens.put(2)
            self.semaforoControle.release()
        self.semaforoVagas.release()
        self.lock.release()
    
    def defineFaixaEtaria(self):
        self.semaforoChegada.acquire()
        self.lock.acquire()
        primeiro: Cliente = self.filaClientes[0]
        self.lock.release()
        self.tipoApresentacao = primeiro.getFaixaEtaria()
        print("[Ixfera] Iniciando a experiência %s." % self.tipoApresentacao)
        self.semaforoChegada.release()

    def threadControleFim(self) :
        while True:
            self.semaforoControle.acquire()
            valor = self.filaMensagens.get()
            if (self.primeiraVez):
                self.primeiraVez = False
                self.statusFim = valor
            elif (self.statusFim != valor):
                self.statusFim = valor
            if valor == 2:
                self.semaforoFim.release()
                self.semaforoRetornoControle.release()
                break
            if (self.pessoasQueEntraram == self.n_pessoas): break
            self.semaforoRetornoControle.release()
        return

    def liberaFila(self):

        while True:
            
            self.semaforoRetornoControle.acquire()
            # Caso o status de fim seja 2, significa que a ixfera esvaziou
            if (self.statusFim == 2):
                break

            self.semaforoVagas.acquire()
            if (self.pessoasQueEntraram == self.n_pessoas): break
            self.semaforoChegada.acquire()

            self.lock.acquire()
            atual: Cliente = self.filaClientes[0]
            self.lock.release()

            if (atual.getFaixaEtaria() != self.tipoApresentacao):
                self.semaforoChegada.release()
                self.semaforoVagas.release()
                break
        
            self.filaClientes.pop(0)
            self.semaforoEntrada.release()

    def iniciaSimulacao(self):
        tempoInicio = time()
        while self.pessoasQueSairam < self.n_pessoas:
            threadControle = Thread(target=self.threadControleFim)
            threadControle.start()
            self.defineFaixaEtaria()
            self.liberaFila()
            self.semaforoFim.acquire()
            print("[Ixfera] Pausando a experiencia %s." % self.tipoApresentacao)
            self.primeiraVez = True
            self.statusFim = 0
        tempoFim = time()
        self.tempoExperiencia = tempoFim - tempoInicio


















    def getFila(self):
        return self.filaClientes

    def getTipoApresentacao(self):
        return self.tipoApresentacao
        