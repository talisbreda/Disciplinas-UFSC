# Tasks — Compilador ConvCC-2026-1

## Execution Protocol (MANDATORY -- do not skip)

Implemente estas tarefas com a skill `tlc-spec-driven`: **ative-a pelo nome e siga o fluxo Execute e as Critical Rules.** Não busque arquivos da skill por caminho no filesystem. A skill é a fonte de verdade do fluxo (ciclo por tarefa, delegação a sub-agentes, revisão de adequação, Verifier, sensor de discriminação).

**Se a skill não puder ser ativada, PARE e avise o usuário — não prossiga sem ela.**

> 8 fases (>3) → no Execute, **oferecer um sub-agente por fase** (sequencial), confirmando antes de despachar. Após a última tarefa, o **Verifier roda automaticamente**.

---

**Design**: `.specs/features/compilador/design.md`
**Status**: Draft

---

## Test Coverage Matrix

> Gerada de strong defaults (projeto greenfield) + spec. Guidelines encontradas: **nenhuma — strong defaults aplicados**. Framework proposto: **pytest** (AD-006, provisório). **Confirmar antes do Execute.**

| Code Layer | Required Test Type | Coverage Expectation | Location Pattern | Run Command |
| ---------- | ------------------ | -------------------- | ---------------- | ----------- |
| `src/lexer.py` (léxico) | unit | Todas as classes de token + erro léxico (happy + edge + error); 1:1 com AL-01/AL-03 | `tests/test_lexer.py` | `python3.11 -m pytest tests/test_lexer.py -q` |
| `src/symbol_table.py` | unit | Ocorrências, push/pop de escopo, props extensíveis, resolução; 1:1 com AL-02/ASEM-04 | `tests/test_symbol_table.py` | `python3.11 -m pytest tests/test_symbol_table.py -q` |
| `src/grammar.py` (FIRST/FOLLOW/tabela) | unit | FIRST/FOLLOW vs conjuntos à mão; tabela sem conflitos não resolvidos; 1:1 com AS-01 | `tests/test_grammar.py` | `python3.11 -m pytest tests/test_grammar.py -q` |
| `src/parser.py` | unit + integration | Aceita válidos; rejeita inválidos com linha/coluna; AS-02/AS-03 | `tests/test_parser.py` | `python3.11 -m pytest tests/test_parser.py -q` |
| `src/semantic.py` | unit | 1:1 com ASEM-01..05; todos os edge cases da spec | `tests/test_semantic.py` | `python3.11 -m pytest tests/test_semantic.py -q` |
| `src/codegen.py` | unit | TAC esperado por construção; precedência; GCI-01/GCI-02 | `tests/test_codegen.py` | `python3.11 -m pytest tests/test_codegen.py -q` |
| `main.py` + pipeline | e2e | Programa válido → 6 blocos; inválido → 1 msg posicional + exit≠0; OUT-01/OUT-02 | `tests/test_e2e.py` | `python3.11 -m pytest tests/test_e2e.py -q` |
| `tokens.py` / `errors.py` / `ast_nodes.py` | unit | Construção de token, formato de erro com posição, pré-ordem de ExprNode | `tests/test_core.py` | `python3.11 -m pytest tests/test_core.py -q` |
| Scaffolding / Makefile / README / docs | none | — (build gate / revisão) | — | build gate |

## Parallelism Assessment

> Gerada do design — confirmar antes do Execute.

| Test Type | Parallel-Safe? | Isolation Model | Evidence |
| --------- | -------------- | --------------- | -------- |
| unit (todos os módulos) | Yes | Cada teste instancia objetos novos (Lexer/Parser/SymbolTable/CodeGen); sem store compartilhado nem estado global mutável | Funções puras + dataclasses; sem I/O persistente |
| integration/e2e | Yes | Cada teste roda a pipeline sobre uma string/arquivo próprio; stdout capturado por teste | `main()` recebe caminho; sem estado global entre execuções |

Conclusão: `[P]` permitido sempre que **não houver dependência de código** entre tarefas (a segurança de teste não é o gargalo aqui).

## Gate Check Commands

> Geradas do design — confirmar antes do Execute.

| Gate Level | Quando usar | Command |
| ---------- | ----------- | ------- |
| Quick | Após tarefa com testes unitários | `python3.11 -m pytest tests/test_<modulo>.py -q` |
| Full | Após tarefa com e2e/integration | `python3.11 -m pytest -q` |
| Build | Após fase / tarefas de config-docs-Makefile | `python3.11 -W error -m py_compile src/*.py main.py && python3.11 -m pytest -q` (e `make`, quando existir) |

