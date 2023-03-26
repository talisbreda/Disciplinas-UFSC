from ave import Ave

class Canarinho(Ave):
    def __init__(self, tamanho_passo: int, altura_voo: int) -> None:
        super().__init__(tamanho_passo, altura_voo)
    
    def cantar(self):
        return super().produzir_som()