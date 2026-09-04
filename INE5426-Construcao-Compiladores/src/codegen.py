from .ast_nodes import ParseNode


class CodeGen:
    """Gerador de código de três endereços (TAC) dirigido pela sintaxe."""

    def __init__(self):
        self.codigo: list[str] = []
        self._n_temp = 0
        self._n_rotulo = 0
        # Pilha dos rótulos de saída dos ``for`` abertos: alvo de ``break``.
        self._fim_for: list[str] = []

    # --- primitivas ----------------------------------------------------------

    def novo_temp(self) -> str:
        """Próximo temporário ``tN`` (numeração determinística)."""
        self._n_temp += 1
        return f"t{self._n_temp}"

    def novo_rotulo(self) -> str:
        """Próximo rótulo ``LN`` (numeração determinística)."""
        self._n_rotulo += 1
        return f"L{self._n_rotulo}"

    def emit(self, instr: str) -> None:
        """Anexa uma instrução TAC ao código."""
        self.codigo.append(instr)

    def gerar(self, arvore: ParseNode) -> list[str]:
        """Gera e devolve a lista de instruções TAC da árvore de derivação."""
        self._gen(arvore)
        return self.codigo

    # --- despacho por construção --------------------------------------------

    def _gen(self, no: ParseNode) -> None:
        s = no.simbolo
        if s == "FUNCDEF":
            self._gen_funcdef(no)
            return
        if s == "VARDECL":
            return  # declarações não emitem código
        if s == "ATRIBSTAT":
            self._gen_atribstat(no)
            return
        if s == "PRINTSTAT":
            self._gen_printstat(no)
            return
        if s == "READSTAT":
            self._gen_readstat(no)
            return
        if s == "RETURNSTAT":
            self.emit("return")
            return
        if s == "IFSTAT":
            self._gen_ifstat(no)
            return
        if s == "FORSTAT":
            self._gen_forstat(no)
            return
        if s == "BREAK":
            # break → salta para o rótulo de saída do for corrente.
            self.emit(f"goto {self._fim_for[-1]}")
            return
        for f in no.filhos:
            self._gen(f)

    # --- funções -------------------------------------------------------------

    def _gen_funcdef(self, no: ParseNode) -> None:
        nome = no.filhos[1].token.lexeme
        self.emit(f"func {nome}:")
        self._gen(no.filhos[6])

    def _gen_funccall(self, no: ParseNode) -> str:
        nome = no.filhos[0].token.lexeme
        args = self._args(no.filhos[2])
        for a in args:
            self.emit(f"param {a}")
        t = self.novo_temp()
        self.emit(f"{t} = call {nome}, {len(args)}")
        return t

    @staticmethod
    def _args(paramlistcall: ParseNode) -> list[str]:
        nomes: list[str] = []
        no = paramlistcall
        while no.filhos:
            nomes.append(no.filhos[0].token.lexeme)
            resto = no.filhos[1]
            if resto.filhos:
                no = resto.filhos[1]
            else:
                break
        return nomes

    # --- comandos ------------------------------------------------------------

    def _gen_atribstat(self, no: ParseNode) -> None:
        lvalue = no.filhos[0]
        rhs = no.filhos[2].filhos[0]
        if rhs.simbolo == "EXPRESSION":
            valor = self._gen_expression(rhs)
        elif rhs.simbolo == "ALLOCEXPRESSION":
            valor = self._gen_allocexpression(rhs)
        else:
            valor = self._gen_funccall(rhs)
        alvo = self._lvalue_alvo(lvalue)
        self.emit(f"{alvo} = {valor}")

    def _gen_printstat(self, no: ParseNode) -> None:
        self.emit(f"print {self._gen_expression(no.filhos[1])}")

    def _gen_readstat(self, no: ParseNode) -> None:
        self.emit(f"read {self._lvalue_alvo(no.filhos[1])}")

    # if/for/break seguem o padrão dragon-book: ``ifFalse cond goto L`` pula o
    # bloco e os rótulos delimitam then/else, início/saída do laço.
    def _gen_ifstat(self, no: ParseNode) -> None:
        cond = self._gen_expression(no.filhos[2])
        then_stmt = no.filhos[4]
        ifstat_linha = no.filhos[5]
        if ifstat_linha.filhos:
            l_else = self.novo_rotulo()
            l_fim = self.novo_rotulo()
            self.emit(f"ifFalse {cond} goto {l_else}")
            self._gen(then_stmt)
            self.emit(f"goto {l_fim}")
            self.emit(f"{l_else}:")
            self._gen(ifstat_linha.filhos[1])
            self.emit(f"{l_fim}:")
        else:
            l_fim = self.novo_rotulo()
            self.emit(f"ifFalse {cond} goto {l_fim}")
            self._gen(then_stmt)
            self.emit(f"{l_fim}:")

    def _gen_forstat(self, no: ParseNode) -> None:
        self._gen_atribstat(no.filhos[2])
        l_inicio = self.novo_rotulo()
        l_fim = self.novo_rotulo()
        self.emit(f"{l_inicio}:")
        cond = self._gen_expression(no.filhos[4])
        self.emit(f"ifFalse {cond} goto {l_fim}")
        self._fim_for.append(l_fim)
        self._gen(no.filhos[8])
        self._fim_for.pop()
        self._gen_atribstat(no.filhos[6])
        self.emit(f"goto {l_inicio}")
        self.emit(f"{l_fim}:")

    # --- alocação ------------------------------------------------------------

    def _gen_allocexpression(self, no: ParseNode) -> str:
        tipo = no.filhos[1].filhos[0].token.lexeme
        dims = [self._gen_numexpression(no.filhos[3])]
        resto = no.filhos[5]
        while resto.filhos:
            dims.append(self._gen_numexpression(resto.filhos[1]))
            resto = resto.filhos[3]
        t = self.novo_temp()
        self.emit(f"{t} = new {tipo}{''.join(f'[{d}]' for d in dims)}")
        return t

    # --- lvalue (leitura e alvo de escrita) ----------------------------------

    def _lvalue_carga(self, no: ParseNode) -> str:
        lugar = no.filhos[0].token.lexeme
        for idx in self._indices(no.filhos[1]):
            t = self.novo_temp()
            self.emit(f"{t} = {lugar}[{idx}]")
            lugar = t
        return lugar

    def _lvalue_alvo(self, no: ParseNode) -> str:
        # Último índice é a escrita; índices anteriores viram cargas.
        nome = no.filhos[0].token.lexeme
        indices = self._indices(no.filhos[1])
        if not indices:
            return nome
        lugar = nome
        for idx in indices[:-1]:
            t = self.novo_temp()
            self.emit(f"{t} = {lugar}[{idx}]")
            lugar = t
        return f"{lugar}[{indices[-1]}]"

    def _indices(self, lvalue_linha: ParseNode) -> list[str]:
        res: list[str] = []
        no = lvalue_linha
        while no.filhos:
            res.append(self._gen_numexpression(no.filhos[1]))
            no = no.filhos[3]
        return res

    # --- expressões ----------------------------------------------------------
    # Precedência/associatividade reaproveitam o mesmo colapso de semantic.py
    # (GCI-02): ``* / %`` (TERM') liga mais forte que ``+ -`` (NUMEXPR'), ambos
    # à esquerda; o relacional (EXPRESSION') fica no topo. Cada gerador devolve
    # o lugar do resultado (temporário, nome ou constante).

    def _gen_expression(self, no: ParseNode) -> str:
        esq = self._gen_numexpression(no.filhos[0])
        linha = no.filhos[1]
        if linha.filhos:
            op = linha.filhos[0].token.lexeme
            dir_ = self._gen_numexpression(linha.filhos[1])
            t = self.novo_temp()
            self.emit(f"{t} = {esq} {op} {dir_}")
            return t
        return esq

    def _gen_numexpression(self, no: ParseNode) -> str:
        esq = self._gen_term(no.filhos[0])
        prime = no.filhos[1]
        while prime.filhos:
            op = prime.filhos[0].token.lexeme
            dir_ = self._gen_term(prime.filhos[1])
            t = self.novo_temp()
            self.emit(f"{t} = {esq} {op} {dir_}")
            esq = t
            prime = prime.filhos[2]
        return esq

    def _gen_term(self, no: ParseNode) -> str:
        esq = self._gen_unaryexpr(no.filhos[0])
        prime = no.filhos[1]
        while prime.filhos:
            op = prime.filhos[0].token.lexeme
            dir_ = self._gen_unaryexpr(prime.filhos[1])
            t = self.novo_temp()
            self.emit(f"{t} = {esq} {op} {dir_}")
            esq = t
            prime = prime.filhos[2]
        return esq

    def _gen_unaryexpr(self, no: ParseNode) -> str:
        if len(no.filhos) == 1:
            return self._gen_factor(no.filhos[0])
        op = no.filhos[0].token.lexeme
        operando = self._gen_factor(no.filhos[1])
        t = self.novo_temp()
        self.emit(f"{t} = {op}{operando}")
        return t

    def _gen_factor(self, no: ParseNode) -> str:
        prim = no.filhos[0]
        s = prim.simbolo
        if s in ("INT_CONST", "FLOAT_CONST", "STRING_CONST", "NULL"):
            return prim.token.lexeme
        if s == "LVALUE":
            return self._lvalue_carga(prim)
        return self._gen_numexpression(no.filhos[1])
