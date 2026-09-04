# SDDs L-atribuídas e SDTs da análise semântica — ConvCC-2026-1

Este documento atende **DOC-02** (parte ASem): apresenta, **separadamente para
EXPA e DEC**, a **definição dirigida pela sintaxe (SDD) L-atribuída**, a **prova
de que cada SDD é L-atribuída** e o **esquema de tradução dirigido pela sintaxe
(SDT)** correspondente. Tudo aqui é coerente com a implementação em
[`src/semantic.py`](../src/semantic.py): as travessias recursivas daquele módulo
são a realização direta das SDDs/SDTs abaixo.

> **EXPA** = produções de expressão aritmética (`EXPRESSION`, `NUMEXPRESSION`,
> `TERM`, `UNARYEXPR`, `FACTOR`, `LVALUE` e seus auxiliares). Cobre a **árvore de
> expressão T** (ASEM-01) e a **verificação de tipos** (ASEM-03).
>
> **DEC** = produções de declaração (`VARDECL`, `PARAMLIST`, `TYPE` e auxiliares).
> Cobre a **inserção de tipo na tabela de símbolos** (ASEM-02).
>
> As travessias de **escopo** (ASEM-04) e **`break`** (ASEM-05) — também
> L-atribuídas — estão no Apêndice A, para coerência completa com `semantic.py`.

## 0. Convenções

- **Atributo sintetizado** de `X`: escrito `X.attr`; calculado a partir dos
  atributos dos **filhos** (e da própria folha). É computado quando a subárvore de
  `X` já foi visitada.
- **Atributo herdado** de `X`: também `X.attr`; calculado a partir de atributos do
  **pai** e dos **irmãos à esquerda**.
- Uma SDD é **L-atribuída** quando, em toda produção `A → X₁ X₂ … Xₙ`, todo
  atributo **herdado** de `Xᵢ` depende apenas de (i) atributos **herdados de
  `A`** e (ii) atributos de `X₁ … Xᵢ₋₁` (símbolos **à esquerda** de `Xᵢ`); os
  sintetizados podem depender de qualquer filho. Toda SDD L-atribuída admite
  avaliação numa **única passada em profundidade, da esquerda para a direita** —
  exatamente a travessia recursiva de `semantic.py`.
- `no(op, esq, dir)` constrói um nó da árvore de expressão T
  ([`ExprNode`](../src/ast_nodes.py)); `folha(v, tipo)` constrói um operando.
- A gramática usada é a já transformada para LL(1) em
  [`src/grammar.py`](../src/grammar.py); ver [`docs/gramatica.md`](gramatica.md).

---

## 1. EXPA — árvore de expressão T (ASEM-01)

### 1.1. Produções relevantes

```
EXPRESSION    → NUMEXPRESSION EXPRESSION'
EXPRESSION'   → RELOP NUMEXPRESSION | ε          (RELOP ∈ { < > <= >= == != })
NUMEXPRESSION → TERM NUMEXPR'
NUMEXPR'      → + TERM NUMEXPR' | - TERM NUMEXPR' | ε
TERM          → UNARYEXPR TERM'
TERM'         → * UNARYEXPR TERM' | / UNARYEXPR TERM' | % UNARYEXPR TERM' | ε
UNARYEXPR     → + FACTOR | - FACTOR | FACTOR
FACTOR        → int_constant | float_constant | string_constant | null
              | LVALUE | ( NUMEXPRESSION )
LVALUE        → ident LVALUE'
```

A transformação LL(1) trocou a recursão à esquerda (`E → E + T`) por recursão à
direita com auxiliares `NUMEXPR'`, `TERM'`, `EXPRESSION'`. Para reconstruir a
**associatividade à esquerda** e a **precedência** (`* / %` antes de `+ -`;
relacional no topo) usamos um **atributo herdado acumulador** `h` nos auxiliares.

### 1.2. SDD L-atribuída (construção da árvore)

Atributos: `no` (sintetizado: a subárvore T construída) em `EXPRESSION`,
`NUMEXPRESSION`, `TERM`, `UNARYEXPR`, `FACTOR`, `LVALUE` e nos auxiliares; `h`
(herdado: a subárvore acumulada à esquerda) nos auxiliares `EXPRESSION'`,
`NUMEXPR'`, `TERM'`.

