# Gramática LL(1) de ConvCC-2026-1

Este documento mostra a transformação da gramática `CC-2026-1` (BNF do enunciado,
em EBNF) para a forma convencional **LL(1)**, a prova de que o resultado é LL(1)
e a tabela de reconhecimento preditiva. Tudo aqui é coerente com a implementação
em [`src/grammar.py`](../src/grammar.py): mesmos não-terminais, mesmos
auxiliares, mesmas resoluções de conflito. As tabelas FIRST/FOLLOW e a tabela
preditiva foram **geradas pela própria implementação** (`first`, `follow`,
`build_parse_table`).

## 0. Convenções e símbolos

- **Terminais** (em `MAIÚSCULAS`/símbolos) são os `TokenType` do léxico. Apelidos
  usados aqui: `def int float string print read return if else for break new null`
  (palavras-chave), `ident int_constant float_constant string_constant`
  (terminais não triviais), e os símbolos `( ) { } [ ] ; , = < > <= >= == != + - * / %`.
- **Não-terminais** em `MAIÚSCULAS`; auxiliares introduzidos na transformação
  recebem aspa-linha (`'`), p.ex. `NUMEXPR'`.
- **ε** denota a cadeia vazia; **`$`** o marcador de fim de entrada
  (`TokenType.EOF`). O símbolo inicial é **`PROGRAM`**.

---

## 1. Gramática BNF original (EBNF)

`?` = opcional; `*` = zero-ou-mais; `+` = um-ou-mais.

```
PROGRAM         → (STATEMENT | FUNCLIST)?
FUNCLIST        → FUNCDEF FUNCLIST | FUNCDEF
FUNCDEF         → def ident ( PARAMLIST ) { STATELIST }
PARAMLIST       → ( (int|float|string) ident , PARAMLIST | (int|float|string) ident )?
STATEMENT       → VARDECL ; | ATRIBSTAT ; | PRINTSTAT ; | READSTAT ; | RETURNSTAT ;
                | IFSTAT | FORSTAT | { STATELIST } | break ; | ;
VARDECL         → (int|float|string) ident ( [ int_constant ] )*
ATRIBSTAT       → LVALUE = (EXPRESSION | ALLOCEXPRESSION | FUNCCALL)
FUNCCALL        → ident ( PARAMLISTCALL )
PARAMLISTCALL   → ( ident , PARAMLISTCALL | ident )?
PRINTSTAT       → print EXPRESSION
READSTAT        → read LVALUE
RETURNSTAT      → return
IFSTAT          → if ( EXPRESSION ) STATEMENT (else STATEMENT)?
FORSTAT         → for ( ATRIBSTAT ; EXPRESSION ; ATRIBSTAT ) STATEMENT
STATELIST       → STATEMENT (STATELIST)?
ALLOCEXPRESSION → new (int|float|string) ( [ NUMEXPRESSION ] )+
EXPRESSION      → NUMEXPRESSION ( (< | > | <= | >= | == | !=) NUMEXPRESSION )?
NUMEXPRESSION   → TERM ( (+ | -) TERM )*
TERM            → UNARYEXPR ( (* | / | %) UNARYEXPR )*
UNARYEXPR       → (+ | -)? FACTOR
FACTOR          → int_constant | float_constant | string_constant | null
                | LVALUE | ( NUMEXPRESSION )
LVALUE          → ident ( [ NUMEXPRESSION ] )*
```

---

## 2. Forma convencional (eliminação de EBNF)

Cada operador de EBNF é reescrito com produções comuns e `ε` explícito:

- **`X?`** vira uma alternativa adicional `ε` (opcional pode não ocorrer).
- **`(...)*`** (zero-ou-mais) vira recursão **à direita** com um auxiliar:
  `A → β A' ; A' → β A' | ε`.
- **`(...)+`** (um-ou-mais) vira uma ocorrência obrigatória seguida do auxiliar
  de zero-ou-mais: `A → β A' ; A' → β A' | ε`.

Auxiliares introduzidos por eliminação de EBNF: `FUNCLIST'`, `PARAMLIST'`,
`VARDECL'`, `PARAMLISTCALL'`, `IFSTAT'`, `STATELIST'`, `ALLOCEXPRESSION'`,
`EXPRESSION'`, `NUMEXPR'`, `TERM'`, `LVALUE'`. Também introduzimos `TYPE`
(escolha de tipo) e `ATRIBSTAT_RHS` (ver §4, fatoração).

