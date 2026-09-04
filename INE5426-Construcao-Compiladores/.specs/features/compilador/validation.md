# Compilador ConvCC-2026-1 Validation

**Date**: 2026-06-27
**Spec**: `.specs/features/compilador/spec.md`
**Diff range**: `ddf24dd..HEAD` (21 commits; HEAD=`8f4248e`)
**Verifier**: independent sub-agent (author ≠ verifier; cobertura re-derivada do zero, evidência-ou-zero)
**Re-verify**: iteração 2 de no máx. 3 — re-verificação após a correção de Fix 1 (commit `8f4248e`). Veredito atualizado para **PASS ✅**.

---

## Task Completion

| Task | Status | Notes |
| ---- | ------ | ----- |
| T1 Scaffolding | ✅ Done | `src/__init__.py`, `pytest.ini` (testpaths=tests) |
| T2 Tokens+erros | ✅ Done | `src/tokens.py`, `src/errors.py`; `CompilerError.__str__` = `linha:coluna: msg` |
| T3 Tabela de símbolos | ✅ Done | `src/symbol_table.py`; léxico global + pilha de escopos |
| T4 Lexer DFA | ✅ Done | `src/lexer.py` char-a-char; `docs/diagramas-lexico.md` presente |
| T5 Produções LL(1) | ✅ Done | `src/grammar.py` PRODUCOES; fatoração ATRIBSTAT/FUNCLIST |
| T6 FIRST/FOLLOW | ✅ Done | ponto-fixo; conferidos à mão nos testes |
| T7 Tabela LL(1) única | ✅ Done | `build_parse_table` memoizada; 2 conflitos documentados |
| T8 Docs gramática | ✅ Done | `docs/gramatica.md` (review manual) |
| T9 Parser preditivo | ✅ Done | `src/parser.py` pilha explícita; lookahead ATRIBSTAT |
| T10 Árvore de expressão | ✅ Done | `ExprNode` + colapso de cadeias; pré-ordem |
| T11 Inserção de tipo (DEC) | ✅ Done | `inserir_tipos` por escopo |
| T12 Verificação de tipos | ✅ Done | `verificar_tipos` mesmo-tipo estrito |
| T13 Verificação de escopo | ✅ Done | `verificar_escopos` reinicia a pilha de escopos (Fix 1 resolvido, `8f4248e`) |
| T14 break em for | ✅ Done | `verificar_break` por nível de aninhamento |
| T15 Codegen TAC | ✅ Done | `src/codegen.py`; temporários/rótulos/gotos |
| T16 Driver / pipeline | ✅ Done | `main.py`; 6 blocos / 1 erro posicional + exit≠0 |
| T17 Docs SDD | ✅ Done | `docs/sdd-semantica.md`, `docs/sdd-gci.md` (review manual) |
| T18 Três programas | ✅ Done | p1/p2/p3 = 167/151/160 linhas; com `def`/chamada |
| T19 Makefile | ✅ Done | lex/parse/run/test/clean; `make` sem warnings |
| T20 README | ✅ Done | integrantes (placeholder), Python 3.11, execução, estrutura |

Todas as 20 tarefas marcadas done em `tasks.md`. Nenhuma blocked/partial.

---

## Spec-Anchored Acceptance Criteria

### P1: Análise Léxica + Tabela de Símbolos (AL-01/02/03)