| Produção | Regras semânticas |
| --- | --- |
| `EXPRESSION → NUMEXPRESSION EXPRESSION'` | `EXPRESSION'.h = NUMEXPRESSION.no`; `EXPRESSION.no = EXPRESSION'.no` |
| `EXPRESSION' → RELOP NUMEXPRESSION` | `EXPRESSION'.no = no(RELOP.lexema, EXPRESSION'.h, NUMEXPRESSION.no)` |
| `EXPRESSION' → ε` | `EXPRESSION'.no = EXPRESSION'.h` |
| `NUMEXPRESSION → TERM NUMEXPR'` | `NUMEXPR'.h = TERM.no`; `NUMEXPRESSION.no = NUMEXPR'.no` |
| `NUMEXPR' → + TERM NUMEXPR'₁` | `NUMEXPR'₁.h = no('+', NUMEXPR'.h, TERM.no)`; `NUMEXPR'.no = NUMEXPR'₁.no` |
| `NUMEXPR' → - TERM NUMEXPR'₁` | `NUMEXPR'₁.h = no('-', NUMEXPR'.h, TERM.no)`; `NUMEXPR'.no = NUMEXPR'₁.no` |
| `NUMEXPR' → ε` | `NUMEXPR'.no = NUMEXPR'.h` |
| `TERM → UNARYEXPR TERM'` | `TERM'.h = UNARYEXPR.no`; `TERM.no = TERM'.no` |
| `TERM' → * UNARYEXPR TERM'₁` | `TERM'₁.h = no('*', TERM'.h, UNARYEXPR.no)`; `TERM'.no = TERM'₁.no` |
| `TERM' → / UNARYEXPR TERM'₁` | `TERM'₁.h = no('/', TERM'.h, UNARYEXPR.no)`; `TERM'.no = TERM'₁.no` |
| `TERM' → % UNARYEXPR TERM'₁` | `TERM'₁.h = no('%', TERM'.h, UNARYEXPR.no)`; `TERM'.no = TERM'₁.no` |
| `TERM' → ε` | `TERM'.no = TERM'.h` |
| `UNARYEXPR → + FACTOR` | `UNARYEXPR.no = no('+', null, FACTOR.no)` (unário: operando em `dir`) |
| `UNARYEXPR → - FACTOR` | `UNARYEXPR.no = no('-', null, FACTOR.no)` |
| `UNARYEXPR → FACTOR` | `UNARYEXPR.no = FACTOR.no` |
| `FACTOR → int_constant` | `FACTOR.no = folha(lexema, tipo='int')` |
| `FACTOR → float_constant` | `FACTOR.no = folha(lexema, tipo='float')` |
| `FACTOR → string_constant` | `FACTOR.no = folha(lexema, tipo='string')` |
| `FACTOR → null` | `FACTOR.no = folha('null', tipo=⊥)` |
| `FACTOR → LVALUE` | `FACTOR.no = LVALUE.no` |
| `FACTOR → ( NUMEXPRESSION )` | `FACTOR.no = NUMEXPRESSION.no` (parênteses só reagrupam) |
| `LVALUE → ident LVALUE'` | `LVALUE.no = folha(ident.lexema)` (operando folha; o tipo é resolvido na §1.5) |

A cadeia `EXPRESSION → NUMEXPRESSION → TERM → UNARYEXPR → FACTOR` fixa a
**precedência**: `TERM'` (`* / %`) dobra antes de `NUMEXPR'` (`+ -`), e o
relacional de `EXPRESSION'` fica no topo. O acumulador `h` garante a
**associatividade à esquerda**: cada `+`/`*` recebe à esquerda a árvore já
construída (`h`) e à direita o novo operando.

### 1.3. Prova de que a SDD de EXPA é L-atribuída

Basta verificar, em cada produção, que todo atributo **herdado** do lado direito
só usa atributos **herdados do pai** ou de **irmãos à esquerda**:

- `EXPRESSION → NUMEXPRESSION EXPRESSION'`: o único herdado do RHS é
  `EXPRESSION'.h = NUMEXPRESSION.no`; `NUMEXPRESSION` está **à esquerda** de
  `EXPRESSION'`. ✔