Gramática convencional resultante (símbolo inicial `PROGRAM`):

```
PROGRAM         → STATEMENT | FUNCLIST | ε
FUNCLIST        → FUNCDEF FUNCLIST'
FUNCLIST'       → FUNCDEF FUNCLIST' | ε
FUNCDEF         → def ident ( PARAMLIST ) { STATELIST }
PARAMLIST       → TYPE ident PARAMLIST' | ε
PARAMLIST'      → , PARAMLIST | ε
TYPE            → int | float | string
STATEMENT       → VARDECL ; | ATRIBSTAT ; | PRINTSTAT ; | READSTAT ; | RETURNSTAT ;
                | IFSTAT | FORSTAT | { STATELIST } | break ; | ;
VARDECL         → TYPE ident VARDECL'
VARDECL'        → [ int_constant ] VARDECL' | ε
ATRIBSTAT       → LVALUE = ATRIBSTAT_RHS
ATRIBSTAT_RHS   → EXPRESSION | ALLOCEXPRESSION | FUNCCALL
FUNCCALL        → ident ( PARAMLISTCALL )
PARAMLISTCALL   → ident PARAMLISTCALL' | ε
PARAMLISTCALL'  → , PARAMLISTCALL | ε
PRINTSTAT       → print EXPRESSION
READSTAT        → read LVALUE
RETURNSTAT      → return
IFSTAT          → if ( EXPRESSION ) STATEMENT IFSTAT'
IFSTAT'         → else STATEMENT | ε
FORSTAT         → for ( ATRIBSTAT ; EXPRESSION ; ATRIBSTAT ) STATEMENT
STATELIST       → STATEMENT STATELIST'
STATELIST'      → STATEMENT STATELIST' | ε
ALLOCEXPRESSION → new TYPE [ NUMEXPRESSION ] ALLOCEXPRESSION'
ALLOCEXPRESSION'→ [ NUMEXPRESSION ] ALLOCEXPRESSION' | ε
EXPRESSION      → NUMEXPRESSION EXPRESSION'
EXPRESSION'     → < NUMEXPRESSION | > NUMEXPRESSION | <= NUMEXPRESSION
                | >= NUMEXPRESSION | == NUMEXPRESSION | != NUMEXPRESSION | ε
NUMEXPRESSION   → TERM NUMEXPR'
NUMEXPR'        → + TERM NUMEXPR' | - TERM NUMEXPR' | ε
TERM            → UNARYEXPR TERM'
TERM'           → * UNARYEXPR TERM' | / UNARYEXPR TERM' | % UNARYEXPR TERM' | ε
UNARYEXPR       → + FACTOR | - FACTOR | FACTOR
FACTOR          → int_constant | float_constant | string_constant | null
                | LVALUE | ( NUMEXPRESSION )
LVALUE          → ident LVALUE'
LVALUE'         → [ NUMEXPRESSION ] LVALUE' | ε
```

---

## 3. Remoção de recursão à esquerda

A recursão à esquerda apareceria tipicamente nas regras de expressão
(`E → E + T`) e na lista de funções/sentenças. Como a eliminação de EBNF da §2
já produziu **recursão à direita** (auxiliares `NUMEXPR'`, `TERM'`, `STATELIST'`,
`FUNCLIST'`, etc.), não há recursão à esquerda **direta** — nenhuma alternativa
`A → A …` existe.

Também não há recursão à esquerda **indireta**: o único ciclo de chamadas
"na primeira posição" entre não-terminais ocorre na cadeia de expressões
`EXPRESSION → NUMEXPRESSION → TERM → UNARYEXPR → FACTOR`, e ela termina em
`FACTOR`, cuja primeira posição é sempre um terminal (`int_constant`, `(`, …) ou
`LVALUE → ident …` (terminal `ident`). Logo, nenhum não-terminal deriva a si
mesmo como símbolo mais à esquerda. (O teste `test_sem_recursao_a_esquerda_direta`
verifica a ausência de recursão direta.)

---

## 4. Fatoração à esquerda

Há três pontos com prefixo comum:

