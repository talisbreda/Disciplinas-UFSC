from mamifero import Mamifero

class Gato(Mamifero):
    def __init__(self) -> None:
        super().__init__(2, 2)

    def miar(self):
        return super().produzir_som()