import os
import sys

from src.lexer import Lexer
from src.parser import Parser
from src.symbol_table import SymbolTable
from src.semantic import SemanticAnalyzer
from src.codegen import CodeGen
from src.errors import CompilerError

_RESET = "\033[0m"
_BOLD = "\033[1m"
_DIM = "\033[2m"
_RED = "\033[31m"
_GREEN = "\033[32m"
_YELLOW = "\033[33m"
_BLUE = "\033[34m"
_MAGENTA = "\033[35m"
_CYAN = "\033[36m"


def _usar_cor(stream) -> bool:
    # Cor só em terminal interativo e quando NO_COLOR não está definido (saída
    # redirecionada para arquivo/pipe fica limpa, sem códigos ANSI).
    return stream.isatty() and not os.environ.get("NO_COLOR")


def _estilo(texto: str, *codigos: str, cor: bool = False) -> str:
    if not (cor and codigos):
        return texto
    return "".join(codigos) + texto + _RESET


def compilar(fonte: str, cor: bool = False) -> str:
    """Roda a pipeline e devolve as 6 saídas de sucesso; levanta CompilerError no 1º erro."""
    tabela = SymbolTable()

    tokens = list(Lexer(fonte, tabela).tokens())
    arvore = Parser(tokens).parse()

    # inserir_tipos antes de verificar_tipos: os tipos precisam estar na tabela.
    sem = SemanticAnalyzer(arvore, tabela)
    sem.inserir_tipos()
    arvores_expr = sem.verificar_tipos()
    sem.verificar_escopos()
    sem.verificar_break()

    codigo = CodeGen().gerar(arvore)

    return _formatar_saidas(arvores_expr, tabela, codigo, cor)


def _secao(titulo: str, cor: bool) -> str:
    return _estilo(f"━━ {titulo}", _BOLD, _CYAN, cor=cor)


def _sucesso(msg: str, cor: bool) -> str:
    return "  " + _estilo("✓", _GREEN, _BOLD, cor=cor) + " " + _estilo(msg, _GREEN, cor=cor)


def _formatar_saidas(arvores_expr, tabela: SymbolTable, codigo, cor: bool) -> str:
    blocos: list[str] = []

    a = [_secao("(a) Árvore de expressão · varredura raiz → esquerda → direita", cor)]
    if arvores_expr:
        larg = len(str(len(arvores_expr)))
        for i, arv in enumerate(arvores_expr, 1):
            idx = _estilo(f"{i:>{larg}}.", _DIM, cor=cor)
            a.append(f"  {idx} " + " ".join(arv.pre_ordem()))
    else:
        a.append("  " + _estilo("(nenhuma expressão aritmética no programa)", _DIM, cor=cor))
    blocos.append("\n".join(a))

    b = [_secao("(b) Tabela de símbolos · tipo por identificador", cor)]
    b.append(_tabela_simbolos(tabela, cor))
    blocos.append("\n".join(b))

    c = [_secao("(c) Verificação de tipos", cor)]
    c.append(_sucesso("as expressões aritméticas são válidas (operandos de mesmo tipo).", cor))
    blocos.append("\n".join(c))

    d = [_secao("(d) Verificação de escopos", cor)]
    d.append(_sucesso("as declarações de identificadores por escopo são válidas.", cor))
    blocos.append("\n".join(d))

    e = [_secao("(e) Verificação de break em repetição", cor)]
    e.append(_sucesso("todo 'break' está no escopo de um comando de repetição 'for'.", cor))
    blocos.append("\n".join(e))

    f = [_secao("(f) Código intermediário (três endereços)", cor)]
    f.append(_formatar_tac(codigo, cor))
    blocos.append("\n".join(f))

    return "\n\n".join(blocos)


def _tabela_simbolos(tabela: SymbolTable, cor: bool) -> str:
    # Bloco (b): usa a visão léxica global (uma entrada por ident, AL-02), pois o
    # dump() por escopo fica vazio após as travessias semânticas (escopos desempilhados).
    if not tabela.lexico:
        return "  " + _estilo("(sem identificadores)", _DIM, cor=cor)

    entradas: list[tuple[str, str, str]] = []
    for nome, sym in tabela.lexico.items():
        if sym.props.get("categoria") == "funcao":
            tipo = "função"
        else:
            tipo = sym.tipo if sym.tipo is not None else "?"
        if sym.dimensoes:
            tipo += "".join(f"[{d}]" for d in sym.dimensoes)
        vistas: list[tuple[int, int]] = []
        for oc in sym.ocorrencias:
            if oc not in vistas:
                vistas.append(oc)
        ocs = " ".join(f"({l},{c})" for l, c in vistas)
        entradas.append((nome, tipo, ocs))

    larg_nome = max([len("IDENTIFICADOR")] + [len(n) for n, _, _ in entradas])
    larg_tipo = max([len("TIPO")] + [len(t) for _, t, _ in entradas])

    cabecalho = (
        "IDENTIFICADOR".ljust(larg_nome) + "  "
        + "TIPO".ljust(larg_tipo) + "  OCORRÊNCIAS (linha,coluna)"
    )
    linhas = ["  " + _estilo(cabecalho, _DIM, cor=cor)]
    for nome, tipo, ocs in entradas:
        linhas.append(
            "  "
            + _estilo(nome.ljust(larg_nome), _BOLD, cor=cor)
            + "  " + _estilo(tipo.ljust(larg_tipo), _YELLOW, cor=cor)
            + "  " + _estilo(ocs, _DIM, cor=cor)
        )
    return "\n".join(linhas)


def _formatar_tac(codigo, cor: bool) -> str:
    if not codigo:
        return "  " + _estilo("(nenhuma instrução)", _DIM, cor=cor)
    linhas: list[str] = []
    for instr in codigo:
        s = instr.strip()
        if s.startswith("func ") and s.endswith(":"):     # cabeçalho de função
            linhas.append("  " + _estilo(s, _BOLD, _BLUE, cor=cor))
        elif s.endswith(":"):                              # rótulo (alvo de salto)
            linhas.append("    " + _estilo(s, _YELLOW, cor=cor))
        else:                                              # instrução de 3 endereços
            linhas.append("      " + s)
    return "\n".join(linhas)


def main(argv=None) -> int:
    argv = list(sys.argv if argv is None else argv)
    if len(argv) != 2:
        print("uso: python3.11 main.py <programa.cc>", file=sys.stderr)
        return 2

    caminho = argv[1]
    try:
        with open(caminho, encoding="utf-8") as arq:
            fonte = arq.read()
    except OSError as erro_io:
        print(f"erro ao abrir '{caminho}': {erro_io}", file=sys.stderr)
        return 2

    try:
        saida = compilar(fonte, cor=_usar_cor(sys.stdout))
    except CompilerError as erro:
        # OUT-02: para no 1º erro, 1 mensagem posicional (linha:coluna: mensagem).
        cor = _usar_cor(sys.stderr)
        print(_estilo(f"✗ {erro}", _BOLD, _RED, cor=cor), file=sys.stderr)
        return 1

    cor = _usar_cor(sys.stdout)
    print(_estilo(f"⎯⎯ Compilando {caminho} ⎯⎯", _BOLD, _MAGENTA, cor=cor))
    print()
    print(saida)
    print()
    print(_estilo("✓ Compilação concluída com sucesso.", _BOLD, _GREEN, cor=cor))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