- `NUMEXPRESSION → TERM NUMEXPR'`: `NUMEXPR'.h = TERM.no`; `TERM` à esquerda. ✔
- `NUMEXPR' → (+|-) TERM NUMEXPR'₁`: `NUMEXPR'₁.h = no(NUMEXPR'.h, TERM.no)`,
  usando `NUMEXPR'.h` (**herdado do pai**) e `TERM.no` (**irmão à esquerda** de
  `NUMEXPR'₁`). ✔
- `TERM → UNARYEXPR TERM'` e `TERM' → (*|/|%) UNARYEXPR TERM'₁`: idêntico ao caso
  de `NUMEXPR'` (`TERM'.h` herdado do pai, `UNARYEXPR.no` irmão à esquerda). ✔
- `EXPRESSION' → RELOP NUMEXPRESSION` e as regras `→ ε`: não atribuem nenhum
  **herdado** a símbolos do RHS (só calculam o sintetizado `.no`). ✔
- Demais produções (`UNARYEXPR`, `FACTOR`, `LVALUE`): só calculam atributos
  **sintetizados**. ✔

Nenhum atributo herdado depende de símbolo **à direita** nem de atributo
**sintetizado do pai**. Logo a SDD é L-atribuída. ∎

### 1.4. SDT de EXPA (esquema de tradução)

Ações herdadas são colocadas **imediatamente antes** do símbolo a que servem;
ações sintetizadas, **ao final** da produção. (Convenção de SDT para SDD
L-atribuída — Aho et al.)

```
EXPRESSION    → NUMEXPRESSION { EXPRESSION'.h = NUMEXPRESSION.no } EXPRESSION'
                { EXPRESSION.no = EXPRESSION'.no }

EXPRESSION'   → RELOP NUMEXPRESSION
                { EXPRESSION'.no = no(RELOP.lexema, EXPRESSION'.h, NUMEXPRESSION.no) }
EXPRESSION'   → ε   { EXPRESSION'.no = EXPRESSION'.h }

NUMEXPRESSION → TERM { NUMEXPR'.h = TERM.no } NUMEXPR'
                { NUMEXPRESSION.no = NUMEXPR'.no }

NUMEXPR'      → + TERM { NUMEXPR'₁.h = no('+', NUMEXPR'.h, TERM.no) } NUMEXPR'₁
                { NUMEXPR'.no = NUMEXPR'₁.no }
NUMEXPR'      → - TERM { NUMEXPR'₁.h = no('-', NUMEXPR'.h, TERM.no) } NUMEXPR'₁
                { NUMEXPR'.no = NUMEXPR'₁.no }
NUMEXPR'      → ε   { NUMEXPR'.no = NUMEXPR'.h }

TERM          → UNARYEXPR { TERM'.h = UNARYEXPR.no } TERM'
                { TERM.no = TERM'.no }
TERM'         → * UNARYEXPR { TERM'₁.h = no('*', TERM'.h, UNARYEXPR.no) } TERM'₁
                { TERM'.no = TERM'₁.no }
   (idem para / e %)
TERM'         → ε   { TERM'.no = TERM'.h }

UNARYEXPR     → + FACTOR { UNARYEXPR.no = no('+', null, FACTOR.no) }
              | - FACTOR { UNARYEXPR.no = no('-', null, FACTOR.no) }
              | FACTOR   { UNARYEXPR.no = FACTOR.no }

FACTOR        → int_constant    { FACTOR.no = folha(lexema, 'int') }
              | float_constant  { FACTOR.no = folha(lexema, 'float') }
              | string_constant { FACTOR.no = folha(lexema, 'string') }
              | null            { FACTOR.no = folha('null') }
              | LVALUE          { FACTOR.no = LVALUE.no }
              | ( NUMEXPRESSION ) { FACTOR.no = NUMEXPRESSION.no }

LVALUE        → ident LVALUE' { LVALUE.no = folha(ident.lexema) }
```

