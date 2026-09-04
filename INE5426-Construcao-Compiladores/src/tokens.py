from dataclasses import dataclass
from enum import Enum, auto


class TokenType(Enum):
    """Classes de token reconhecidas pelo léxico."""

    # Palavras-chave
    DEF = auto()
    INT = auto()
    FLOAT = auto()
    STRING = auto()
    PRINT = auto()
    READ = auto()
    RETURN = auto()
    IF = auto()
    ELSE = auto()
    FOR = auto()
    BREAK = auto()
    NEW = auto()
    NULL = auto()

    # Identificador e constantes
    IDENT = auto()
    INT_CONST = auto()
    FLOAT_CONST = auto()
    STRING_CONST = auto()

    # Pontuação / delimitadores
    LPAREN = auto()
    RPAREN = auto()
    LBRACE = auto()
    RBRACE = auto()
    LBRACK = auto()
    RBRACK = auto()
    SEMI = auto()
    COMMA = auto()

    # Operadores
    ASSIGN = auto()
    LT = auto()
    GT = auto()
    LE = auto()
    GE = auto()
    EQ = auto()
    NE = auto()
    PLUS = auto()
    MINUS = auto()
    STAR = auto()
    SLASH = auto()
    PERCENT = auto()

    # Fim de entrada
    EOF = auto()


@dataclass
class Token:
    """Token léxico com tipo, lexema e posição na fonte."""

    type: TokenType
    lexeme: str
    line: int
    col: int
