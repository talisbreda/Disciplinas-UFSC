class ElevadorJahNoUltimoAndarException(Exception):
    def __init__(self) -> None:
        super().__init__("O elevador ja esta no ultimo andar")