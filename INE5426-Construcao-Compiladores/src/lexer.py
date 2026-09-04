from collections.abc import Iterator

from .tokens import Token, TokenType
from .errors import LexicalError
from .symbol_table import SymbolTable

_ESPACOS = {" ", "\t", "\r", "\n"}


class Lexer:
    """DFA char-a-char que emite `Token`s e registra `ident`s na tabela."""

    PALAVRAS_CHAVE: dict[str, TokenType] = {
        "def": TokenType.DEF,
        "int": TokenType.INT,
        "float": TokenType.FLOAT,
        "string": TokenType.STRING,
        "print": TokenType.PRINT,
        "read": TokenType.READ,
        "return": TokenType.RETURN,
        "if": TokenType.IF,
        "else": TokenType.ELSE,
        "for": TokenType.FOR,
        "break": TokenType.BREAK,
        "new": TokenType.NEW,
        "null": TokenType.NULL,
    }

    SIMBOLOS: dict[str, TokenType] = {
        "(": TokenType.LPAREN,
        ")": TokenType.RPAREN,
        "{": TokenType.LBRACE,
        "}": TokenType.RBRACE,
        "[": TokenType.LBRACK,
        "]": TokenType.RBRACK,
        ";": TokenType.SEMI,
        ",": TokenType.COMMA,
        "+": TokenType.PLUS,
        "-": TokenType.MINUS,
        "*": TokenType.STAR,
        "/": TokenType.SLASH,
        "%": TokenType.PERCENT,
    }

    def __init__(self, fonte: str, tabela: SymbolTable):
        self.fonte = fonte
        self.tabela = tabela
        self.pos = 0
        self.linha = 1
        self.coluna = 1

    def _peek(self, offset: int = 0) -> str:
        i = self.pos + offset
        return self.fonte[i] if i < len(self.fonte) else ""

    def _avancar(self) -> str:
        c = self.fonte[self.pos]
        self.pos += 1
        if c == "\n":
            self.linha += 1
            self.coluna = 1
        else:
            self.coluna += 1
        return c

    def _pular_espacos(self) -> None:
        while self._peek() in _ESPACOS and self._peek() != "":
            self._avancar()

    def proximo_token(self) -> Token:
        """Lê e devolve o próximo `Token` (ou `EOF` ao fim da fonte)."""
        self._pular_espacos()
        linha, coluna = self.linha, self.coluna
        c = self._peek()
        if c == "":
            return Token(TokenType.EOF, "", linha, coluna)
        if c.isalpha() or c == "_":
            return self._ler_identificador(linha, coluna)
        if c.isdigit():
            return self._ler_numero(linha, coluna)
        if c == '"':
            return self._ler_cadeia(linha, coluna)
        return self._ler_operador(linha, coluna)

    def tokens(self) -> Iterator[Token]:
        """Itera os tokens da fonte, emitindo `EOF` por último."""
        while True:
            tok = self.proximo_token()
            yield tok
            if tok.type is TokenType.EOF:
                return

    # --- estados do DFA ---

    def _ler_identificador(self, linha: int, coluna: int) -> Token:
        chars: list[str] = []
        c = self._peek()
        while c and (c.isalnum() or c == "_"):
            chars.append(self._avancar())
            c = self._peek()
        lexema = "".join(chars)
        tipo = self.PALAVRAS_CHAVE.get(lexema, TokenType.IDENT)
        if tipo is TokenType.IDENT:
            self.tabela.registrar_ocorrencia(lexema, linha, coluna)
        return Token(tipo, lexema, linha, coluna)

    def _ler_numero(self, linha: int, coluna: int) -> Token:
        chars: list[str] = []
        while self._peek().isdigit():
            chars.append(self._avancar())

        eh_float = False
        if self._peek() == ".":
            eh_float = True
            chars.append(self._avancar())
            if not self._peek().isdigit():
                # número malformado: falta a parte fracionária (ex.: '12.').
                raise LexicalError(
                    linha, coluna, f"número malformado: '{''.join(chars)}'"
                )
            while self._peek().isdigit():
                chars.append(self._avancar())
            if self._peek() == ".":
                # número malformado: segundo ponto decimal (ex.: '1.2.3').
                chars.append(self._avancar())
                raise LexicalError(
                    linha, coluna, f"número malformado: '{''.join(chars)}'"
                )

        tipo = TokenType.FLOAT_CONST if eh_float else TokenType.INT_CONST
        return Token(tipo, "".join(chars), linha, coluna)

    def _ler_cadeia(self, linha: int, coluna: int) -> Token:
        chars: list[str] = [self._avancar()]
        while True:
            c = self._peek()
            if c == "" or c == "\n":
                raise LexicalError(
                    linha, coluna, "constante de cadeia (string) não fechada"
                )
            chars.append(self._avancar())
            if c == '"':
                break
        return Token(TokenType.STRING_CONST, "".join(chars), linha, coluna)

    def _ler_operador(self, linha: int, coluna: int) -> Token:
        c = self._peek()

        if c == "<":
            self._avancar()
            if self._peek() == "=":
                self._avancar()
                return Token(TokenType.LE, "<=", linha, coluna)
            return Token(TokenType.LT, "<", linha, coluna)
        if c == ">":
            self._avancar()
            if self._peek() == "=":
                self._avancar()
                return Token(TokenType.GE, ">=", linha, coluna)
            return Token(TokenType.GT, ">", linha, coluna)
        if c == "=":
            self._avancar()
            if self._peek() == "=":
                self._avancar()
                return Token(TokenType.EQ, "==", linha, coluna)
            return Token(TokenType.ASSIGN, "=", linha, coluna)
        if c == "!":
            self._avancar()
            if self._peek() == "=":
                self._avancar()
                return Token(TokenType.NE, "!=", linha, coluna)
            raise LexicalError(linha, coluna, "caractere inválido: '!'")

        if c in self.SIMBOLOS:
            self._avancar()
            return Token(self.SIMBOLOS[c], c, linha, coluna)

        self._avancar()
        raise LexicalError(linha, coluna, f"caractere inválido: '{c}'")
