# Compilador ConvCC-2026-1

Compilador para a linguagem `ConvCC-2026-1` (disciplina INE5426 - Construção de
Compiladores, UFSC). Implementa as fases de **análise** (léxica, sintática,
semântica) e de **síntese** (geração de código intermediário em código de três
endereços) em **Python 3.11**, usando apenas a biblioteca padrão.

## Integrantes

- Carlos Eduardo Vitorino Gomes - 23150560
- Eduardo Cunha Cabral - 23150561
- Enrico Caliolo - 23150562
- Gustavo Gonçalves dos Santos - 20102236
- Tális Breda - 22102202

> Como a linguagem `ConvCC-2026-1` **não possui comentários** (a BNF não os
> define - ver "Decisões" abaixo), o cabeçalho de integrantes exigido nos
> arquivos `.cc` é registrado por uma instrução `print "Integrantes: ..."` no
> início da função de entrada de cada programa.

## Requisitos

- **Python 3.11** (o compilador roda em `python3.11` puro, sem dependências
  externas).

## Como executar

### Via `make`

```sh
make run ARQ=programas/p1.cc     # pipeline completa: imprime os 6 blocos
make lex ARQ=programas/p1.cc     # só análise léxica (lista de tokens)
make parse ARQ=programas/p2.cc   # análise léxica + sintática (aceita/rejeita)
make clean                       # remove __pycache__
```

`make` sem alvo equivale a `make run` (usa `ARQ=programas/p1.cc` por padrão).

### Diretamente com Python 3.11

```sh
python3.11 main.py programas/p1.cc
```

- **Sucesso** → imprime os 6 blocos de saída em `stdout` e retorna código 0.
- **Erro** (léxico/sintático/semântico) → para no **primeiro** erro e imprime
  uma mensagem `linha:coluna: mensagem` em `stderr`, retornando código != 0.