| Criterion (WHEN X THEN Y) | Spec-defined outcome | `file:line` + assertion | Result |
| ------------------------- | -------------------- | ----------------------- | ------ |
| AL-01 programa válido → sequência de tokens char-a-char | tokens nas classes corretas | `tests/test_lexer.py:48` — `assert [t.type for t in toks] == esperado` ; `:62` palavras-chave ; `:74` operadores/pontuação | ✅ PASS |
| AL-02 `ident` → UMA entrada com lista de ocorrências (linha,col), props extensíveis | 1 entrada acumulando `(linha,col)`; `tipo`/props inseríveis | `tests/test_lexer.py:96` — `assert sym.ocorrencias == [(1, 5), (2, 1), (2, 5), (2, 9)]` ; `test_symbol_table.py:36` — `assert sym.ocorrencias == [(1, 1), (2, 5), (3, 9)]` ; `:97` — `assert recuperado.props["inicializado"] is True` | ✅ PASS |
| AL-03 lexema inválido → para + erro léxico com linha/coluna | `LexicalError` posicional | `tests/test_lexer.py:105` — `assert (exc.value.linha, exc.value.coluna) == (2, 5)` | ✅ PASS |

### P1: Análise Sintática LL(1) (AS-01/02/03)

| Criterion | Spec-defined outcome | `file:line` + assertion | Result |
| --------- | -------------------- | ----------------------- | ------ |
| AS-01 FIRST/FOLLOW + tabela LL(1) UMA vez, sem conflitos não resolvidos | tabela memoizada (mesmo objeto); só 2 conflitos documentados | `tests/test_grammar.py:244` — `assert grammar.build_parse_table() is grammar.build_parse_table()` ; `:305` — `assert chaves == {("IFSTAT'", T.ELSE), ("ATRIBSTAT_RHS", T.IDENT)}` ; FOLLOW `:179` — `assert grammar.follow("PROGRAM") == {T.EOF}` | ✅ PASS |
| AS-02 entrada pertence → aceita consumindo até `$` | consome até EOF | `tests/test_parser.py:94` — `assert parser._atual().type is TokenType.EOF` ; `:96` — `assert coletar(arvore, "FUNCDEF")` | ✅ PASS |
| AS-03 não pertence → para no 1º erro, linha/coluna + esperado/encontrado | `SyntaxError_` posicional com esperado/encontrado | `tests/test_parser.py:197` — `assert (erro.linha, erro.coluna) == (1, 17)` ; `:198-199` — `assert "';'" in erro.mensagem` / `assert "'}'" in erro.mensagem` | ✅ PASS |

### P1: Análise Semântica (ASEM-01..05)

| Criterion | Spec-defined outcome | `file:line` + assertion | Result |
| --------- | -------------------- | ----------------------- | ------ |
| ASEM-01 EXPA → árvore T, pré-ordem raiz-esq-dir | `a+b*4.7` → `['+','a','*','b','4.7']` | `tests/test_semantic.py:58` — `assert raiz.pre_ordem() == ["+", "a", "*", "b", "4.7"]` ; precedência `:69` — `assert raiz.pre_ordem() == ["+", "*", "a", "b", "c"]` ; assoc `:80` | ✅ PASS |
| ASEM-02 DEC → tipo na tabela (SDD L-atribuída) | int/float/string + dimensões | `tests/test_semantic.py:101` — `assert tabela.simbolo_lexico("a").tipo == "int"` ; arrays `:111` — `assert sym.dimensoes == [3, 4]` | ✅ PASS |
| ASEM-03 expr válida só se todos operandos mesmo tipo; senão erro pos. | mesmos tipos→ok; mistos→`SemanticError` na posição do operador | `tests/test_semantic.py:146` — `assert arvores[0].tipo == "float"` ; misto `:155` — `assert (exc.value.linha, exc.value.coluna) == (1, coluna)` (coluna do `*`) ; int+float `:165` ; sem tipo `:175` | ✅ PASS |
| ASEM-04 redeclaração mesmo escopo / colisão / uso não declarado → erro; aninhado permitido; declaração única no escopo base → válida | `int a; string a;`→erro pos. 2º `a`; aninhado→ok; uso não decl.→erro; `int a;` (base) → sem erro, tipado | `tests/test_semantic.py:190` — `assert (exc.value.linha, exc.value.coluna) == (1, coluna)` + `:191` `"já declarado"` ; aninhado `:222` `verificar_escopos()` sem raise ; não decl. `:254` `(1,coluna)` + `:255` `"não declarado"` ; **base (FIX-1)** `:201` `sa.verificar_escopos()` sem raise + `:202` `assert tabela.simbolo_lexico("a").tipo == "int"` ; redecl. genuína nas 2 passadas `:212-216` | ✅ PASS (Fix 1 resolvido) |
| ASEM-05 `break` fora de `for`→erro; dentro→ok | dentro ok; fora→`SemanticError` pos. | `tests/test_semantic.py:244` `verificar_break()` sem raise ; fora `:265` — `assert (exc.value.linha, exc.value.coluna) == (1, coluna)` | ✅ PASS |

