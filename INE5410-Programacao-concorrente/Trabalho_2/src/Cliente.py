from threading import Thread, Semaphore

class Cliente:
    thread = None

    def __init__(self, id: int, faixaEtaria: int):
        self.id = id
        self.faixaEtaria = faixaEtaria

    def setThread(self, thread: Thread):
        self.thread = thread
    
    def getFaixaEtaria(self) -> str:
        lista = ["A", "B", "C"]
        return lista[self.faixaEtaria]