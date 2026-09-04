from dataclasses import dataclass, field

from .tokens import Token


@dataclass
class ParseNode:
    """Nó da árvore de derivação (não-terminal com filhos, ou folha com token)."""

    simbolo: str
    filhos: list["ParseNode"] = field(default_factory=list)
    token: Token | None = None


@dataclass
class ExprNode:
    """Nó da árvore de expressão T (só operadores e operandos)."""

    valor: str
    esq: "ExprNode | None" = None
    dir: "ExprNode | None" = None
    tipo: str | None = None
    # token carrega posição (linha/coluna) p/ erros semânticos; compare/repr=False
    # pois é metadado de posição e não deve afetar igualdade.
    token: Token | None = field(default=None, compare=False, repr=False)

    def pre_ordem(self) -> list:
        """Varredura raiz-esquerda-direita dos ``valor`` (exigida por OUT-01a/ASEM-01)."""
        resultado = [self.valor]
        if self.esq is not None:
            resultado.extend(self.esq.pre_ordem())
        if self.dir is not None:
            resultado.extend(self.dir.pre_ordem())
        return resultado
