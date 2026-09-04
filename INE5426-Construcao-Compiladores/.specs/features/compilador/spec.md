# Especificação — Compilador ConvCC-2026-1 (Fases de Análise e Síntese)

## Problem Statement

O EP da disciplina INE5426 (Construção de Compiladores) exige implementar as fases de **análise** (léxica, sintática, semântica) e **síntese** (geração de código intermediário) para a linguagem `ConvCC-2026-1`, derivada da gramática `CC-2026-1` (baseada em X++ de Delamaro). A entrega é avaliada executando programas na linguagem e verificando saídas ao terminal e captura de erros. A nota é `T = (T1+T2+T3+T4+T5) × T6` (máx. 10), penalizada por warnings, ausência de Makefile/README e erros de execução.

## Goals

- [x] **AL (T1, 0–1.0)** — Analisador léxico char-a-char baseado em diagramas de transição, com tabela de símbolos extensível (uma entrada por `ident`, lista de ocorrências linha/coluna) e captura de erros léxicos.
- [x] **AS (T2, 0–2.0)** — Gramática transformada para LL(1) (convencional → sem recursão à esquerda → fatorada → LL(1)), tabela de reconhecimento construída **uma única vez**, parser preditivo que aceita/rejeita a entrada e captura erros sintáticos.
- [x] **ASem (T3, 0–3.0)** — Árvore de expressão via SDD L-atribuída; inserção de tipo na tabela de símbolos; verificação de tipos em expressões; verificação de identificadores por escopo; verificação de `break` dentro de repetição.
- [x] **GCI (T4, 0–3.0)** — SDD L-atribuída + SDT que gera código de três endereços para os comandos de `ConvCC-2026-1`.
- [x] **Saídas e entrega (T6, 0–1; T5, 0–1.0)** — 6 saídas de sucesso ao terminal, mensagem de erro com linha/coluna no primeiro erro; 3 programas `ConvCC-2026-1` (≥100 linhas, sem erros, com chamadas a função), Makefile e README.

## Out of Scope

Explicitamente excluído para evitar scope creep.

| Item | Motivo |
| ---- | ------ |
| Geração de código de máquina / assembly real | O enunciado pede apenas código intermediário (TAC). |
| Otimização de código intermediário | Não exigido; fora do escopo de GCI. |
| Recuperação de erros / múltiplos erros por execução | Enunciado manda parar no primeiro erro. |
| Interpretação/execução dos programas `ConvCC-2026-1` (rodar a lógica) | Avalia-se compilação até código intermediário, não execução semântica. |
| Gerador de léxico/parser (flex, ANTLR, yacc) para o léxico | AL deve ser char-a-char manual (AD-003). |
| Suporte multi-arquivo de entrada / módulos da linguagem-fonte | A entrada é um único programa por execução. |

---

## Assumptions & Open Questions

| Assumption / decisão | Default escolhido | Racional | Confirmado? |
| -------------------- | ----------------- | -------- | ----------- |
| Linguagem de implementação | Python 3.11 (AD-001) | Velocidade de desenvolvimento; T5 pequeno e proporcional | y |
| Estratégia de parser | Tabela preditiva LL(1), tabela construída uma vez (AD-002) | Critério explícito de avaliação da AS | y |
| Formato do código intermediário | Código de três endereços (TAC) das aulas (AD-004) | Exigência do enunciado | y |
| Idioma das mensagens/saídas | Português (AD-005) | Enunciado descreve as mensagens em PT | y |
| Framework de teste | pytest (AD-006) | Padrão Python; provisório | n |
| Integrantes do grupo (cabeçalho dos programas e README) | Placeholder `<NOME 1>..<NOME N>` | Desconhecidos; usuário preenche | n |
| Prazo de entrega | 26-jun-2026 (já passado em 27-jun-2026) | Confirmar prorrogação com o usuário | n |
| Comentários `//` ou `/* */` na linguagem-fonte | A gramática BNF não define comentários → **não** suportar; tratar `/` apenas como operador de divisão | A gramática fornecida não inclui comentários | n |
| Desambiguação `dangling-else` | `else` casa com o `if` mais próximo (preferir casar `else`) | Resolução LL(1) padrão | y |
| Desambiguação `LVALUE`/`FUNCCALL` após `=` (`ident(` vs `ident[`) | Fatorar prefixo `ident`: lookahead `(` ⇒ FUNCCALL, caso contrário EXPRESSION/LVALUE | Necessário para LL(1) | y |