**Correspondência com o código.** A recursão à direita de `NUMEXPR'`/`TERM'` com
o acumulador `h` é implementada de forma **iterativa** por um laço `while` em
`SemanticAnalyzer._expr_de_numexpression` / `_expr_de_term`
([`src/semantic.py`](../src/semantic.py)): a cada volta do laço, `esq` (o `h`
acumulado) é combinado com o próximo operando, reproduzindo exatamente a árvore
da SDD. `_expr_de_expression` aplica o relacional no topo; `_expr_de_unaryexpr`,
`_expr_de_factor` e `_expr_de_lvalue` realizam as folhas. A varredura
**raiz-esquerda-direita** exigida por OUT-01(a) é `ExprNode.pre_ordem()`.

### 1.5. EXPA — verificação de tipos (ASEM-03)

Sobre a árvore T já construída, uma segunda travessia atribui o **tipo**
(sintetizado). Como percorre T (não a árvore de derivação), é uma SDD
**S-atribuída** — caso particular de L-atribuída.

| Nó de T | Regra semântica |
| --- | --- |
| folha constante | `tipo` = tipo do literal (`int`/`float`/`string`) |
| folha `ident` | `tipo` = `tabela.tipo(ident)`; se ausente ⇒ **erro semântico** na posição do operando |
| unário `op` | `tipo` = `dir.tipo` |
| binário `op` | se `esq.tipo = dir.tipo` então `tipo = esq.tipo`; senão ⇒ **erro semântico** na posição do operador |

**Decisão (segue a spec ao pé da letra).** "Todos os operandos com o mesmo tipo"
⇒ não há promoção implícita: `int + float` é erro. Implementado em
`SemanticAnalyzer._tipo_no`. L-atribuída trivialmente: `op.tipo` depende só dos
filhos (sintetizado). ∎

---

## 2. DEC — inserção de tipo na tabela de símbolos (ASEM-02)

### 2.1. Produções relevantes

```
VARDECL    → TYPE ident VARDECL'
VARDECL'   → [ int_constant ] VARDECL' | ε
TYPE       → int | float | string
PARAMLIST  → TYPE ident PARAMLIST' | ε
PARAMLIST' → , PARAMLIST | ε
```

### 2.2. SDD L-atribuída (inserção de tipo)

Atributos: `t` (sintetizado em `TYPE`: o tipo escolhido); `dims` (sintetizado em
`VARDECL'`: a lista de dimensões de array); a inserção é uma **ação com efeito
colateral** sobre a tabela de símbolos do escopo corrente.

| Produção | Regras semânticas |
| --- | --- |
| `TYPE → int` | `TYPE.t = 'int'` |
| `TYPE → float` | `TYPE.t = 'float'` |
| `TYPE → string` | `TYPE.t = 'string'` |
| `VARDECL' → [ int_constant ] VARDECL'₁` | `VARDECL'.dims = [int_constant.valor] ++ VARDECL'₁.dims` |
| `VARDECL' → ε` | `VARDECL'.dims = [ ]` |
| `VARDECL → TYPE ident VARDECL'` | `inserir(escopo_atual, ident.lexema, tipo = TYPE.t, dims = VARDECL'.dims)` |
| `PARAMLIST → TYPE ident PARAMLIST'` | `inserir(escopo_atual, ident.lexema, tipo = TYPE.t)` |
| `PARAMLIST → ε` | — |
| `PARAMLIST' → , PARAMLIST` \| `ε` | — (recursão; cada `PARAMLIST` insere o seu próprio parâmetro) |

O **tipo de `TYPE`** é o atributo que **flui** para o `ident` declarado: na forma
canônica da DEC do X++, `TYPE.t` é um atributo **herdado** por uma lista de
identificadores; aqui cada `VARDECL`/`PARAMLIST` declara **um** `ident`, então
`TYPE.t` (irmão à esquerda) é consumido diretamente pela ação de inserção.

**Escopo (atributo herdado de ambiente).** O escopo corrente é uma pilha
manipulada como efeito L-atribuído: empilha-se um escopo **ao entrar** em
`FUNCDEF` (parâmetros + corpo), em bloco `{ STATELIST }`, em `for` e em `if`, e
desempilha-se **ao sair**. Assim, declarações iguais em escopos aninhados
distintos não se misturam (uma sombra interna não altera o tipo externo).

