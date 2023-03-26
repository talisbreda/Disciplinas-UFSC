class ComandoInvalidoException(Exception):
    def __init__(self) -> None:
        super().__init__("O comando e invalido")