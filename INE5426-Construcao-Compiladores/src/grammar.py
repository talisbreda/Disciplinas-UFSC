from .tokens import TokenType

EPSILON = "ε"
FIM = TokenType.EOF
INICIO = "PROGRAM"
_T = TokenType

# NT -> lista de alternativas; cada alternativa é uma lista de símbolos
# (TokenType terminal | str não-terminal | EPSILON). Ordem irrelevante em LL(1).
PRODUCOES: dict[str, list[list]] = {
    "PROGRAM": [
        ["STATEMENT"],
        ["FUNCLIST"],
        [EPSILON],
    ],
    # Fatoração à esquerda (FUNCDEF comum); FUNCLIST' realiza o '*' do EBNF.
    "FUNCLIST": [
        ["FUNCDEF", "FUNCLIST'"],
    ],
    "FUNCLIST'": [
        ["FUNCDEF", "FUNCLIST'"],
        [EPSILON],
    ],
    "FUNCDEF": [
        [_T.DEF, _T.IDENT, _T.LPAREN, "PARAMLIST", _T.RPAREN,
         _T.LBRACE, "STATELIST", _T.RBRACE],
    ],
    "PARAMLIST": [
        ["TYPE", _T.IDENT, "PARAMLIST'"],
        [EPSILON],
    ],
    "PARAMLIST'": [
        [_T.COMMA, "PARAMLIST"],
        [EPSILON],
    ],
    # Auxiliar de fatoração: tipo comum a VARDECL, PARAMLIST e ALLOCEXPRESSION.
    "TYPE": [
        [_T.INT],
        [_T.FLOAT],
        [_T.STRING],
    ],
    "STATEMENT": [
        ["VARDECL", _T.SEMI],
        ["ATRIBSTAT", _T.SEMI],
        ["PRINTSTAT", _T.SEMI],
        ["READSTAT", _T.SEMI],
        ["RETURNSTAT", _T.SEMI],
        ["IFSTAT"],
        ["FORSTAT"],
        [_T.LBRACE, "STATELIST", _T.RBRACE],
        [_T.BREAK, _T.SEMI],
        [_T.SEMI],
    ],
    "VARDECL": [
        ["TYPE", _T.IDENT, "VARDECL'"],
    ],
    "VARDECL'": [
        [_T.LBRACK, _T.INT_CONST, _T.RBRACK, "VARDECL'"],
        [EPSILON],
    ],
    # Fatora o prefixo comum "LVALUE =" (EXPRESSION/ALLOCEXPRESSION/FUNCCALL).
    "ATRIBSTAT": [
        ["LVALUE", _T.ASSIGN, "ATRIBSTAT_RHS"],
    ],
    "ATRIBSTAT_RHS": [
        ["EXPRESSION"],
        ["ALLOCEXPRESSION"],
        ["FUNCCALL"],
    ],
    "FUNCCALL": [
        [_T.IDENT, _T.LPAREN, "PARAMLISTCALL", _T.RPAREN],
    ],
    "PARAMLISTCALL": [
        [_T.IDENT, "PARAMLISTCALL'"],
        [EPSILON],
    ],
    "PARAMLISTCALL'": [
        [_T.COMMA, "PARAMLISTCALL"],
        [EPSILON],
    ],
    "PRINTSTAT": [
        [_T.PRINT, "EXPRESSION"],
    ],
    "READSTAT": [
        [_T.READ, "LVALUE"],
    ],
    "RETURNSTAT": [
        [_T.RETURN],
    ],
    "IFSTAT": [
        [_T.IF, _T.LPAREN, "EXPRESSION", _T.RPAREN, "STATEMENT", "IFSTAT'"],
    ],
    # IFSTAT' realiza o 'else' opcional; conflito dangling-else resolvido na tabela.
    "IFSTAT'": [
        [_T.ELSE, "STATEMENT"],
        [EPSILON],
    ],
    "FORSTAT": [
        [_T.FOR, _T.LPAREN, "ATRIBSTAT", _T.SEMI, "EXPRESSION", _T.SEMI,
         "ATRIBSTAT", _T.RPAREN, "STATEMENT"],
    ],
    "STATELIST": [
        ["STATEMENT", "STATELIST'"],
    ],
    "STATELIST'": [
        ["STATEMENT", "STATELIST'"],
        [EPSILON],
    ],
    # '+' (>= 1 dimensão): a 1ª dimensão é obrigatória; ALLOCEXPRESSION' repete.
    "ALLOCEXPRESSION": [
        [_T.NEW, "TYPE", _T.LBRACK, "NUMEXPRESSION", _T.RBRACK,
         "ALLOCEXPRESSION'"],
    ],
    "ALLOCEXPRESSION'": [
        [_T.LBRACK, "NUMEXPRESSION", _T.RBRACK, "ALLOCEXPRESSION'"],
        [EPSILON],
    ],
    "EXPRESSION": [
        ["NUMEXPRESSION", "EXPRESSION'"],
    ],
    "EXPRESSION'": [
        [_T.LT, "NUMEXPRESSION"],
        [_T.GT, "NUMEXPRESSION"],
        [_T.LE, "NUMEXPRESSION"],
        [_T.GE, "NUMEXPRESSION"],
        [_T.EQ, "NUMEXPRESSION"],
        [_T.NE, "NUMEXPRESSION"],
        [EPSILON],
    ],
    "NUMEXPRESSION": [
        ["TERM", "NUMEXPR'"],
    ],
    "NUMEXPR'": [
        [_T.PLUS, "TERM", "NUMEXPR'"],
        [_T.MINUS, "TERM", "NUMEXPR'"],
        [EPSILON],
    ],
    "TERM": [
        ["UNARYEXPR", "TERM'"],
    ],
    "TERM'": [
        [_T.STAR, "UNARYEXPR", "TERM'"],
        [_T.SLASH, "UNARYEXPR", "TERM'"],
        [_T.PERCENT, "UNARYEXPR", "TERM'"],
        [EPSILON],
    ],
    "UNARYEXPR": [
        [_T.PLUS, "FACTOR"],
        [_T.MINUS, "FACTOR"],
        ["FACTOR"],
    ],
    "FACTOR": [
        [_T.INT_CONST],
        [_T.FLOAT_CONST],
        [_T.STRING_CONST],
        [_T.NULL],
        ["LVALUE"],
        [_T.LPAREN, "NUMEXPRESSION", _T.RPAREN],
    ],
    "LVALUE": [
        [_T.IDENT, "LVALUE'"],
    ],
    "LVALUE'": [
        [_T.LBRACK, "NUMEXPRESSION", _T.RBRACK, "LVALUE'"],
        [EPSILON],
    ],
}