---

## Execution Plan

### Phase 0 — Fundação (Sequential)
```
T1 → T2
```

### Phase 1 — Análise Léxica / AL (Sequential)
```
T2 → T3 → T4
```

### Phase 2 — Gramática + Tabela LL(1) / AS-infra (paralela à Fase 1)
```
T2 → T5 → T6 → T7
            └→ T8 [P] (docs gramática)
```

### Phase 3 — Parser / AS-execução (Sequential)
```
(T4, T7) → T9
```

### Phase 4 — Análise Semântica / ASem (Parallel OK)
```
        ┌→ T10 [P] ─┐
T9 ─────┼→ T11 [P] ─┼→ T12
        ├→ T13 [P]
        └→ T14 [P]
(T11 também depende de T3)
```

### Phase 5 — Geração de Código Intermediário / GCI (Sequential)
```
(T9, T10) → T15
```

### Phase 6 — Integração / Driver (Sequential)
```
(T4, T9, T12, T13, T14, T15) → T16
```

### Phase 7 — Entrega + Documentação SDD (Parallel OK)
```
        ┌→ T17 [P] (docs SDD)
T16 ────┼→ T18 [P] (3 programas)
        ├→ T19 [P] (Makefile)
        └→ T20 [P] (README)
```

---

## Task Breakdown

### T1: Scaffolding do projeto
**What**: Criar estrutura de diretórios e configuração base do projeto Python.
**Where**: `src/`, `tests/`, `programas/`, `docs/`, `pytest.ini`, `.gitignore`, `README.md` (skeleton), `git init`.
**Depends on**: None
**Reuses**: —
**Requirement**: ENT-03 (parcial)
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Diretórios criados; `src/__init__.py` importável
- [x] `pytest.ini` configura `testpaths=tests`
- [x] `python3.11 -m pytest -q` roda (0 testes) sem erro
**Tests**: none · **Gate**: build
**Commit**: `chore: scaffolding do projeto e config de testes`

---

### T2: Tokens e erros
**What**: `TokenType` (Enum), `Token` (dataclass) e hierarquia de erros com linha/coluna.
**Where**: `src/tokens.py`, `src/errors.py`, `tests/test_core.py`
**Depends on**: T1
**Reuses**: `enum`, `dataclasses`
**Requirement**: AL-03, OUT-02 (base)
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Todos os `TokenType` do design definidos
- [x] `CompilerError.__str__` formata `linha:coluna: mensagem` em PT
- [x] Testes de criação de token e formato de erro passam
**Tests**: unit · **Gate**: quick (`tests/test_core.py`)
**Commit**: `feat(core): tokens e erros com posição`

---

### T3: Tabela de símbolos
**What**: `Symbol`, `Scope`, `SymbolTable` (push/pop, declarar, resolver, registrar ocorrências, set_tipo, dump, props extensíveis).
**Where**: `src/symbol_table.py`, `tests/test_symbol_table.py`
**Depends on**: T2
**Reuses**: `errors`
**Requirement**: AL-02, ASEM-04 (base)
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Uma entrada por `ident` com lista de ocorrências `(linha,col)`
- [x] `push_scope/pop_scope` e `resolver` (topo→base) corretos
- [x] `props` extensível (insere `tipo` e atributos arbitrários)
- [x] Testes de ocorrências/escopo/extensibilidade passam
**Tests**: unit · **Gate**: quick (`tests/test_symbol_table.py`)
**Commit**: `feat(symtab): tabela de símbolos por escopo com ocorrências`

---

### T4: Analisador léxico (DFA char-a-char)
**What**: Lexer manual baseado em diagramas de transição para todas as classes de token; registra ocorrências de `ident`; `LexicalError` com posição. Inclui `docs/diagramas-lexico.md`.
**Where**: `src/lexer.py`, `tests/test_lexer.py`, `docs/diagramas-lexico.md`
**Depends on**: T2, T3
**Reuses**: `tokens`, `errors`, `symbol_table`
**Requirement**: AL-01, AL-02, AL-03
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Tokeniza keywords, `ident`, `int/float/string_constant`, operadores compostos (`<= >= == !=`), pontuação — char-a-char
- [x] `ident`s registrados na tabela com posição
- [x] Erros léxicos (char inválido, string não fechada, número malformado) com linha/coluna
- [x] `docs/diagramas-lexico.md` documenta os diagramas de transição
- [x] Testes (happy + edge + error) passam
**Tests**: unit · **Gate**: quick (`tests/test_lexer.py`)
**Commit**: `feat(lexer): DFA char-a-char + integração com tabela de símbolos`