1. **`FUNCLIST`** — `FUNCDEF FUNCLIST | FUNCDEF` compartilha o prefixo `FUNCDEF`.
   Fatorado:
   ```
   FUNCLIST  → FUNCDEF FUNCLIST'
   FUNCLIST' → FUNCDEF FUNCLIST' | ε
   ```

2. **`ATRIBSTAT`** — as três opções `LVALUE = EXPRESSION`,
   `LVALUE = ALLOCEXPRESSION` e `LVALUE = FUNCCALL` compartilham o prefixo
   `LVALUE =`. Fatorado em um auxiliar para o lado direito:
   ```
   ATRIBSTAT     → LVALUE = ATRIBSTAT_RHS
   ATRIBSTAT_RHS → EXPRESSION | ALLOCEXPRESSION | FUNCCALL
   ```

3. **`TYPE`** — a escolha `(int|float|string)` aparece em `VARDECL`, `PARAMLIST`
   e `ALLOCEXPRESSION`. Extraída para um não-terminal comum `TYPE → int | float |
   string`. (Cada alternativa tem um terminal distinto, então é LL(1) trivial.)

A fatoração de `ATRIBSTAT` não elimina o conflito interno de `ATRIBSTAT_RHS`,
porque `ident` inicia tanto `EXPRESSION` (via `FACTOR → LVALUE → ident`) quanto
`FUNCCALL → ident (…)`. Esse conflito é tratado como **resolução documentada**
(§6.2), pois decidir entre eles exige inspecionar o token **seguinte** ao
`ident` (se é `(`).

---

## 5. FIRST e FOLLOW

Calculados por ponto-fixo padrão (com tratamento de ε).

### FIRST

| Não-terminal | FIRST |
| --- | --- |
| `PROGRAM` | int, float, string, ident, print, read, return, if, for, {, break, ;, def, **ε** |
| `FUNCLIST` | def |
| `FUNCLIST'` | def, **ε** |
| `FUNCDEF` | def |
| `PARAMLIST` | int, float, string, **ε** |
| `PARAMLIST'` | `,`, **ε** |
| `TYPE` | int, float, string |
| `STATEMENT` | int, float, string, ident, print, read, return, if, for, {, break, ; |
| `VARDECL` | int, float, string |
| `VARDECL'` | [, **ε** |
| `ATRIBSTAT` | ident |
| `ATRIBSTAT_RHS` | +, -, int_constant, float_constant, string_constant, null, ident, (, new |
| `FUNCCALL` | ident |
| `PARAMLISTCALL` | ident, **ε** |
| `PARAMLISTCALL'` | `,`, **ε** |
| `PRINTSTAT` | print |
| `READSTAT` | read |
| `RETURNSTAT` | return |
| `IFSTAT` | if |
| `IFSTAT'` | else, **ε** |
| `FORSTAT` | for |
| `STATELIST` | int, float, string, ident, print, read, return, if, for, {, break, ; |
| `STATELIST'` | int, float, string, ident, print, read, return, if, for, {, break, ;, **ε** |
| `ALLOCEXPRESSION` | new |
| `ALLOCEXPRESSION'` | [, **ε** |
| `EXPRESSION` | +, -, int_constant, float_constant, string_constant, null, ident, ( |
| `EXPRESSION'` | <, >, <=, >=, ==, !=, **ε** |
| `NUMEXPRESSION` | +, -, int_constant, float_constant, string_constant, null, ident, ( |
| `NUMEXPR'` | +, -, **ε** |
| `TERM` | +, -, int_constant, float_constant, string_constant, null, ident, ( |
| `TERM'` | *, /, %, **ε** |
| `UNARYEXPR` | +, -, int_constant, float_constant, string_constant, null, ident, ( |
| `FACTOR` | int_constant, float_constant, string_constant, null, ident, ( |
| `LVALUE` | ident |
| `LVALUE'` | [, **ε** |

### FOLLOW

| Não-terminal | FOLLOW |
| --- | --- |
| `PROGRAM` | `$` |
| `FUNCLIST` | `$` |
| `FUNCLIST'` | `$` |
| `FUNCDEF` | def, `$` |
| `PARAMLIST` | ) |
| `PARAMLIST'` | ) |
| `TYPE` | ident, [ |
| `STATEMENT` | int, float, string, ident, print, read, return, if, for, {, break, ;, }, else, `$` |
| `VARDECL` | ; |
| `VARDECL'` | ; |
| `ATRIBSTAT` | ;, ) |
| `ATRIBSTAT_RHS` | ;, ) |
| `FUNCCALL` | ;, ) |
| `PARAMLISTCALL` | ) |
| `PARAMLISTCALL'` | ) |
| `PRINTSTAT` | ; |
| `READSTAT` | ; |
| `RETURNSTAT` | ; |
| `IFSTAT` | int, float, string, ident, print, read, return, if, for, {, break, ;, }, else, `$` |
| `IFSTAT'` | int, float, string, ident, print, read, return, if, for, {, break, ;, }, else, `$` |
| `FORSTAT` | int, float, string, ident, print, read, return, if, for, {, break, ;, }, else, `$` |
| `STATELIST` | } |
| `STATELIST'` | } |
| `ALLOCEXPRESSION` | ;, ) |
| `ALLOCEXPRESSION'` | ;, ) |
| `EXPRESSION` | ;, ) |
| `EXPRESSION'` | ;, ) |
| `NUMEXPRESSION` | <, >, <=, >=, ==, !=, ;, ), ] |
| `NUMEXPR'` | <, >, <=, >=, ==, !=, ;, ), ] |
| `TERM` | +, -, <, >, <=, >=, ==, !=, ;, ), ] |
| `TERM'` | +, -, <, >, <=, >=, ==, !=, ;, ), ] |
| `UNARYEXPR` | *, /, %, +, -, <, >, <=, >=, ==, !=, ;, ), ] |
| `FACTOR` | *, /, %, +, -, <, >, <=, >=, ==, !=, ;, ), ] |
| `LVALUE` | =, *, /, %, +, -, <, >, <=, >=, ==, !=, ;, ), ] |
| `LVALUE'` | =, *, /, %, +, -, <, >, <=, >=, ==, !=, ;, ), ] |