### 2.3. Prova de que a SDD de DEC é L-atribuída

- `TYPE → int|float|string`: só calcula o **sintetizado** `TYPE.t`. ✔
- `VARDECL' → [ int_constant ] VARDECL'₁`: só calcula o **sintetizado**
  `VARDECL'.dims` a partir do filho `VARDECL'₁` (sintetizado). ✔
- `VARDECL → TYPE ident VARDECL'`: a ação de inserção, posta **ao final** da
  produção, usa `TYPE.t`, `ident.lexema` e `VARDECL'.dims` — todos **à esquerda**
  do ponto da ação (todos já avaliados). Não há atributo herdado de RHS dependente
  de símbolo à direita. ✔
- `PARAMLIST → TYPE ident PARAMLIST'`: a inserção usa `TYPE.t` e `ident`
  (à esquerda); `PARAMLIST'` apenas continua a recursão. ✔
- O atributo de **escopo** é empilhado antes de visitar os filhos do construto e
  desempilhado depois — dependência apenas do "ambiente herdado" do pai. ✔

Logo a SDD de DEC é L-atribuída. ∎

### 2.4. SDT de DEC

```
TYPE     → int    { TYPE.t = 'int' }
         | float  { TYPE.t = 'float' }
         | string { TYPE.t = 'string' }

VARDECL' → [ int_constant ] VARDECL'₁
           { VARDECL'.dims = [int_constant.valor] ++ VARDECL'₁.dims }
VARDECL' → ε   { VARDECL'.dims = [ ] }

VARDECL  → TYPE ident VARDECL'
           { inserir(escopo_atual, ident.lexema, TYPE.t, VARDECL'.dims) }

PARAMLIST → TYPE ident { inserir(escopo_atual, ident.lexema, TYPE.t) } PARAMLIST'
          | ε
```

**Correspondência com o código.** `SemanticAnalyzer.inserir_tipos` /
`_tipos_walk` realizam esta SDT: `_tipo_de_type` é `TYPE.t`; `_dimensoes` é
`VARDECL'.dims`; `tabela.declarar(...)` é a ação `inserir`. O push/pop de escopo
em `FUNCDEF`/bloco/`for`/`if` é o atributo de ambiente
([`src/symbol_table.py`](../src/symbol_table.py) implementa a pilha de escopos
que compartilha o objeto `Symbol` com a tabela léxica global de AL-02).

---

## Apêndice A — escopo (ASEM-04) e `break` (ASEM-05)

Ambas as travessias de `semantic.py` também são L-atribuídas (atributos de
ambiente herdados, propagados da raiz para as folhas, com sintetizados apenas
para sinalizar erro).

### A.1. Verificação de escopo (`verificar_escopos`)

Atributo herdado: a **pilha de escopos** (ambiente). Regras (efeitos):

- `FUNCDEF → def ident ( PARAMLIST ) { STATELIST }`: `declarar(ident)` no escopo
  atual (colisão ⇒ erro); **empilha** escopo; declara os parâmetros; visita
  `STATELIST`; **desempilha**.
- `VARDECL → TYPE ident VARDECL'`: `declarar(ident)` no escopo atual
  (redeclaração no mesmo escopo ⇒ erro).
- `LVALUE → ident LVALUE'` e `FUNCCALL → ident ( PARAMLISTCALL )` e cada `ident`
  de `PARAMLISTCALL`: **uso** — se `resolver(ident)` falhar em toda a pilha ⇒
  erro de "não declarado".
- bloco `{ STATELIST }`, `for`, `if`: **empilham/desempilham** escopo em torno
  dos filhos (permitindo sombreamento em aninhamento).

L-atribuída: o ambiente é herdado do pai e estendido à esquerda (declaração antes
do uso, na ordem textual da passada única). ∎

### A.2. Verificação de `break` (`verificar_break`)

Atributo herdado `fores` (nº de `for` que envolvem o nó): começa em 0; cada
`FORSTAT` o incrementa para a sua subárvore. Regra: ao visitar `BREAK`, se
`fores = 0` ⇒ erro "break fora de for". Como `fores` é herdado do pai (nunca de
irmãos à direita nem de sintetizado do pai), a SDD é L-atribuída. ∎