---

### T5: Gramática LL(1) (produções)
**What**: Codificar a gramática **já transformada** (convencional, sem recursão à esquerda, fatorada) como `PRODUCOES`.
**Where**: `src/grammar.py`, `tests/test_grammar.py`
**Depends on**: T2
**Reuses**: `tokens`
**Requirement**: AS-01
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Todos os não-terminais e alternativas codificados, com `ε`/`$` explícitos
- [x] Fatoração de `ATRIBSTAT` (`ident(`/`ident[`) e `FUNCLIST` aplicada
- [x] Teste de sanidade das produções passa
**Tests**: unit · **Gate**: quick (`tests/test_grammar.py`)
**Commit**: `feat(grammar): produções LL(1) de ConvCC-2026-1`

---

### T6: FIRST e FOLLOW
**What**: Cálculo de FIRST/FOLLOW sobre `PRODUCOES`.
**Where**: `src/grammar.py` (extensão), `tests/test_grammar.py`
**Depends on**: T5
**Reuses**: `grammar`
**Requirement**: AS-01
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] `first`/`follow` corretos para ≥6 não-terminais conferidos à mão
- [x] Testes comparando com conjuntos calculados manualmente passam
**Tests**: unit · **Gate**: quick (`tests/test_grammar.py`)
**Commit**: `feat(grammar): FIRST e FOLLOW`

---

### T7: Tabela de reconhecimento LL(1) (única)
**What**: `build_parse_table()` constrói a tabela **uma vez**, detecta conflitos e aplica resoluções documentadas (dangling-else / `ident`).
**Where**: `src/grammar.py` (extensão), `tests/test_grammar.py`
**Depends on**: T6
**Reuses**: `grammar`
**Requirement**: AS-01
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Tabela construída sem conflitos **não resolvidos** (conflitos resolvidos são documentados)
- [x] Entradas-chave conferidas em teste
- [x] Construção ocorre uma única vez (memoizada)
**Tests**: unit · **Gate**: quick (`tests/test_grammar.py`)
**Commit**: `feat(grammar): tabela preditiva LL(1) construída uma vez`

---

### T8: Documentação da gramática (AS) [P]
**What**: `docs/gramatica.md` — BNF→convencional, remoção de recursão à esquerda, fatoração, prova de LL(1) (FIRST/FOLLOW disjuntos), tabela.
**Where**: `docs/gramatica.md`
**Depends on**: T5
**Reuses**: produções de `grammar.py`
**Requirement**: DOC-01
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Cada transformação documentada e coerente com `grammar.py`
- [x] Prova de LL(1) presente; tabela incluída
**Tests**: none · **Gate**: build (revisão)
**Commit**: `docs: transformações de gramática e prova LL(1)`

---

### T9: Parser preditivo por tabela
**What**: Parser não-recursivo com pilha; constrói `ParseNode`; `SyntaxError` no 1º erro com posição/esperado/encontrado. Cria `src/ast_nodes.py` com `ParseNode`.
**Where**: `src/parser.py`, `src/ast_nodes.py`, `tests/test_parser.py`
**Depends on**: T4, T7
**Reuses**: `grammar`, `tokens`, `errors`
**Requirement**: AS-02, AS-03
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Aceita programas válidos (consome até `$`) e devolve árvore
- [x] Rejeita inválidos parando no 1º erro com linha/coluna
- [x] Testes (aceitação + rejeição posicional) passam
**Tests**: unit + integration · **Gate**: full
**Commit**: `feat(parser): parser preditivo LL(1) dirigido por tabela`

---

### T10: Árvore de expressão (EXPA) [P]
**What**: `ExprNode` em `ast_nodes.py` + `construir_arvores_expressao()` (SDD L-atribuída/SDT → árvore T, pré-ordem raiz-esq-dir).
**Where**: `src/ast_nodes.py` (extensão), `src/semantic.py`, `tests/test_semantic.py`
**Depends on**: T9
**Reuses**: `ast_nodes`
**Requirement**: ASEM-01
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Árvore correta para expressões com precedência (`* / %` antes de `+ -`)
- [x] `pre_ordem()` produz varredura raiz-esq-dir
- [x] Testes passam
**Tests**: unit · **Gate**: quick (`tests/test_semantic.py`)
**Commit**: `feat(semantic): árvore de expressão via SDD L-atribuída`