---

## 6. Prova de LL(1)

Uma gramática é LL(1) sse, para todo não-terminal `A` com alternativas
`α₁ | … | αₙ`:

1. **(FIRST disjuntos)** `FIRST(αᵢ) ∩ FIRST(αⱼ) = ∅` para todo `i ≠ j`; e
2. **(FIRST/FOLLOW)** se alguma `αᵢ` é anulável (`αᵢ ⇒* ε`), então
   `FIRST(αⱼ) ∩ FOLLOW(A) = ∅` para todo `j ≠ i` (e no máximo uma `αᵢ` é
   anulável).

Equivalentemente: ao construir a tabela preditiva, **nenhuma célula recebe duas
produções distintas**. A construção em `build_parse_table()` aplica exatamente
essa verificação e só aceita as duas resoluções documentadas abaixo; qualquer
outra colisão levanta `ConflitoLL1`. Como a tabela é construída sem erro (196
células, ver §7), a condição vale para todos os não-terminais. Pontos
representativos:

- **`STATEMENT`** — cada uma das 10 alternativas começa com um terminal/conjunto
  distinto: `VARDECL`={int,float,string}, `ATRIBSTAT`={ident},
  `PRINTSTAT`={print}, `READSTAT`={read}, `RETURNSTAT`={return},
  `IFSTAT`={if}, `FORSTAT`={for}, bloco `{ STATELIST }`={`{`},
  `break ;`={break}, `;`={;}. Interseção vazia; nenhuma é anulável.
- **`FACTOR`** — 6 alternativas com FIRST distintos
  (`int_constant`, `float_constant`, `string_constant`, `null`,
  `LVALUE`=`{ident}`, `(`). Disjuntos.
- **`EXPRESSION'`, `NUMEXPR'`, `TERM'`, `VARDECL'`, `LVALUE'`, `PARAMLIST'`,
  `PARAMLISTCALL'`, `ALLOCEXPRESSION'`, `STATELIST'`, `FUNCLIST'`** — auxiliares
  com uma parte não-vazia e uma `ε`. Em cada um, `FIRST(parte não-vazia)` é
  disjunto de `FOLLOW(aux)`. Por exemplo:
  - `NUMEXPR'`: FIRST não-ε = `{+, -}`; FOLLOW = `{<,>,<=,>=,==,!=,;,),]}` →
    disjuntos.
  - `TERM'`: FIRST não-ε = `{*, /, %}`; FOLLOW = `{+,-,<,>,<=,>=,==,!=,;,),]}` →
    disjuntos.
  - `LVALUE'`: FIRST não-ε = `{[}`; FOLLOW não contém `[` → disjuntos. (Um `[`
    após um `LVALUE` é sempre parte do próprio `LVALUE`, capturado pelo ramo
    não-ε, nunca pelo FOLLOW.)
