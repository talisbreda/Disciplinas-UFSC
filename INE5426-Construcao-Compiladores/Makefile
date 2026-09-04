# Makefile do compilador ConvCC-2026-1 (ENT-02).
#
# O compilador usa apenas a biblioteca padrão e roda em python3.11 puro.
#
# Uso:
#   make run ARQ=programas/p1.cc   # pipeline completa (6 blocos) de um arquivo
#   make lex ARQ=programas/p1.cc   # só análise léxica (tokens)
#   make parse ARQ=programas/p1.cc # léxico + sintático (aceita/rejeita)
#   make clean                     # remove artefatos (__pycache__)

PYTHON = python3.11

# Arquivo-fonte padrão dos alvos lex/parse/run (sobrescreva com ARQ=...).
ARQ ?= programas/p1.cc

.DEFAULT_GOAL := run
.PHONY: lex parse run clean help

# Análise léxica isolada: imprime os tokens (linha:coluna  TIPO  lexema).
define LEX_PY
import sys
from src.lexer import Lexer
from src.symbol_table import SymbolTable
from src.errors import CompilerError
fonte = open(sys.argv[1], encoding="utf-8").read()
try:
    for tok in Lexer(fonte, SymbolTable()).tokens():
        print(f"{tok.line}:{tok.col}\t{tok.type.name}\t{tok.lexeme!r}")
except CompilerError as erro:
    print(erro, file=sys.stderr)
    sys.exit(1)
endef
export LEX_PY

# Análise léxica + sintática: aceita (OK) ou rejeita (erro linha:coluna).
define PARSE_PY
import sys
from src.lexer import Lexer
from src.parser import Parser
from src.symbol_table import SymbolTable
from src.errors import CompilerError
fonte = open(sys.argv[1], encoding="utf-8").read()
try:
    tokens = list(Lexer(fonte, SymbolTable()).tokens())
    Parser(tokens).parse()
    print("OK: analise sintatica concluida (a entrada pertence a linguagem)")
except CompilerError as erro:
    print(erro, file=sys.stderr)
    sys.exit(1)
endef
export PARSE_PY

lex:
	$(PYTHON) -c "$$LEX_PY" $(ARQ)

parse:
	$(PYTHON) -c "$$PARSE_PY" $(ARQ)

run:
	$(PYTHON) main.py $(ARQ)

clean:
	find . -type d -name __pycache__ -prune -exec rm -rf {} +
	find . -type f -name '*.pyc' -delete

help:
	@echo "Alvos: lex parse run (ARQ=arquivo.cc) | clean"
	@echo "Ex.:  make run ARQ=programas/p1.cc"
