from .tokens import Token, TokenType
from .errors import SyntaxError_
from .grammar import (
    EPSILON,
    FIM,
    INICIO,
    build_parse_table,
    eh_terminal,
)
from .ast_nodes import ParseNode


# Representação legível (PT) de cada terminal, para mensagens de erro.
_NOME_TERMINAL: dict[TokenType, str] = {
    TokenType.DEF: "'def'",
    TokenType.INT: "'int'",
    TokenType.FLOAT: "'float'",
    TokenType.STRING: "'string'",
    TokenType.PRINT: "'print'",
    TokenType.READ: "'read'",
    TokenType.RETURN: "'return'",
    TokenType.IF: "'if'",
    TokenType.ELSE: "'else'",
    TokenType.FOR: "'for'",
    TokenType.BREAK: "'break'",
    TokenType.NEW: "'new'",
    TokenType.NULL: "'null'",
    TokenType.IDENT: "identificador",
    TokenType.INT_CONST: "constante inteira",
    TokenType.FLOAT_CONST: "constante real",
    TokenType.STRING_CONST: "constante de cadeia",
    TokenType.LPAREN: "'('",
    TokenType.RPAREN: "')'",
    TokenType.LBRACE: "'{'",
    TokenType.RBRACE: "'}'",
    TokenType.LBRACK: "'['",
    TokenType.RBRACK: "']'",
    TokenType.SEMI: "';'",
    TokenType.COMMA: "','",
    TokenType.ASSIGN: "'='",
    TokenType.LT: "'<'",
    TokenType.GT: "'>'",
    TokenType.LE: "'<='",
    TokenType.GE: "'>='",
    TokenType.EQ: "'=='",
    TokenType.NE: "'!='",
    TokenType.PLUS: "'+'",
    TokenType.MINUS: "'-'",
    TokenType.STAR: "'*'",
    TokenType.SLASH: "'/'",
    TokenType.PERCENT: "'%'",
    TokenType.EOF: "fim de arquivo",
}


def _nome_terminal(terminal: TokenType) -> str:
    return _NOME_TERMINAL.get(terminal, terminal.name)


class Parser:
    """Parser preditivo LL(1) dirigido por tabela (pilha explícita)."""

    def __init__(self, tokens, tabela_ll1=None):
        self.tokens = list(tokens)
        self.tabela = (
            tabela_ll1 if tabela_ll1 is not None else build_parse_table()
        )
        self.pos = 0

    def _atual(self) -> Token:
        if self.pos < len(self.tokens):
            return self.tokens[self.pos]
        return self.tokens[-1]

    def _proximo(self) -> Token:
        """Token seguinte ao corrente (1 token extra de lookahead)."""
        i = self.pos + 1
        if i < len(self.tokens):
            return self.tokens[i]
        return self.tokens[-1]

    def _avancar(self) -> None:
        if self.pos < len(self.tokens) - 1:
            self.pos += 1

    def _descr_atual(self, tok: Token) -> str:
        if tok.type is TokenType.EOF:
            return "fim de arquivo"
        return f"'{tok.lexeme}'"

    def _esperados(self, nt: str) -> str:
        terminais = sorted(
            (t for (n, t) in self.tabela if n == nt),
            key=lambda t: t.name,
        )
        return ", ".join(_nome_terminal(t) for t in terminais)

    def _escolher_producao(self, nt: str, tok: Token):
        # dangling-else é resolvido pela própria tabela (else casa com o if mais
        # próximo); aqui tratamos apenas o conflito ATRIBSTAT/ident.
        #
        # Resolução ATRIBSTAT/ident: a tabela registra FUNCCALL em
        # [ATRIBSTAT_RHS, ident], mas a decisão exige 1 token extra de lookahead
        # após o `ident`: se for `(` ⇒ FUNCCALL; senão ⇒ EXPRESSION (via LVALUE).
        producao = self.tabela.get((nt, tok.type))
        if producao is None:
            return None
        if nt == "ATRIBSTAT_RHS" and tok.type is TokenType.IDENT:
            if self._proximo().type is not TokenType.LPAREN:
                return ["EXPRESSION"]
        return producao

    def parse(self) -> ParseNode:
        """Analisa a entrada e devolve a árvore de derivação (raiz ``PROGRAM``).

        Levanta :class:`~src.errors.SyntaxError_` no primeiro erro sintático,
        com ``(linha, coluna)`` do token problemático e o esperado/encontrado.
        """
        raiz = ParseNode(INICIO)
        fim = ParseNode("$")
        # Pilha de pares (símbolo, nó); topo = fim da lista. O marcador de fim
        # ($/EOF) vai sob o início.
        pilha: list[tuple] = [(FIM, fim), (INICIO, raiz)]

        while pilha:
            simbolo, no = pilha.pop()
            tok = self._atual()

            if eh_terminal(simbolo):
                if tok.type is simbolo:
                    no.token = tok
                    self._avancar()
                    continue
                raise SyntaxError_(
                    tok.line,
                    tok.col,
                    f"esperado {_nome_terminal(simbolo)}, "
                    f"encontrado {self._descr_atual(tok)}",
                )

            producao = self._escolher_producao(simbolo, tok)
            if producao is None:
                raise SyntaxError_(
                    tok.line,
                    tok.col,
                    f"esperado um de {{{self._esperados(simbolo)}}}, "
                    f"encontrado {self._descr_atual(tok)}",
                )

            # Empilha os filhos (ignorando ε) em ordem reversa p/ processá-los
            # da esquerda para a direita.
            novos: list[tuple] = []
            for sim in producao:
                if sim == EPSILON:
                    continue
                filho = ParseNode(sim.name if eh_terminal(sim) else sim)
                no.filhos.append(filho)
                novos.append((sim, filho))
            pilha.extend(reversed(novos))

        return raiz