NAO_TERMINAIS: frozenset[str] = frozenset(PRODUCOES)


def eh_terminal(simbolo) -> bool:
    """True se ``simbolo`` é um terminal (membro de ``TokenType``)."""
    return isinstance(simbolo, TokenType)


def eh_nao_terminal(simbolo) -> bool:
    """True se ``simbolo`` é um não-terminal (str diferente de ``ε``)."""
    return isinstance(simbolo, str) and simbolo != EPSILON


# ---------------------------------------------------------------------------
# FIRST e FOLLOW (ponto-fixo)
# ---------------------------------------------------------------------------

def _first_sequencia(seq: list, first: dict) -> set:
    """FIRST de uma sequência; inclui EPSILON se toda ela for anulável (ou vazia)."""
    if seq == [EPSILON] or not seq:
        return {EPSILON}
    res: set = set()
    todos_anulaveis = True
    for sim in seq:
        if eh_terminal(sim):
            res.add(sim)
            todos_anulaveis = False
            break
        fs = first[sim]
        res |= fs - {EPSILON}
        if EPSILON not in fs:
            todos_anulaveis = False
            break
    if todos_anulaveis:
        res.add(EPSILON)
    return res


def _calcular_first() -> dict:
    first = {nt: set() for nt in PRODUCOES}
    mudou = True
    while mudou:
        mudou = False
        for nt, alts in PRODUCOES.items():
            for alt in alts:
                novo = _first_sequencia(alt, first)
                if not novo <= first[nt]:
                    first[nt] |= novo
                    mudou = True
    return first


def _calcular_follow() -> dict:
    first = _first_table()
    follow = {nt: set() for nt in PRODUCOES}
    follow[INICIO].add(FIM)
    mudou = True
    while mudou:
        mudou = False
        for cabeca, alts in PRODUCOES.items():
            for alt in alts:
                if alt == [EPSILON]:
                    continue
                for i, sim in enumerate(alt):
                    if not eh_nao_terminal(sim):
                        continue
                    resto = alt[i + 1:]
                    f_resto = _first_sequencia(resto, first)
                    adicao = f_resto - {EPSILON}
                    if not adicao <= follow[sim]:
                        follow[sim] |= adicao
                        mudou = True
                    if EPSILON in f_resto:
                        if not follow[cabeca] <= follow[sim]:
                            follow[sim] |= follow[cabeca]
                            mudou = True
    return follow


_FIRST: dict | None = None
_FOLLOW: dict | None = None


def _first_table() -> dict:
    global _FIRST
    if _FIRST is None:
        _FIRST = _calcular_first()
    return _FIRST