### P1: Geração de Código Intermediário (GCI-01/02)

| Criterion | Spec-defined outcome | `file:line` + assertion | Result |
| --------- | -------------------- | ----------------------- | ------ |
| GCI-01 TAC p/ expr, atrib, if/else, for, print/read, alloc/arrays, funções | sequências TAC corretas | `tests/test_codegen.py:92` if/else (rótulos/gotos exatos) ; `:121` for completo ; `:204` — `assert any(i.endswith("= call g, 1") for i in cod)` ; print/read/alloc/array | ✅ PASS |
| GCI-02 temporários intermediários respeitando precedência `* / %` antes de `+ -` | `a=b+c*d`→`t1=c*d; t2=b+t1; a=t2` | `tests/test_codegen.py:54` — `assert sem_rotulos(cod) == ["t1 = c * d", "t2 = b + t1", "a = t2"]` ; `:65` precedência ; `:71` assoc | ✅ PASS |

### P1: Saída ao terminal e tratamento de erro (OUT-01/02)

| Criterion | Spec-defined outcome | `file:line` + assertion | Result |
| --------- | -------------------- | ----------------------- | ------ |
| OUT-01 sucesso → 6 blocos na ordem a..f | (a) árvore (b) tabela c/ tipo (c)(d)(e) sucessos (f) TAC, NESTA ordem | `tests/test_e2e.py:71` — `assert all(posicoes[i] < posicoes[i + 1] ...)` ; (a) `:77` `"+ b 1" in bloco` ; (b) `:83-84` `"a: tipo=int"` / `"b: tipo=int"` ; (f) `:104-105` ; **programa global válido (FIX-1)** `:126-128` 6 blocos em ordem para `compilar("int a;")` + `:131` `"a: tipo=int"` ; `:139-141` `main("int a;")` exit 0 c/ 6 blocos | ✅ PASS (Fix 1 resolvido) |
| OUT-02 erro → para no 1º, 1 msg linha/coluna, exit≠0 | UMA linha `linha:coluna: msg`; exit≠0; sem blocos | `tests/test_e2e.py:140-141` — `assert codigo != 0` + `assert_uma_msg_posicional(err, out)` (`:55-59` valida 1 linha + regex `^\d+:\d+:` + ausência dos 6 marcadores) | ✅ PASS |

### P2: Documentação / Entrega (DOC-01/02, ENT-01/02/03)

| Criterion | Spec-defined outcome | `file:line` / evidência | Result |
| --------- | -------------------- | ----------------------- | ------ |
| DOC-01 docs de gramática (BNF→conv, sem rec. esq., fatoração, prova LL(1), tabela) | doc presente e coerente | `docs/gramatica.md` (19 KB) — review manual; coerente c/ `grammar.py` | ✅ (review manual, sem teste) |
| DOC-02 docs de SDD (EXPA/DEC, prova L-atribuída, SDT; SDD/SDT GCI) | doc presente | `docs/sdd-semantica.md` (16 KB), `docs/sdd-gci.md` (9.7 KB) — review manual | ✅ (review manual, sem teste) |
| ENT-01 3 programas ≥100 linhas, sem erro, c/ chamada | p1/p2/p3 válidos | `tests/test_e2e.py:233` — `assert len(linhas) >= 100` ; `:243` — `assert "call " in tac` ; medido: 167/151/160 linhas | ✅ PASS |
| ENT-02 `make` executa léxico+sintático+pipeline sem erros/warnings | targets ok | `make test`/`make run`/`make clean` exit 0, sem warnings (executado) | ✅ PASS |
| ENT-03 README: integrantes, versão Python, como executar, estrutura | conteúdo presente | `README.md` §Integrantes/Requisitos/Como executar/Estrutura | ✅ PASS |

