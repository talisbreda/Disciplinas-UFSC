# STATE

## Decisions

### AD-001
- **Decision**: O compilador (fases de análise e síntese) será implementado em Python 3.11.
- **Reason**: Maior velocidade de desenvolvimento de um compilador correto sob prazo — `dict` para tabela de símbolos, leitura char-a-char e manipulação de strings nativas, sem etapa de build. A penalidade de tempo (T5) é pequena e proporcional (máx. 1.0 de 10).
- **Trade-off**: Execução mais lenta que C/C++/Rust, podendo reduzir T5. Exige declarar a versão exata no Makefile (`python3.11`).
- **Scope**: Todo o projeto (lexer, parser, semântico, GCI, driver, testes).
- **Date**: 2026-06-27
- **Status**: active

### AD-002
- **Decision**: O analisador sintático será um parser preditivo **não-recursivo dirigido por tabela** (LL(1)), com FIRST/FOLLOW e tabela de reconhecimento construídos explicitamente **uma única vez**.
- **Reason**: O enunciado avalia diretamente "a construção da tabela de reconhecimento sintático (uma única vez)". Uma tabela explícita + parser com pilha atende ao critério sem ambiguidade.
- **Trade-off**: Mais código de infraestrutura (FIRST/FOLLOW/tabela) do que descida recursiva.
- **Scope**: Tarefa AS e toda a pipeline que consome o parser.
- **Date**: 2026-06-27
- **Status**: active

### AD-003
- **Decision**: O analisador léxico será um autômato finito determinístico escrito à mão (leitura caractere a caractere, baseado em diagramas de transição). **Não** será usado gerador de léxico (flex/ANTLR).
- **Reason**: O enunciado exige explicitamente "ler caractere por caractere da entrada e ser baseado em diagramas de transição".
- **Trade-off**: Mais código manual de scanning.
- **Scope**: Tarefa AL.
- **Date**: 2026-06-27
- **Status**: active

### AD-004
- **Decision**: O código intermediário gerado será **código de três endereços (TAC)** no formato apresentado nas aulas teóricas (temporários, rótulos, gotos).
- **Reason**: O enunciado exige "o código descrito nas aulas teóricas".
- **Trade-off**: Nenhum relevante; é o formato esperado.
- **Scope**: Tarefa GCI.
- **Date**: 2026-06-27
- **Status**: active

### AD-005
- **Decision**: O compilador para no **primeiro erro** encontrado e emite mensagem indicando **linha e coluna**. Mensagens de erro/sucesso e saídas ao terminal são em **português**, conforme o enunciado.
- **Reason**: Exigência explícita das seções 8 ("pare o processo no primeiro erro") e de saída.
- **Trade-off**: Sem recuperação de erros / relato múltiplo.
- **Scope**: Todas as fases e o driver.
- **Date**: 2026-06-27
- **Status**: active

### AD-006
- **Decision**: Testes automatizados com `pytest` (estrutura `tests/`); fixtures = programas `ConvCC-2026-1` válidos e inválidos. **Confirmado pelo usuário em 2026-06-27 (antes do Execute).** Ambiente: `python3.11` (Homebrew 3.11.15) + venv `.venv` com pytest; gates rodam via `source .venv/bin/activate && python3.11 -m pytest ...`. O compilador em si usa apenas stdlib (roda em `python3.11` puro); pytest é dependência só de desenvolvimento (não entra no Makefile de entrega).
- **Reason**: Projeto greenfield sem testes; `pytest` é o padrão Python de menor atrito e expressa bem os critérios de aceite end-to-end.
- **Trade-off**: Adiciona uma dependência de desenvolvimento (não entra no Makefile de entrega obrigatório).
- **Scope**: Suíte de testes do projeto.
- **Date**: 2026-06-27
- **Status**: active

## Handoff

- **Feature**: compilador (`.specs/features/compilador/`)
- **Phase / Task**: **Execute concluído** — todas as 8 fases (T1–T20) implementadas + Verifier (re-verify #2) com veredito **PASS ✅**. Fix-1 (falso positivo de redeclaração em escopo base) aplicado e re-verificado.
- **Completed**: T1–T20 (20 commits, `ddf24dd`..`722864b`) + FIX-1 (`8f4248e`). Suíte: **156 testes verdes**. 3 programas-exemplo (167/151/160 linhas) compilam com exit 0. `make` (lex/parse/run/test/clean) sem warnings.
- **In-progress** (file:line): nenhum — feature completa.
- **Next step**: Nomes dos 5 integrantes (com matrículas) já preenchidos nos `programas/*.cc` e no `README.md` (commit `db...`). Confirmar com o monitor se comentários `//`/`/* */` devem ser suportados (atualmente não são). Entregar via Moodle (atenção: prazo era 26-jun-2026).
- **Blockers**: Prazo do enunciado (26-jun-2026) já passou (data atual 27-jun-2026) — confirmar prorrogação/aceitação com o monitor.
- **Uncommitted files**: dirs de IDE (`.agents/`, `.claude/`, `.cursor/`, `.windsurf/`) e `trabalho_compiladores.pdf` permanecem untracked por opção.
- **Branch**: `main` (repositório git inicializado na Fase 0).
- **Validação**: `.specs/features/compilador/validation.md` (PASS; sensor rodada #1 8/8 mortos, re-verify #2 3/3 mortos; 16/16 ACs P1+P2 ancorados na spec).