- **`PROGRAM`** — `STATEMENT` (FIRST sem `def`), `FUNCLIST` (`{def}`) e `ε`
  (selecionada em FOLLOW = `{$}`). Disjuntos.

Restam **dois** conflitos, ambos resolvidos por decisão documentada.

### 6.1. Dangling-else

`IFSTAT' → else STATEMENT | ε`. Como `IFSTAT` é um `STATEMENT` e aparece em
`IFSTAT → if ( … ) STATEMENT IFSTAT'`, o `else` entra em `FOLLOW(IFSTAT')`. Logo,
em `[IFSTAT', else]` colidem o ramo FIRST (`else STATEMENT`) e o ramo ε.

**Resolução (spec/Assumptions):** o `else` casa com o `if` **mais próximo**.
A célula `[IFSTAT', else]` recebe `else STATEMENT` (prefere consumir o `else`);
o ramo ε permanece para os demais símbolos de `FOLLOW(IFSTAT')` (`}`, `;`, fim,
início de outro statement, etc.).

### 6.2. ATRIBSTAT / `ident`

`ATRIBSTAT_RHS → EXPRESSION | ALLOCEXPRESSION | FUNCCALL`. Aqui
`ident ∈ FIRST(EXPRESSION)` (via `FACTOR → LVALUE → ident`) e
`ident ∈ FIRST(FUNCCALL)` (`ident ( … )`). Logo `[ATRIBSTAT_RHS, ident]` colide
entre `EXPRESSION` e `FUNCCALL`. (`ALLOCEXPRESSION` começa com `new`, sem
conflito.)

**Resolução (spec/Assumptions):** decide-se pelo token **seguinte** ao `ident`:
se for `(` ⇒ `FUNCCALL`; caso contrário ⇒ `EXPRESSION`/`LVALUE`. Na tabela, a
célula `[ATRIBSTAT_RHS, ident]` registra `FUNCCALL` como produção documentada; o
parser preditivo (T9) refina com **1 token extra de lookahead**, escolhendo
`EXPRESSION` quando o token após o `ident` não é `(`. Tipos de RHS com início
distinto continuam sem conflito: `[ATRIBSTAT_RHS, new] → ALLOCEXPRESSION`,
`[ATRIBSTAT_RHS, (] → EXPRESSION`, etc.

> Estas são as **únicas** colisões. O teste
> `test_conflitos_resolvidos_sao_exatamente_os_dois_documentados` garante que
> nenhum outro conflito surja silenciosamente.

---

## 7. Tabela de reconhecimento LL(1)

Gerada **uma única vez** por `build_parse_table()` (memoizada: chamadas seguintes
devolvem o mesmo objeto, atendendo AS-01). Algoritmo: para cada produção
`A → α`, a célula `M[A, a]` recebe `α` para todo `a ∈ FIRST(α) \ {ε}`; e, se
`ε ∈ FIRST(α)`, para todo `a ∈ FOLLOW(A)`. Colisões são erro (`ConflitoLL1`),
exceto as duas resoluções documentadas (§6). Total: **196 células**.

Abaixo a tabela completa, agrupada por não-terminal (terminais com a mesma
produção foram agrupados por concisão). As duas células de resolução documentada
estão marcadas com ★.

