class ElevadorJahVazioException(Exception):
    def __init__(self) -> None:
        super().__init__("O elevador esta vazio")