def _follow_table() -> dict:
    global _FOLLOW
    if _FOLLOW is None:
        _FOLLOW = _calcular_follow()
    return _FOLLOW


def first(simbolo) -> set:
    """FIRST de um símbolo (terminal, ε ou NT); cópia para NT, com EPSILON se anulável."""
    if eh_terminal(simbolo):
        return {simbolo}
    if simbolo == EPSILON:
        return {EPSILON}
    if simbolo in PRODUCOES:
        return set(_first_table()[simbolo])
    raise ValueError(f"símbolo desconhecido: {simbolo!r}")


def follow(nt: str) -> set:
    """FOLLOW de um não-terminal (cópia). Nunca contém :data:`EPSILON`."""
    if nt not in PRODUCOES:
        raise ValueError(f"não-terminal desconhecido: {nt!r}")
    return set(_follow_table()[nt])


# ---------------------------------------------------------------------------
# Tabela preditiva LL(1) (construída uma única vez)
# ---------------------------------------------------------------------------

class ConflitoLL1(Exception):
    """Conflito LL(1) **não** documentado encontrado na construção da tabela."""


# Conflitos LL(1) aceitos por decisão documentada (spec/Assumptions); qualquer
# outro derruba a construção (ConflitoLL1).
RESOLUCOES_DOCUMENTADAS: dict[tuple[str, TokenType], dict] = {
    # dangling-else: o 'else' casa com o 'if' mais próximo → escolhe o ramo
    # FIRST (else STATEMENT) sobre o ε em [IFSTAT', else].
    ("IFSTAT'", TokenType.ELSE): {
        "producao": [TokenType.ELSE, "STATEMENT"],
        "motivo": "dangling-else: o 'else' casa com o 'if' mais próximo",
    },
    # ATRIBSTAT/ident: ident ∈ FIRST(EXPRESSION) (via LVALUE) ∩ FIRST(FUNCCALL).
    # A célula registra FUNCCALL ('ident (' ⇒ FUNCCALL); o parser refina com 1
    # token extra de lookahead (se o token após 'ident' não for '(', usa
    # EXPRESSION/LVALUE).
    ("ATRIBSTAT_RHS", TokenType.IDENT): {
        "producao": ["FUNCCALL"],
        "motivo": ("ATRIBSTAT/ident: 'ident (' => FUNCCALL; senão "
                   "EXPRESSION/LVALUE (refinado por 1 lookahead no parser)"),
    },
}

_PARSE_TABLE: dict | None = None
_CONFLITOS_RESOLVIDOS: list | None = None


def _inserir_celula(tabela: dict, resolvidos: list,
                    nt: str, terminal: TokenType, alt: list) -> None:
    chave = (nt, terminal)
    existente = tabela.get(chave)
    if existente is None or existente == alt:
        tabela[chave] = alt
        return
    # Colisão: só aceitável se for uma resolução documentada.
    doc = RESOLUCOES_DOCUMENTADAS.get(chave)
    if doc is None:
        raise ConflitoLL1(
            f"Conflito LL(1) não resolvido em [{nt}, {terminal.name}]: "
            f"{existente} vs {alt}"
        )
    tabela[chave] = doc["producao"]
    registro = {
        "nt": nt,
        "terminal": terminal,
        "escolhida": doc["producao"],
        "motivo": doc["motivo"],
    }
    if registro not in resolvidos:
        resolvidos.append(registro)


def build_parse_table() -> dict:
    """Constrói (uma vez, memoizada - AS-01) a tabela preditiva LL(1); colisões
    não documentadas derrubam a construção (:class:`ConflitoLL1`)."""
    global _PARSE_TABLE, _CONFLITOS_RESOLVIDOS
    if _PARSE_TABLE is not None:
        return _PARSE_TABLE
    first = _first_table()
    follow_ = _follow_table()
    tabela: dict = {}
    resolvidos: list = []
    for nt, alts in PRODUCOES.items():
        for alt in alts:
            f_alt = _first_sequencia(alt, first)
            destinos = {t for t in f_alt if t != EPSILON}
            if EPSILON in f_alt:
                destinos |= follow_[nt]
            for terminal in destinos:
                _inserir_celula(tabela, resolvidos, nt, terminal, alt)
    _PARSE_TABLE = tabela
    _CONFLITOS_RESOLVIDOS = resolvidos
    return _PARSE_TABLE


def conflitos_resolvidos() -> list:
    """Lista (cópia) dos conflitos resolvidos por decisão documentada."""
    if _CONFLITOS_RESOLVIDOS is None:
        build_parse_table()
    return list(_CONFLITOS_RESOLVIDOS)