```
PROGRAM
  [break, float, for, ident, if, int, {, print, read, return, ;, string] → STATEMENT
  [def]                                                                    → FUNCLIST
  [$]                                                                      → ε
FUNCLIST
  [def] → FUNCDEF FUNCLIST'
FUNCLIST'
  [def] → FUNCDEF FUNCLIST'
  [$]   → ε
FUNCDEF
  [def] → def ident ( PARAMLIST ) { STATELIST }
PARAMLIST
  [int, float, string] → TYPE ident PARAMLIST'
  [)]                  → ε
PARAMLIST'
  [,] → , PARAMLIST
  [)] → ε
TYPE
  [int] → int     [float] → float     [string] → string
STATEMENT
  [int, float, string] → VARDECL ;        [ident]  → ATRIBSTAT ;
  [print]              → PRINTSTAT ;       [read]   → READSTAT ;
  [return]             → RETURNSTAT ;      [if]     → IFSTAT
  [for]                → FORSTAT           [{]      → { STATELIST }
  [break]              → break ;           [;]      → ;
VARDECL
  [int, float, string] → TYPE ident VARDECL'
VARDECL'
  [[] → [ int_constant ] VARDECL'         [;] → ε
ATRIBSTAT
  [ident] → LVALUE = ATRIBSTAT_RHS
ATRIBSTAT_RHS
  [+, -, int_constant, float_constant, string_constant, null, (] → EXPRESSION
  [ident] → FUNCCALL                       ★ (ident '(' ⇒ FUNCCALL; senão EXPRESSION)
  [new]   → ALLOCEXPRESSION
FUNCCALL
  [ident] → ident ( PARAMLISTCALL )
PARAMLISTCALL
  [ident] → ident PARAMLISTCALL'           [)] → ε
PARAMLISTCALL'
  [,] → , PARAMLISTCALL                     [)] → ε
PRINTSTAT
  [print] → print EXPRESSION
READSTAT
  [read]  → read LVALUE
RETURNSTAT
  [return] → return
IFSTAT
  [if] → if ( EXPRESSION ) STATEMENT IFSTAT'
IFSTAT'
  [else] → else STATEMENT                   ★ (dangling-else: casa com o if mais próximo)
  [break, $, float, for, ident, if, int, {, print, }, read, return, ;, string] → ε
FORSTAT
  [for] → for ( ATRIBSTAT ; EXPRESSION ; ATRIBSTAT ) STATEMENT
STATELIST
  [break, float, for, ident, if, int, {, print, read, return, ;, string] → STATEMENT STATELIST'
STATELIST'
  [break, float, for, ident, if, int, {, print, read, return, ;, string] → STATEMENT STATELIST'
  [}] → ε
ALLOCEXPRESSION
  [new] → new TYPE [ NUMEXPRESSION ] ALLOCEXPRESSION'
ALLOCEXPRESSION'
  [[] → [ NUMEXPRESSION ] ALLOCEXPRESSION'  [), ;] → ε
EXPRESSION
  [+, -, int_constant, float_constant, string_constant, null, ident, (] → NUMEXPRESSION EXPRESSION'
EXPRESSION'
  [<] → < NUMEXPRESSION    [>]  → > NUMEXPRESSION    [<=] → <= NUMEXPRESSION
  [>=] → >= NUMEXPRESSION  [==] → == NUMEXPRESSION   [!=] → != NUMEXPRESSION
  [), ;] → ε
NUMEXPRESSION
  [+, -, int_constant, float_constant, string_constant, null, ident, (] → TERM NUMEXPR'
NUMEXPR'
  [+] → + TERM NUMEXPR'    [-] → - TERM NUMEXPR'
  [<, >, <=, >=, ==, !=, ], ), ;] → ε
TERM
  [+, -, int_constant, float_constant, string_constant, null, ident, (] → UNARYEXPR TERM'
TERM'
  [*] → * UNARYEXPR TERM'  [/] → / UNARYEXPR TERM'   [%] → % UNARYEXPR TERM'
  [+, -, <, >, <=, >=, ==, !=, ], ), ;] → ε
UNARYEXPR
  [+] → + FACTOR           [-] → - FACTOR
  [int_constant, float_constant, string_constant, null, ident, (] → FACTOR
FACTOR
  [int_constant]   → int_constant      [float_constant] → float_constant
  [string_constant]→ string_constant   [null]           → null
  [ident]          → LVALUE            [(]              → ( NUMEXPRESSION )
LVALUE
  [ident] → ident LVALUE'
LVALUE'
  [[] → [ NUMEXPRESSION ] LVALUE'
  [=, *, /, %, +, -, <, >, <=, >=, ==, !=, ], ), ;] → ε
```

---

## 8. Coerência com o código

- As produções acima são exatamente `PRODUCOES` em `src/grammar.py`.
- `first(simbolo)` / `follow(nt)` produzem as tabelas da §5.
- `build_parse_table()` produz a tabela da §7 (memoizada) e expõe as resoluções
  via `conflitos_resolvidos()` e `RESOLUCOES_DOCUMENTADAS`.