**Open questions:** Idioma das mensagens, prazo e integrantes são confirmáveis sem bloquear o plano; suporte a comentários a confirmar com o professor/monitor. Demais itens resolvidos acima.

---

## User Stories

### P1: Análise Léxica + Tabela de Símbolos ⭐ MVP

**User Story**: Como avaliador, quero que o analisador leia o programa caractere a caractere e produza tokens + tabela de símbolos, para validar a tarefa AL.

**Why P1**: Base de toda a pipeline; T1.

**Acceptance Criteria**:
1. QUANDO o léxico recebe um programa válido ENTÃO DEVE produzir a sequência de tokens (palavras-chave, `ident`, `int_constant`, `float_constant`, `string_constant`, operadores e pontuação) lendo char-a-char via DFA.
2. QUANDO um `ident` ocorre ENTÃO a tabela de símbolos DEVE ter **uma** entrada para ele com a **lista de ocorrências** (linha, coluna) e suportar inserção de novas propriedades (ex.: tipo).
3. QUANDO há um caractere/lexema inválido ENTÃO o léxico DEVE parar e reportar erro léxico com **linha e coluna**.

**Independent Test**: Rodar o léxico sobre um `.cc` válido e ver tokens+tabela; sobre um `.cc` com `@` ver erro léxico com posição.

---

### P1: Análise Sintática LL(1) dirigida por tabela ⭐ MVP

**User Story**: Como avaliador, quero uma tabela de reconhecimento LL(1) construída uma vez e um parser que decide a pertinência da entrada, para validar a tarefa AS.

**Why P1**: T2; condiciona análise semântica e GCI.

**Acceptance Criteria**:
1. QUANDO o sistema inicia ENTÃO DEVE construir FIRST/FOLLOW e a tabela LL(1) **uma única vez** e a tabela DEVE estar **sem conflitos** não resolvidos.
2. QUANDO a entrada pertence à linguagem ENTÃO o parser preditivo (pilha) DEVE aceitá-la consumindo todos os tokens até `$`.
3. QUANDO a entrada **não** pertence ENTÃO o parser DEVE parar no primeiro erro sintático e reportar **linha e coluna** e o token esperado/encontrado.

**Independent Test**: Parser aceita os 3 programas-exemplo; rejeita um programa com `;` faltando, indicando posição.

---

### P1: Análise Semântica (5 pontos) ⭐ MVP

**User Story**: Como avaliador, quero árvore de expressão, tipos na tabela, verificação de tipos, de escopo e de `break`, para validar a tarefa ASem.

**Why P1**: T3 (maior peso junto com GCI).

**Acceptance Criteria**:
1. QUANDO uma expressão aritmética (produções EXPA) é analisada ENTÃO o sistema DEVE construir uma **árvore de expressão T** (nós só com operadores e operandos) por SDD L-atribuída/SDT e imprimi-la em varredura **raiz-esquerda-direita**.
2. QUANDO uma declaração de variável (produções DEC) é analisada ENTÃO o **tipo** DEVE ser inserido na tabela de símbolos por SDD L-atribuída/SDT.
3. QUANDO uma expressão aritmética é verificada ENTÃO ela DEVE ser válida **somente se todos os operandos têm o mesmo tipo** (consultando o tipo na tabela); caso contrário, erro semântico com linha/coluna.
4. QUANDO há declaração duplicada no mesmo escopo, ou nome de função e variável iguais no mesmo escopo, ou uso de `ident` não declarado em nenhum escopo alcançável ENTÃO DEVE ocorrer erro semântico; declarações iguais em escopos aninhados distintos DEVEM ser permitidas.
5. QUANDO um `break` está fora do escopo de um `for` ENTÃO DEVE ocorrer erro semântico; quando está dentro, DEVE ser aceito.

