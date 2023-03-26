from mamifero import Mamifero

class Cachorro(Mamifero):
    def __init__(self) -> None:
        super().__init__(3, 3)

    def latir(self):
        return super().produzir_som()