---

### T11: Inserção de tipo na tabela (DEC) [P]
**What**: `inserir_tipos()` — SDD L-atribuída para declarações; atributo de tipo herdado flui para a tabela de símbolos (por escopo).
**Where**: `src/semantic.py` (extensão), `tests/test_semantic.py`
**Depends on**: T9, T3
**Reuses**: `symbol_table`
**Requirement**: ASEM-02
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Tipos `int/float/string` (e dimensões de array) inseridos por declaração
- [x] Testes de inserção por escopo passam
**Tests**: unit · **Gate**: quick (`tests/test_semantic.py`)
**Commit**: `feat(semantic): inserção de tipo na tabela (SDD DEC)`

---

### T12: Verificação de tipos (expressões)
**What**: `verificar_tipos()` — usa a árvore de expressão e a tabela; operação válida só se todos os operandos têm o mesmo tipo; senão `SemanticError`.
**Where**: `src/semantic.py` (extensão), `tests/test_semantic.py`
**Depends on**: T10, T11
**Reuses**: `ast_nodes`, `symbol_table`
**Requirement**: ASEM-03
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] `a+b*4.7` com `a,b` float → válido; tipos mistos → erro com posição
- [x] Tipo não declarado → erro
- [x] Testes passam
**Tests**: unit · **Gate**: quick (`tests/test_semantic.py`)
**Commit**: `feat(semantic): verificação de tipos em expressões`

---

### T13: Verificação de escopo [P]
**What**: `verificar_escopos()` — push/pop em `FUNCDEF`/`{STATELIST}`/`for`/`if`; redeclaração no mesmo escopo, colisão função×variável, uso não declarado → erro; aninhamento permite redeclarar.
**Where**: `src/semantic.py` (extensão), `tests/test_semantic.py`
**Depends on**: T9, T3
**Reuses**: `symbol_table`
**Requirement**: ASEM-04
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] `int a; string a;` no mesmo escopo → erro; em escopos aninhados → ok
- [x] Colisão nome de função × variável → erro
- [x] Uso de `ident` não declarado → erro
- [x] Testes passam
**Tests**: unit · **Gate**: quick (`tests/test_semantic.py`)
**Commit**: `feat(semantic): verificação de identificadores por escopo`

---

### T14: Verificação de break em for [P]
**What**: `verificar_break()` — `break` válido só dentro do escopo de um `for`; fora → `SemanticError`.
**Where**: `src/semantic.py` (extensão), `tests/test_semantic.py`
**Depends on**: T9
**Reuses**: `ast_nodes`, `errors`
**Requirement**: ASEM-05
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] `break` dentro de `for` (inclusive aninhado) → ok
- [x] `break` fora → erro com posição
- [x] Testes passam
**Tests**: unit · **Gate**: quick (`tests/test_semantic.py`)
**Commit**: `feat(semantic): verificação de break em repetição`

---

### T15: Geração de código intermediário (TAC)
**What**: `codegen.py` — SDT que emite código de três endereços (temporários, rótulos, gotos) para expressões, atribuições, `if/else`, `for`, `print`, `read`, alloc/arrays, `def/return/`chamada.
**Where**: `src/codegen.py`, `tests/test_codegen.py`
**Depends on**: T9, T10
**Reuses**: `ast_nodes`
**Requirement**: GCI-01, GCI-02
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] `a = b + c * d;` → `t1 = c * d; t2 = b + t1; a = t2`
- [x] `if/for` geram rótulos e gotos corretos
- [x] Testes por construção passam
**Tests**: unit · **Gate**: quick (`tests/test_codegen.py`)
**Commit**: `feat(codegen): geração de código de três endereços`

---

### T16: Driver / pipeline + saídas
**What**: `main.py` — orquestra léxico→sintático→semântico→GCI; imprime os 6 blocos de sucesso; no erro, 1 mensagem com linha/coluna e exit≠0.
**Where**: `main.py`, `tests/test_e2e.py`
**Depends on**: T4, T9, T12, T13, T14, T15
**Reuses**: todos os módulos
**Requirement**: OUT-01, OUT-02
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Programa válido → (a) árvores de expressão, (b) tabela(s) com tipo, (c) sucesso tipos, (d) sucesso escopo, (e) sucesso break, (f) código intermediário
- [x] Programa com erro (léx/sint/sem) → 1 msg posicional + exit≠0
- [x] Testes e2e (válido + cada tipo de erro) passam
**Tests**: e2e · **Gate**: full
**Commit**: `feat(driver): pipeline completa e saídas ao terminal`