**Independent Test**: `a+b*4.7` com `a,b` float → válido; `a+b*"x"` com tipos mistos → erro; `int a; string a;` no mesmo escopo → erro; `break` fora de `for` → erro.

---

### P1: Geração de Código Intermediário ⭐ MVP

**User Story**: Como avaliador, quero código de três endereços para o programa de entrada, para validar a tarefa GCI.

**Why P1**: T4.

**Acceptance Criteria**:
1. QUANDO um programa válido é compilado ENTÃO o sistema DEVE emitir **código de três endereços** (temporários, rótulos, gotos) para expressões, atribuições, `if`/`else`, `for`, `print`, `read`, alocação/arrays e funções (`def`/`return`/chamada), no formato das aulas.
2. QUANDO uma expressão aninhada ocorre ENTÃO o código DEVE usar temporários intermediários respeitando precedência (`* / %` antes de `+ -`).

**Independent Test**: Snippet `a = b + c * d;` gera `t1 = c * d; t2 = b + t1; a = t2`.

---

### P1: Saída ao terminal e tratamento de erro ⭐ MVP

**User Story**: Como avaliador, quero todas as saídas no terminal e parada no primeiro erro com posição, conforme a seção 8.

**Why P1**: É o contrato observável da avaliação (T6 e correção de T1–T4).

**Acceptance Criteria**:
1. QUANDO a compilação tem sucesso ENTÃO o terminal DEVE exibir, nesta ordem semântica: (a) árvore de expressão por expressão aritmética (raiz-esq-dir); (b) tabela(s) de símbolos com atributo de tipo por `ident`; (c) mensagem de sucesso de verificação de tipos; (d) mensagem de sucesso de declarações por escopo; (e) mensagem de sucesso de `break` em `for`; (f) o código intermediário.
2. QUANDO ocorre qualquer erro (léxico/sintático/semântico) ENTÃO o sistema DEVE parar no **primeiro** erro e exibir mensagem esclarecedora com **linha e coluna**.

**Independent Test**: Rodar `main` sobre programa válido → 6 blocos de saída; sobre programa com erro → 1 mensagem com posição e código de saída ≠ 0.

---

### P2: Artefatos teóricos (documentação avaliável)

**User Story**: Como avaliador, quero ver as transformações de gramática e as SDDs demonstradas, pois o enunciado pede para "mostrar" e "demonstrar".

**Why P2**: Sustenta a nota de AS/ASem/GCI; não é executável mas é exigido para nota cheia.

**Acceptance Criteria**:
1. QUANDO a AS é avaliada ENTÃO DEVE existir documento com: BNF→convencional, remoção de recursão à esquerda, fatoração à esquerda, prova de LL(1) (FIRST/FOLLOW disjuntos) e a tabela.
2. QUANDO ASem/GCI são avaliados ENTÃO DEVE existir documento com EXPA e DEC separados, SDD L-atribuída de cada, prova de que são L-atribuídas, e a SDT correspondente; e a SDD/SDT de geração de código.

**Independent Test**: Abrir `docs/` e verificar que cada item acima está presente e coerente com o código.

---

### P2: Programas-exemplo, Makefile e README (entrega)

**User Story**: Como avaliador, quero 3 programas válidos, um Makefile que executa, e um README, pois condicionam T6.

**Why P2**: Se faltarem, T6 = 0 (zera a nota).

**Acceptance Criteria**:
1. QUANDO os exemplos são abertos ENTÃO DEVEM existir **3 programas** `ConvCC-2026-1` com **≥100 linhas cada**, sem erros léxicos/sintáticos/semânticos e **com chamadas a função**.
2. QUANDO `make` é executado ENTÃO DEVE compilar/interpretar e executar o léxico e o sintático (e a pipeline) **sem erros e sem warnings**.
3. QUANDO o README é aberto ENTÃO DEVE conter integrantes, versão do Python, como executar e a estrutura do projeto.

**Independent Test**: `make run ARQ=programas/p1.cc` produz saída limpa para os 3 exemplos; `make` sem erros.

---

### P3: Otimização do tempo de compilação (T5)

**User Story**: Como grupo, quero minimizar o tempo médio de compilação para maximizar T5.

