from .ast_nodes import ParseNode, ExprNode
from .symbol_table import SymbolTable, Scope
from .errors import SemanticError


class SemanticAnalyzer:
    """Travessias semânticas L-atribuídas sobre a árvore de derivação."""

    def __init__(self, arvore: ParseNode, tabela: SymbolTable):
        self.arvore = arvore
        self.tabela = tabela

    # === ASEM-01 (T10): árvore de expressão ==================================

    def construir_arvores_expressao(self) -> list[ExprNode]:
        """Uma ExprNode por EXPRESSION, em pré-ordem (precedência e assoc. à esquerda)."""
        arvores: list[ExprNode] = []
        self._coletar_expressoes(self.arvore, arvores)
        return arvores

    def _coletar_expressoes(self, no: ParseNode, acc: list[ExprNode]) -> None:
        if no.simbolo == "EXPRESSION":
            acc.append(self._expr_de_expression(no))
            return
        for f in no.filhos:
            self._coletar_expressoes(f, acc)

    # --- colapso das cadeias right-recursive em árvore binária --------------
    # Precedência e associatividade à esquerda: '* / %' (TERM') ligam mais forte
    # que '+ -' (NUMEXPR'); relacionais (EXPRESSION') ficam no topo.

    def _expr_de_expression(self, no: ParseNode) -> ExprNode:
        esq = self._expr_de_numexpression(no.filhos[0])
        linha = no.filhos[1]
        if linha.filhos:
            op = linha.filhos[0]
            dir_ = self._expr_de_numexpression(linha.filhos[1])
            return ExprNode(op.token.lexeme, esq, dir_, token=op.token)
        return esq

    def _expr_de_numexpression(self, no: ParseNode) -> ExprNode:
        esq = self._expr_de_term(no.filhos[0])
        prime = no.filhos[1]
        while prime.filhos:
            op = prime.filhos[0]
            dir_ = self._expr_de_term(prime.filhos[1])
            esq = ExprNode(op.token.lexeme, esq, dir_, token=op.token)
            prime = prime.filhos[2]
        return esq

    def _expr_de_term(self, no: ParseNode) -> ExprNode:
        esq = self._expr_de_unaryexpr(no.filhos[0])
        prime = no.filhos[1]
        while prime.filhos:
            op = prime.filhos[0]
            dir_ = self._expr_de_unaryexpr(prime.filhos[1])
            esq = ExprNode(op.token.lexeme, esq, dir_, token=op.token)
            prime = prime.filhos[2]
        return esq

    def _expr_de_unaryexpr(self, no: ParseNode) -> ExprNode:
        if len(no.filhos) == 1:
            return self._expr_de_factor(no.filhos[0])
        op = no.filhos[0]
        operando = self._expr_de_factor(no.filhos[1])
        return ExprNode(op.token.lexeme, esq=None, dir=operando, token=op.token)

    def _expr_de_factor(self, no: ParseNode) -> ExprNode:
        prim = no.filhos[0]
        s = prim.simbolo
        if s == "INT_CONST":
            return ExprNode(prim.token.lexeme, tipo="int", token=prim.token)
        if s == "FLOAT_CONST":
            return ExprNode(prim.token.lexeme, tipo="float", token=prim.token)
        if s == "STRING_CONST":
            return ExprNode(prim.token.lexeme, tipo="string", token=prim.token)
        if s == "NULL":
            return ExprNode(prim.token.lexeme, token=prim.token)
        if s == "LVALUE":
            return self._expr_de_lvalue(prim)
        return self._expr_de_numexpression(no.filhos[1])

    def _expr_de_lvalue(self, no: ParseNode) -> ExprNode:
        ident = no.filhos[0]
        return ExprNode(ident.token.lexeme, token=ident.token)

    # === ASEM-02 (T11): inserção de tipo na tabela (DEC) =====================

    def inserir_tipos(self) -> None:
        """Insere o tipo de cada declaração na tabela, por escopo (SDD DEC)."""
        self._tipos_walk(self.arvore)

    def _tipos_walk(self, no: ParseNode) -> None:
        s = no.simbolo
        # push/pop de escopo em FUNCDEF / { STATELIST } / for / if: declarações
        # em escopos aninhados distintos não se misturam.
        if s == "FUNCDEF":
            self.tabela.push_scope()
            self._declarar_params(no.filhos[3])
            self._tipos_walk(no.filhos[6])
            self.tabela.pop_scope()
            return
        if s == "VARDECL":
            tipo = self._tipo_de_type(no.filhos[0])
            nome = no.filhos[1].token
            dims = self._dimensoes(no.filhos[2])
            self.tabela.declarar(nome.lexeme, tipo=tipo, dimensoes=dims,
                                 linha=nome.line, coluna=nome.col)
            return
        if self._eh_bloco(no) or s in ("FORSTAT", "IFSTAT"):
            self.tabela.push_scope()
            for f in no.filhos:
                self._tipos_walk(f)
            self.tabela.pop_scope()
            return
        for f in no.filhos:
            self._tipos_walk(f)

    # --- auxiliares de declaração (DEC) -------------------------------------

    @staticmethod
    def _eh_bloco(no: ParseNode) -> bool:
        return (no.simbolo == "STATEMENT" and bool(no.filhos)
                and no.filhos[0].simbolo == "LBRACE")

    @staticmethod
    def _tipo_de_type(type_node: ParseNode) -> str:
        return type_node.filhos[0].token.lexeme

    @staticmethod
    def _dimensoes(vardecl_linha: ParseNode) -> list[int]:
        dims: list[int] = []
        no = vardecl_linha
        while no.filhos:
            dims.append(int(no.filhos[1].token.lexeme))
            no = no.filhos[3]
        return dims

    def _declarar_params(self, paramlist: ParseNode) -> None:
        no = paramlist
        while no.filhos:
            tipo = self._tipo_de_type(no.filhos[0])
            nome = no.filhos[1].token
            self.tabela.declarar(nome.lexeme, tipo=tipo,
                                 linha=nome.line, coluna=nome.col)
            resto = no.filhos[2]
            if resto.filhos:
                no = resto.filhos[1]
            else:
                break

    # === ASEM-03 (T12): verificação de tipos em expressões ===================

    def verificar_tipos(self) -> list[ExprNode]:
        """Verificação ESTRITA: operandos do mesmo tipo, sem promoção int↔float
        (segue a spec ao pé da letra, ASEM-03); devolve as árvores tipadas."""
        arvores = self.construir_arvores_expressao()
        for raiz in arvores:
            self._tipo_no(raiz)
        return arvores

    def _tipo_no(self, no: ExprNode) -> str:
        if no.esq is None and no.dir is None:
            if no.tipo is not None:
                return no.tipo
            sym = (self.tabela.resolver(no.valor)
                   or self.tabela.simbolo_lexico(no.valor))
            if sym is None or sym.tipo is None:
                self._erro_no(no, f"identificador '{no.valor}' sem tipo "
                                  f"declarado")
            no.tipo = sym.tipo
            return no.tipo
        if no.esq is None:
            no.tipo = self._tipo_no(no.dir)
            return no.tipo
        # Estrito: operandos devem ter o mesmo tipo (int+float é erro).
        t_esq = self._tipo_no(no.esq)
        t_dir = self._tipo_no(no.dir)
        if t_esq != t_dir:
            self._erro_no(no, f"operação '{no.valor}' com operandos de tipos "
                              f"diferentes: '{t_esq}' e '{t_dir}'")
        no.tipo = t_esq
        return no.tipo

    @staticmethod
    def _erro_no(no: ExprNode, mensagem: str):
        tok = no.token
        linha = tok.line if tok is not None else 0
        coluna = tok.col if tok is not None else 0
        raise SemanticError(linha, coluna, mensagem)

    # === ASEM-04 (T13): verificação de identificadores por escopo ============

    def verificar_escopos(self) -> None:
        """Declaração/uso de identificadores por escopo, com push/pop em
        FUNCDEF/{STATELIST}/for/if; redeclaração no mesmo escopo é erro (ASEM-04)."""
        # FIX: reinicia a pilha de escopos (base limpa) antes de andar a árvore,
        # para não ver as declarações de escopo base feitas por inserir_tipos
        # (corrige falso "já declarado"; ex.: programa de um único VARDECL no
        # escopo base). A visão léxica global e os tipos já inseridos são
        # preservados (verificar_tipos roda ANTES).
        self.tabela.scopes = [Scope(nivel=0)]
        self._esc_walk(self.arvore)

    def _esc_walk(self, no: ParseNode) -> None:
        s = no.simbolo
        if s == "FUNCDEF":
            nome = no.filhos[1].token
            self.tabela.declarar(nome.lexeme, props={"categoria": "funcao"},
                                 linha=nome.line, coluna=nome.col)
            self.tabela.push_scope()
            self._declarar_params(no.filhos[3])
            self._esc_walk(no.filhos[6])
            self.tabela.pop_scope()
            return
        if s == "VARDECL":
            nome = no.filhos[1].token
            self.tabela.declarar(nome.lexeme, linha=nome.line, coluna=nome.col)
            return
        if s == "LVALUE":
            self._checar_uso(no.filhos[0].token)
            self._esc_walk(no.filhos[1])
            return
        if s == "FUNCCALL":
            self._checar_uso(no.filhos[0].token)
            self._esc_walk(no.filhos[2])
            return
        if s in ("PARAMLISTCALL", "PARAMLISTCALL'"):
            for f in no.filhos:
                if f.simbolo == "IDENT":
                    self._checar_uso(f.token)
                else:
                    self._esc_walk(f)
            return
        if self._eh_bloco(no) or s in ("FORSTAT", "IFSTAT"):
            self.tabela.push_scope()
            for f in no.filhos:
                self._esc_walk(f)
            self.tabela.pop_scope()
            return
        for f in no.filhos:
            self._esc_walk(f)

    def _checar_uso(self, tok) -> None:
        if self.tabela.resolver(tok.lexeme) is None:
            raise SemanticError(tok.line, tok.col,
                                f"identificador '{tok.lexeme}' não declarado")

    # === ASEM-05 (T14): verificação de break em repetição ====================

    def verificar_break(self) -> None:
        """Todo break deve estar dentro de um for; usa contador de aninhamento
        de for, break com nível 0 é erro (ASEM-05)."""
        self._break_walk(self.arvore, 0)

    def _break_walk(self, no: ParseNode, fores: int) -> None:
        if no.simbolo == "BREAK":
            if fores == 0:
                tok = no.token
                raise SemanticError(
                    tok.line, tok.col,
                    "'break' fora de um comando de repetição 'for'")
            return
        prox = fores + 1 if no.simbolo == "FORSTAT" else fores
        for f in no.filhos:
            self._break_walk(f, prox)