---

### T17: Documentação SDD (ASem/GCI) [P]
**What**: `docs/sdd-semantica.md` (EXPA+DEC: SDD L-atribuída, prova de L-atribuição, SDT) e `docs/sdd-gci.md` (SDD/SDT de geração de código).
**Where**: `docs/sdd-semantica.md`, `docs/sdd-gci.md`
**Depends on**: T16
**Reuses**: `semantic.py`, `codegen.py`
**Requirement**: DOC-02
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] EXPA e DEC separados, com SDD, prova de L-atribuição e SDT
- [x] SDD/SDT de geração de código coerente com `codegen.py`
**Tests**: none · **Gate**: build (revisão)
**Commit**: `docs: SDDs L-atribuídas e SDTs (semântica e GCI)`

---

### T18: Três programas-exemplo [P]
**What**: 3 programas `ConvCC-2026-1`, ≥100 linhas cada, sem erros, com chamadas a função; cabeçalho com integrantes.
**Where**: `programas/p1.cc`, `programas/p2.cc`, `programas/p3.cc`
**Depends on**: T16
**Reuses**: pipeline
**Requirement**: ENT-01
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Cada programa tem ≥100 linhas e usa `def`/chamada de função
- [x] Pipeline roda limpa (exit 0) nos 3 — verificado em teste e2e
**Tests**: e2e · **Gate**: full
**Commit**: `feat(programas): três exemplos ConvCC-2026-1`

---

### T19: Makefile [P]
**What**: `Makefile` com alvos `lex`, `parse`, `run ARQ=...`, `test`, `clean`; declara `python3.11`; sem warnings.
**Where**: `Makefile`
**Depends on**: T16
**Reuses**: `main.py`
**Requirement**: ENT-02
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] `make run ARQ=programas/p1.cc` executa a pipeline
- [x] `make test` roda a suíte; `make clean` limpa artefatos
- [x] Execução sem warnings
**Tests**: none · **Gate**: build (`make`)
**Commit**: `build: Makefile com alvos de execução e teste`

---

### T20: README [P]
**What**: `README.md` final — integrantes, versão do Python (3.11), como executar, estrutura do projeto, exemplos de saída.
**Where**: `README.md`
**Depends on**: T16
**Reuses**: —
**Requirement**: ENT-03
**Tools**: MCP: NONE · Skill: NONE
**Done when**:
- [x] Contém integrantes, versão Python, instruções de execução e estrutura
- [x] Coerente com Makefile e `main.py`
**Tests**: none · **Gate**: build (revisão)
**Commit**: `docs: README de execução`

---

## Parallel Execution Map

```
Phase 0 (Seq):     T1 → T2
Phase 1 (Seq):     T2 → T3 → T4
Phase 2 (mista):   T2 → T5 → T6 → T7
                          └→ T8 [P]
Phase 3 (Seq):     (T4,T7) → T9
Phase 4 (Par):     T9 → { T10[P], T11[P], T13[P], T14[P] } ; (T10,T11) → T12
Phase 5 (Seq):     (T9,T10) → T15
Phase 6 (Seq):     (T4,T9,T12,T13,T14,T15) → T16
Phase 7 (Par):     T16 → { T17[P], T18[P], T19[P], T20[P] }
```

`[P]` = sem dependência entre tarefas dentro da fase (ordem livre). Não é diretiva para criar um sub-agente por tarefa — a Fase 1 do plano de sub-agentes é **um worker por fase**.

---

## Task Granularity Check