**Why P3**: T5 vale no máx. 1.0 e é proporcional (`1.0 × t/tg`); ganho marginal.

**Acceptance Criteria**:
1. QUANDO a pipeline roda sobre entradas ≥100 linhas ENTÃO o tempo médio DEVE ser medido e reduzido onde for barato (evitar recomputar FIRST/FOLLOW/tabela; I/O eficiente).

---

## Edge Cases

- QUANDO o arquivo de entrada está vazio ENTÃO `PROGRAM → ε` DEVE ser aceito (programa vazio é válido).
- QUANDO um `string_constant` não é fechado ENTÃO DEVE haver erro léxico com posição.
- QUANDO um número tem forma inválida (ex.: `12.` ou `1.2.3`) ENTÃO DEVE haver erro léxico.
- QUANDO `ident(` aparece em ATRIBSTAT (FUNCCALL) vs `ident[` (LVALUE) ENTÃO o parser DEVE desambiguar por lookahead após fatoração.
- QUANDO há `if ... else` aninhado (dangling-else) ENTÃO o `else` DEVE casar com o `if` mais próximo.
- QUANDO uma variável é usada antes de declarada no escopo alcançável ENTÃO erro semântico de identificador.
- QUANDO uma expressão usa `ident` cujo tipo não está na tabela ENTÃO erro semântico de verificação de tipos.
- QUANDO `return` ocorre fora de função (a gramática permite no STATEMENT) ENTÃO documentar o comportamento (aceitar conforme gramática; checagem de retorno fora de função é fora de escopo salvo orientação contrária).

---

## Requirement Traceability

| Requirement ID | Story | Fase | Status |
| -------------- | ----- | ---- | ------ |
| AL-01 | P1 Léxico | Done | ✅ Verified |
| AL-02 | P1 Léxico (tabela de símbolos) | Done | ✅ Verified |
| AL-03 | P1 Léxico (erro léxico) | Done | ✅ Verified |
| AS-01 | P1 Sintático (FIRST/FOLLOW + tabela única) | Done | ✅ Verified |
| AS-02 | P1 Sintático (aceitação) | Done | ✅ Verified |
| AS-03 | P1 Sintático (erro sintático) | Done | ✅ Verified |
| ASEM-01 | P1 Semântico (árvore de expressão) | Done | ✅ Verified |
| ASEM-02 | P1 Semântico (tipo na tabela) | Done | ✅ Verified |
| ASEM-03 | P1 Semântico (verificação de tipos) | Done | ✅ Verified |
| ASEM-04 | P1 Semântico (escopo) | Done | ✅ Verified |
| ASEM-05 | P1 Semântico (break em for) | Done | ✅ Verified |
| GCI-01 | P1 GCI (TAC) | Done | ✅ Verified |
| GCI-02 | P1 GCI (temporários/precedência) | Done | ✅ Verified |
| OUT-01 | P1 Saída de sucesso (6 blocos) | Done | ✅ Verified |
| OUT-02 | P1 Erro no primeiro com linha/coluna | Done | ✅ Verified |
| DOC-01 | P2 Documentação AS | Done | ✅ Verified |
| DOC-02 | P2 Documentação ASem/GCI | Done | ✅ Verified |
| ENT-01 | P2 Três programas-exemplo | Done | ✅ Verified |
| ENT-02 | P2 Makefile | Done | ✅ Verified |
| ENT-03 | P2 README | Done | ✅ Verified |
| PERF-01 | P3 Tempo de compilação (T5) | - | ⚠️ N/A (P3, sem teste) |

**ID format:** `[CATEGORIA]-[NÚMERO]`

**Coverage:** 21 requisitos; mapeamento para tarefas em `tasks.md` (Test Co-location Validation).

---

## Success Criteria

- [x] Os 3 programas-exemplo compilam sem erro e produzem os 6 blocos de saída corretos.
- [x] Programas com erro léxico/sintático/semântico param no primeiro erro com linha e coluna corretas.
- [x] `make` executa sem erros nem warnings; README e Makefile presentes.
- [x] Documentação teórica (transformações de gramática + SDDs) coerente com a implementação.
- [x] Tabela LL(1) construída uma única vez, sem conflitos não resolvidos.