### P3: Otimização (PERF-01)

| Criterion | Outcome | Evidência | Result |
| --------- | ------- | --------- | ------ |
| PERF-01 medir/reduzir tempo médio (≥100 linhas) | não definido com valor preciso na spec; sem teste | — (FIRST/FOLLOW/tabela memoizados em `grammar.py:322-333,428`; pipeline roda <0.3 s) | ⚠️ N/A (P3, sem teste — escopo) |

**Status**: 16/16 ACs P1+P2 com asserção ancorada na spec; PERF-01 N/A (P3). **Fix 1 RESOLVIDO** (commit `8f4248e`): ASEM-04 e OUT-01 agora cobrem a declaração no escopo base com testes de regressão dedicados (re-verify #2).

---

## Discrimination Sensor

### Re-verify #2 — sensor focado na área corrigida (Fix 1)

3 mutações centradas no reset de escopo (correção) e nas checagens adjacentes, para garantir que os **novos** testes de regressão são discriminantes. Cada uma aplicada em rascunho, gate relevante executado, **revertida com `git checkout -- <arquivo>`**; working tree verificado limpo após cada uma.

| # | File:line | Mutação | Gate | Killed? |
| - | --------- | ------- | ---- | ------- |
| R1 | `src/semantic.py:285` | remover `self.tabela.scopes = [Scope(nivel=0)]` (reintroduz o bug — sem reset da pilha) | `test_semantic.py`/`test_e2e.py -k 'escopo_base or declaracao_unica'` | ✅ Killed (3 falhas: `test_semantic.py::...escopo_base_apos_inserir_tipos_ok`, `test_e2e.py::...escopo_base_compila_seis_blocos`, `test_e2e.py::...escopo_base_exit_0`) |
| R2 | `src/symbol_table.py:135` | `if escopo.tem_local(nome):` → `if False:` (desliga detecção de redeclaração) | `test_semantic.py -k 'redeclaracao or colisao or parametro_e_local'` | ✅ Killed (4 falhas: redeclaração mesmo escopo, nas 2 passadas, colisão de funções, parâmetro×local) |
| R3 | `src/semantic.py:242` | `if t_esq != t_dir:` → `if False:` (tipos mistos passam — sanity em verificar_tipos) | `test_semantic.py -k 'tipos_mistos or int_mais_float'` | ✅ Killed (2 falhas: DID NOT RAISE SemanticError) |

**Sensor depth**: focado (re-verify) — 3 mutações na correção e checagens adjacentes.
**Result**: 3/3 killed, 0 sobreviventes — ✅ PASS. R1 confirma que **remover o fix reintroduz o bug e os novos testes de base o pegam** (discriminantes). R2 confirma **não-regressão** da detecção genuína de redeclaração. R3 é sanity de que verificar_tipos segue discriminante.

> Working tree confirmado limpo (`git status --porcelain -uno` vazio) e suíte verde (156 passed) após reverter as 3 mutações.

### Rodada #1 (histórico) — sensor da feature completa

8 mutações de nível de comportamento, 1 por área de maior risco; todas mortas (8/8) na 1ª verificação. Mantido como registro.

| # | File:line | Mutação | Killed? |
| - | --------- | ------- | ------- |
| M1 | `src/lexer.py:139` | `if not self._peek().isdigit():` → `if False:` | ✅ Killed |
| M2 | `src/symbol_table.py:171` | `for escopo in reversed(self.scopes):` → `for escopo in self.scopes:` | ✅ Killed |
| M3 | `src/grammar.py:294` | não semeia FOLLOW(PROGRAM) | ✅ Killed |
| M4 | `src/parser.py:141` | inverte decisão ATRIBSTAT/ident | ✅ Killed |
| M5 | `src/semantic.py:242` | tipos mistos passam | ✅ Killed |
| M6 | `src/semantic.py:340` | break sempre válido | ✅ Killed |
| M7 | `src/codegen.py` | inverte ordem dos operandos | ✅ Killed |
| M8 | `src/ast_nodes.py:71-75` | `pre_ordem` emite `dir` antes de `esq` | ✅ Killed |

---

## Code Quality

| Principle | Status |
| --------- | ------ |
| Minimum code (sem features além do pedido) | ✅ |
| Surgical changes / sem abstrações de uso único | ✅ |
| No scope creep (Out of Scope respeitado: sem otimização TAC, sem máquina real, para no 1º erro) | ✅ |
| Só arquivos necessários tocados | ✅ |
| Matches patterns/style (dataclasses, docstrings PT, nomes consistentes) | ✅ |
| Spec-anchored outcome check (valores afirmados batem com a spec) | ✅ |
| Per-layer Coverage: domínio 1:1 com ACs; e2e cobre happy+edge+erro | ✅ |
| Todo teste mapeia a AC/edge/Done-when — sem testes órfãos | ✅ |
| Guidelines documentadas seguidas | ✅ `coding-principles.md` (strong defaults; nenhuma guideline de projeto pré-existente) |

**Spot-check em profundidade — P1 GCI (GCI-02):** `tests/test_codegen.py:54` afirma `["t1 = c * d", "t2 = b + t1", "a = t2"]`, exatamente o Independent Test da spec (`a = b + c * d`). Não é asserção rasa: fixa ordem, precedência (`*` antes de `+`) e numeração determinística de temporários. O sensor M7 confirma discriminação. Codegen e semantic colapsam as cadeias `NUMEXPR'/TERM'/EXPRESSION'` com a **mesma** precedência/associatividade (DRY conceitual), sem duplicar lógica de forma divergente.

---

## Edge Cases

- [x] Arquivo vazio aceito (`PROGRAM → ε`): `test_lexer.py:132`, `test_parser.py:82`, `test_e2e.py:120`
- [x] String não fechada → erro léxico posicional: `test_lexer.py:108` `(2,7)`
- [x] Número malformado `12.` / `1.2.3` → erro léxico: `test_lexer.py:116,123` `(1,5)`
- [x] `ident(` FUNCCALL vs `ident[` LVALUE por lookahead: `test_parser.py:162,171` + `test_parser.py:121`
- [x] Dangling-else casa com o `if` mais próximo: `test_parser.py:142`
- [x] Uso antes de declarar (escopo alcançável) → erro: `test_semantic.py:223` (confirmado também `{ a = 1; int a; }` → `1:3: ... 'a' não declarado`)
- [x] Tipo não declarado em expressão → erro de verificação de tipos: `test_semantic.py:168`
- [x] `return` fora de função → aceito conforme gramática (documentado): confirmado `compilar("return;")` → OK (sem teste dedicado; comportamento documentado na spec)
- [x] **Declaração de topo (global) em statement único `int a;`** → RESOLVIDO (Fix 1, commit `8f4248e`): `compilar("int a;")` emite os 6 blocos (exit 0) e tipa `a` como `int`. Regressão: `test_e2e.py:120,134` + `test_semantic.py:194`.

---

## Gate Check

- **Gate command (Build)**: `python3.11 -W error -m py_compile src/*.py main.py && python3.11 -m pytest -q`
- **Result (re-verify #2)**: 156 passed, 0 failed, 0 skipped (py_compile com `-W error` sem warnings)
- **Test count antes do fix** (rodada #1): 152 testes
- **Test count após o fix** (HEAD `8f4248e`): 156 testes
- **Delta**: +4 testes de regressão (2 em `test_semantic.py`, 2 em `test_e2e.py`) — nenhum teste enfraquecido/apagado
- **Skipped**: nenhum
- **Failures**: nenhuma
- **Extras**: `make test` (156 passed), `make run ARQ=programas/p1.cc` (exit 0, sem stderr), `make clean` (exit 0); 3 programas via `python3.11 main.py programas/pN.cc` → exit 0, sem stderr; `python3.11 main.py` sobre `int a;` → exit 0, 6 blocos.

---

## Fix Plans

### Fix 1: Falso positivo de redeclaração para declaração no escopo base/global — ✅ RESOLVIDO (commit `8f4248e`, re-verify #2)

- **Status**: ✅ RESOLVIDO. Correção: `verificar_escopos()` reinicia a pilha de escopos semânticos com base limpa (`self.tabela.scopes = [Scope(nivel=0)]`, `src/semantic.py:285`) antes de andar a árvore — declarações de nível base feitas por `inserir_tipos` não vazam para a 2ª passada. Léxico global e tipos preservados (verificar_tipos roda antes). Evidência: `compilar("int a;")` → exit 0, 6 blocos, `a: tipo=int`; redeclaração genuína segue erro posicional. Testes de regressão: `test_semantic.py:194` (`...escopo_base_apos_inserir_tipos_ok`), `test_e2e.py:120` (`...escopo_base_compila_seis_blocos`), `test_e2e.py:134` (`...escopo_base_exit_0`); não-regressão em `test_semantic.py:205` (`...redeclaracao_em_bloco_preservada_nas_duas_passadas`). Sensor R1 confirma que remover o reset reintroduz o bug e os novos testes o pegam (3/3 falham). Suíte: 156 passed.
- **Severidade (original)**: Major (programa válido pela gramática era rejeitado; violava OUT-01 "programa válido → 6 blocos" e ASEM-04 para essa classe de entrada).
- **Repro**: `python3.11 main.py` sobre fonte `int a;` (ou qualquer `PROGRAM → STATEMENT` cujo único statement seja um `VARDECL` no escopo base) → `1:5: identificador 'a' já declarado neste escopo` em vez dos 6 blocos.
- **Não afeta**: programas com funções ou blocos `{...}` (escopos são push/pop em ambas as passadas, então o escopo base fica vazio). Os 3 exemplos e toda a suíte passam.
- **Root cause**: `main.compilar` (`main.py:52-64`) compartilha a MESMA `SymbolTable` entre `inserir_tipos` (`src/semantic.py:123`) e `verificar_escopos` (`src/semantic.py:257`). Declarações feitas diretamente no escopo base (nível 0) na 1ª passada **nunca são desempilhadas** (não há `pop_scope` do base). Na 2ª passada, `declarar` (`src/symbol_table.py:135`) encontra `escopo.tem_local(nome)` verdadeiro e levanta `SemanticError`. Para declarações em bloco/função o bug não aparece porque o escopo é criado e descartado nas duas passadas.
- **Fix task** (não aplicado — autor≠verificador):
  - **What**: isolar o estado de escopo entre as travessias semânticas que mutam a pilha (`inserir_tipos`, `verificar_escopos`), de modo que declarações de nível base de uma passada não vazem para a seguinte.
  - **Where**: `src/semantic.py` (`inserir_tipos`/`verificar_escopos`) e/ou `main.py:compilar`; possivelmente um reset/snapshot da pilha de escopos em `src/symbol_table.py`.
  - **Verify**: novo teste e2e/semântico — `compilar("int a;")` retorna os 6 blocos (exit 0); `int a; ... ` global tipado corretamente; sem regressão na suíte (152 verdes).
  - **Done when**: programa de statement único com declaração global compila sem erro e tipa o símbolo; redeclaração genuína no mesmo escopo continua erro; suíte verde.
- **Cobertura**: nenhum teste exercita declaração de nível base/global (todos os casos de declaração estão em função ou bloco) — daí o defeito ter passado pela suíte e pelo sensor.

---

## Requirement Traceability Update

| Requirement | Previous Status | New Status |
| ----------- | --------------- | ---------- |
| AL-01 | Pending | ✅ Verified |
| AL-02 | Pending | ✅ Verified |
| AL-03 | Pending | ✅ Verified |
| AS-01 | Pending | ✅ Verified |
| AS-02 | Pending | ✅ Verified |
| AS-03 | Pending | ✅ Verified |
| ASEM-01 | Pending | ✅ Verified |
| ASEM-02 | Pending | ✅ Verified |
| ASEM-03 | Pending | ✅ Verified |
| ASEM-04 | ❌ Needs Fix | ✅ Verified (Fix 1 resolvido — `8f4248e`; regressão de escopo base coberta) |
| ASEM-05 | Pending | ✅ Verified |
| GCI-01 | Pending | ✅ Verified |
| GCI-02 | Pending | ✅ Verified |
| OUT-01 | ⚠️ Verified c/ ressalva | ✅ Verified (Fix 1 resolvido — programa global válido emite os 6 blocos) |
| OUT-02 | Pending | ✅ Verified |
| DOC-01 | Pending | ✅ Verified (review manual) |
| DOC-02 | Pending | ✅ Verified (review manual) |
| ENT-01 | Pending | ✅ Verified |
| ENT-02 | Pending | ✅ Verified |
| ENT-03 | Pending | ✅ Verified |
| PERF-01 | Pending | ⚠️ N/A (P3, sem teste) |

---

## Summary

**Overall (re-verify #2)**: ✅ Ready — Fix 1 resolvido, sem regressões.

**Spec-anchored check**: 16/16 ACs P1+P2 com asserção ancorada na spec; PERF-01 N/A (P3). ASEM-04 e OUT-01 agora cobrem a declaração no escopo base com testes de regressão dedicados.
**Sensor (re-verify)**: 3/3 mutações mortas, 0 sobreviventes (focado na correção; rodada #1: 8/8).
**Gate**: 156 passed, 0 failed (antes do fix: 152; delta +4 testes de regressão, nenhum enfraquecido).

**What works**: pipeline completa (léxico DFA char-a-char, parser LL(1) por tabela única sem conflitos, 5 travessias semânticas, TAC) sobre os 3 exemplos (≥100 linhas, com chamada) e todos os casos da suíte; 6 blocos na ordem correta; parada no 1º erro com posição; **todos** os edge cases da spec cobertos, incluindo agora a declaração de topo no escopo base (`int a;`); Makefile/README/docs presentes e coerentes; suíte discriminante.

**Issues found**: nenhum gap aberto. Fix 1 (falso `já declarado` para declaração no escopo base por estado de escopo compartilhado entre `inserir_tipos` e `verificar_escopos`) foi corrigido em `8f4248e` resetando a pilha de escopos semânticos no início de `verificar_escopos`; detecção genuína de redeclaração intacta (sensor R1/R2).

**Next steps**: nenhum — feature pronta. Lição L-001 da 1ª rodada permanece registrada (ver abaixo); nenhuma nova lição obrigatória (PASS limpo).

---

## Lessons (destiladas)

- **Rodada #1 — L-001** (permanece): ac_gap / defeito real (Fix 1) — `src/semantic.py` (inserir_tipos × verificar_escopos compartilham SymbolTable).
  - Texto: "Travessias semânticas que mutam a mesma pilha de escopos devem resetar/isolar o estado entre passadas — declarações no escopo base não são desempilhadas e disparam falsa redeclaração na passada seguinte."
  - Cobertura adicionada no fix: testes para declaração de nível base/global (`int a;`), classe de entrada antes não exercitada — `test_semantic.py:194`, `test_e2e.py:120,134`.
- **Re-verify #2**: PASS limpo, 0 sobreviventes no sensor, 0 gaps abertos → nenhuma nova lição obrigatória. L-001 permanece como registro.