| Task | Escopo | Status |
| ---- | ------ | ------ |
| T1 Scaffolding | config | ✅ Granular |
| T2 Tokens+erros | 2 arquivos coesos | ✅ Granular |
| T3 Tabela de símbolos | 1 módulo | ✅ Granular |
| T4 Lexer | 1 módulo | ✅ Granular |
| T5 Produções | 1 módulo | ✅ Granular |
| T6 FIRST/FOLLOW | 1 função-conjunto | ✅ Granular |
| T7 Tabela LL(1) | 1 função | ✅ Granular |
| T8 Docs gramática | 1 doc | ✅ Granular |
| T9 Parser | 1 módulo | ✅ Granular |
| T10 Árvore de expressão | 1 função | ✅ Granular |
| T11 Inserção de tipo | 1 função | ✅ Granular |
| T12 Verificação de tipos | 1 função | ✅ Granular |
| T13 Verificação de escopo | 1 função | ✅ Granular |
| T14 break em for | 1 função | ✅ Granular |
| T15 Codegen | 1 módulo | ✅ Granular |
| T16 Driver | 1 arquivo | ✅ Granular |
| T17 Docs SDD | 1–2 docs coesos | ✅ Granular |
| T18 Programas | 3 arquivos de dados | ✅ Granular |
| T19 Makefile | 1 arquivo | ✅ Granular |
| T20 README | 1 arquivo | ✅ Granular |

---

## Diagram-Definition Cross-Check

| Task | Depends On (corpo) | Diagrama mostra | Status |
| ---- | ------------------ | --------------- | ------ |
| T1 | None | (início) | ✅ |
| T2 | T1 | T1→T2 | ✅ |
| T3 | T2 | T2→T3 | ✅ |
| T4 | T2, T3 | T3→T4 (T2 transitivo) | ✅ |
| T5 | T2 | T2→T5 | ✅ |
| T6 | T5 | T5→T6 | ✅ |
| T7 | T6 | T6→T7 | ✅ |
| T8 | T5 | T5→T8 [P] | ✅ |
| T9 | T4, T7 | (T4,T7)→T9 | ✅ |
| T10 | T9 | T9→T10 [P] | ✅ |
| T11 | T9, T3 | T9→T11 [P] (T3 nota) | ✅ |
| T12 | T10, T11 | (T10,T11)→T12 | ✅ |
| T13 | T9, T3 | T9→T13 [P] | ✅ |
| T14 | T9 | T9→T14 [P] | ✅ |
| T15 | T9, T10 | (T9,T10)→T15 | ✅ |
| T16 | T4,T9,T12,T13,T14,T15 | (…)→T16 | ✅ |
| T17 | T16 | T16→T17 [P] | ✅ |
| T18 | T16 | T16→T18 [P] | ✅ |
| T19 | T16 | T16→T19 [P] | ✅ |
| T20 | T16 | T16→T20 [P] | ✅ |

Nenhum `[P]` depende de outro `[P]` da mesma fase (T12 não é `[P]`; depende de T10/T11). ✅

---

## Test Co-location Validation

| Task | Camada criada/modificada | Matriz exige | Task diz | Status |
| ---- | ------------------------ | ------------ | -------- | ------ |
| T1 | scaffolding/config | none | none | ✅ |
| T2 | tokens/errors | unit | unit | ✅ |
| T3 | symbol_table | unit | unit | ✅ |
| T4 | lexer | unit | unit | ✅ |
| T5 | grammar (produções) | unit | unit | ✅ |
| T6 | grammar (FIRST/FOLLOW) | unit | unit | ✅ |
| T7 | grammar (tabela) | unit | unit | ✅ |
| T8 | docs | none | none | ✅ |
| T9 | parser | unit+integration | unit+integration | ✅ |
| T10 | semantic (expr tree) | unit | unit | ✅ |
| T11 | semantic (tipos DEC) | unit | unit | ✅ |
| T12 | semantic (verif tipos) | unit | unit | ✅ |
| T13 | semantic (escopo) | unit | unit | ✅ |
| T14 | semantic (break) | unit | unit | ✅ |
| T15 | codegen | unit | unit | ✅ |
| T16 | driver/pipeline | e2e | e2e | ✅ |
| T17 | docs | none | none | ✅ |
| T18 | programas (dados) | e2e | e2e | ✅ |
| T19 | Makefile | none (build) | none | ✅ |
| T20 | README | none | none | ✅ |

Nenhuma violação. Todas as camadas com teste exigido têm o teste co-localizado na própria tarefa.

---

## Task Verification Standards

Cada tarefa segue `Done when` + `Tests` + `Gate`. Cada item de `Done when` é binário (passa/falha) e referencia o comando de gate da seção **Gate Check Commands**. Um commit atômico por tarefa, sem enfraquecer ou apagar testes. Após T20, o **Verifier** roda automaticamente (autor ≠ verificador): checagem ancorada na spec (cada teste afirma o resultado esperado da spec) + sensor de discriminação (injeta falhas e confirma que os testes as matam) + `validation.md`.
