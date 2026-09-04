class CompilerError(Exception):
    """Erro base do compilador com posição (linha, coluna) 1-based e mensagem em português."""

    def __init__(self, linha: int, coluna: int, mensagem: str):
        self.linha = linha
        self.coluna = coluna
        self.mensagem = mensagem
        super().__init__(mensagem)

    def __str__(self) -> str:
        return f"{self.linha}:{self.coluna}: {self.mensagem}"


class LexicalError(CompilerError):
    """Erro léxico (caractere/lexema inválido, string não fechada, etc.)."""


class SyntaxError_(CompilerError):
    """Erro sintático (token inesperado / entrada não pertence à linguagem).

    Sufixo ``_`` evita colidir com o ``SyntaxError`` embutido do Python.
    """


class SemanticError(CompilerError):
    """Erro semântico (tipos, escopo, ``break`` fora de ``for``, etc.)."""
