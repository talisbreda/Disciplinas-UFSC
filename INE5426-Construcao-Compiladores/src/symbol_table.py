from dataclasses import dataclass, field

from .errors import SemanticError


@dataclass
class Symbol:
    """Entrada da tabela de símbolos para um `ident`."""

    nome: str
    tipo: str | None = None
    dimensoes: list[int] = field(default_factory=list)
    props: dict = field(default_factory=dict)
    ocorrencias: list[tuple[int, int]] = field(default_factory=list)


@dataclass
class Scope:
    """Um escopo léxico: contêiner ``nome -> Symbol`` das ligações locais."""

    nivel: int = 0
    simbolos: dict[str, "Symbol"] = field(default_factory=dict)

    def declarar(self, simbolo: "Symbol") -> None:
        self.simbolos[simbolo.nome] = simbolo

    def resolver_local(self, nome: str) -> "Symbol | None":
        return self.simbolos.get(nome)

    def tem_local(self, nome: str) -> bool:
        return nome in self.simbolos


class SymbolTable:
    """Tabela de símbolos: visão léxica global + pilha de escopos semânticos."""

    def __init__(self) -> None:
        # Tabela léxica global: uma entrada por nome de ident (AL-02).
        self.lexico: dict[str, Symbol] = {}
        # Pilha de escopos; sempre há um escopo base (nível 0).
        self.scopes: list[Scope] = [Scope(nivel=0)]

    def push_scope(self) -> Scope:
        escopo = Scope(nivel=len(self.scopes))
        self.scopes.append(escopo)
        return escopo

    def pop_scope(self) -> Scope:
        if len(self.scopes) <= 1:
            raise IndexError("não é possível remover o escopo base")
        return self.scopes.pop()

    @property
    def escopo_atual(self) -> Scope:
        return self.scopes[-1]

    def registrar_ocorrencia(self, nome: str, linha: int, coluna: int) -> Symbol:
        """Garante UMA entrada por nome no léxico global e anexa a ocorrência (AL-02)."""
        sym = self.lexico.get(nome)
        if sym is None:
            sym = Symbol(nome=nome)
            self.lexico[nome] = sym
        sym.ocorrencias.append((linha, coluna))
        return sym

    def simbolo_lexico(self, nome: str) -> "Symbol | None":
        return self.lexico.get(nome)

    def declarar(
        self,
        nome: str,
        tipo: str | None = None,
        dimensoes: list[int] | None = None,
        props: dict | None = None,
        linha: int | None = None,
        coluna: int | None = None,
    ) -> Symbol:
        """Declara `nome` no escopo do topo (ver contrato no docstring do módulo)."""
        escopo = self.escopo_atual
        if escopo.tem_local(nome):
            raise SemanticError(
                linha or 0,
                coluna or 0,
                f"identificador '{nome}' já declarado neste escopo",
            )

        ja_visivel = self.resolver(nome) is not None
        lex = self.lexico.get(nome)

        if lex is not None and not ja_visivel:
            # 1ª declaração alcançável: reaproveita o Symbol léxico (compartilha).
            sym = lex
            if tipo is not None:
                sym.tipo = tipo
            if dimensoes is not None:
                sym.dimensoes = list(dimensoes)
        else:
            # Shadowing (já visível externamente) ou nome inédito no léxico.
            sym = Symbol(
                nome=nome,
                tipo=tipo,
                dimensoes=list(dimensoes or []),
            )
            self.lexico.setdefault(nome, sym)

        if props:
            sym.props.update(props)
        if linha is not None and coluna is not None:
            sym.ocorrencias.append((linha, coluna))

        escopo.declarar(sym)
        return sym

    def resolver(self, nome: str) -> "Symbol | None":
        """Resolve `nome` buscando do topo da pilha à base (shadowing); None se não achar."""
        for escopo in reversed(self.scopes):
            sym = escopo.resolver_local(nome)
            if sym is not None:
                return sym
        return None

    def set_tipo(self, nome: str, tipo: str) -> Symbol:
        sym = self.resolver(nome) or self.lexico.get(nome)
        if sym is None:
            raise SemanticError(0, 0, f"identificador '{nome}' não declarado")
        sym.tipo = tipo
        return sym

    def dump(self) -> str:
        linhas: list[str] = []
        for escopo in self.scopes:
            linhas.append(f"Escopo {escopo.nivel}:")
            if not escopo.simbolos:
                linhas.append("  (vazio)")
            for sym in escopo.simbolos.values():
                tipo = sym.tipo if sym.tipo is not None else "?"
                ocs = ", ".join(f"({l},{c})" for l, c in sym.ocorrencias)
                linhas.append(f"  {sym.nome}: tipo={tipo} ocorrencias=[{ocs}]")
        return "\n".join(linhas)
