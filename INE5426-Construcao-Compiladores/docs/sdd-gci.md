# SDD L-atribuída e SDT de geração de código intermediário (GCI) — ConvCC-2026-1

Este documento atende **DOC-02** (parte GCI): a **SDD L-atribuída** e o **esquema
de tradução (SDT)** que geram **código de três endereços (TAC)** para os comandos
de ConvCC-2026-1, conforme GCI-01/GCI-02. É coerente com a implementação em
[`src/codegen.py`](../src/codegen.py): a classe `CodeGen` realiza, por construção,
exatamente as regras abaixo.

## 0. Convenções

- `novotemp()` devolve um temporário fresco `t1, t2, …`; `novorotulo()` um rótulo
  fresco `L1, L2, …` (numeração determinística — `CodeGen.novo_temp` /
  `novo_rotulo`).
- `emit(instr)` anexa uma instrução à lista de código (`CodeGen.emit`).
- **Atributo sintetizado `lugar`**: para os não-terminais de expressão, é o
  "endereço" do resultado — um temporário `tN`, um nome de variável ou uma
  constante. Operações com efeito (atribuição, saltos) usam `emit`.
- **Atributo herdado `h`** (acumulador) nos auxiliares `NUMEXPR'`, `TERM'`,
  `EXPRESSION'`: o `lugar` da subexpressão já gerada à esquerda — mesma técnica da
  SDD de EXPA ([`docs/sdd-semantica.md`](sdd-semantica.md)), aqui **emitindo
  código** além de devolver o `lugar`.
- A SDD é **L-atribuída** (mesmo critério da §0 de `sdd-semantica.md`); logo é
  avaliável numa **única passada** esquerda-para-direita — a travessia de
  `codegen.py`. O formato textual segue o estilo das aulas (AD-004).

Formato das instruções (estilo das aulas):

```
t1 = c * d            (atribuição de três endereços; binária)
t2 = b + t1
a  = t2
t1 = -b               (unária)
t1 = v[i]             (leitura de array)        v[i] = t2   (escrita)
t1 = new int[10]      (alocação)
ifFalse x goto L1     (salto condicional)       goto L2     (salto incondicional)
L1:                   (rótulo)
func f:               (entrada de função)       return
param x               (passagem de argumento)   t1 = call f, 2   (chamada)
print x               read x
```

---

## 1. Expressões (GCI-02: temporários + precedência/associatividade)

Mesma estrutura de árvore da EXPA, mas cada nó **emite** o TAC e devolve o
`lugar`. O acumulador herdado `h` realiza a associatividade à esquerda;
`* / %` (em `TERM'`) ligam mais forte que `+ -` (em `NUMEXPR'`); o relacional
(`EXPRESSION'`) fica no topo.

| Produção | Regras semânticas |
| --- | --- |
| `EXPRESSION → NUMEXPRESSION EXPRESSION'` | `EXPRESSION'.h = NUMEXPRESSION.lugar`; `EXPRESSION.lugar = EXPRESSION'.lugar` |
| `EXPRESSION' → RELOP NUMEXPRESSION` | `t = novotemp(); emit(t '=' EXPRESSION'.h RELOP.lexema NUMEXPRESSION.lugar); EXPRESSION'.lugar = t` |
| `EXPRESSION' → ε` | `EXPRESSION'.lugar = EXPRESSION'.h` |
| `NUMEXPRESSION → TERM NUMEXPR'` | `NUMEXPR'.h = TERM.lugar`; `NUMEXPRESSION.lugar = NUMEXPR'.lugar` |
| `NUMEXPR' → + TERM NUMEXPR'₁` | `t = novotemp(); emit(t '=' NUMEXPR'.h '+' TERM.lugar); NUMEXPR'₁.h = t; NUMEXPR'.lugar = NUMEXPR'₁.lugar` |
| `NUMEXPR' → - TERM NUMEXPR'₁` | análogo com `-` |
| `NUMEXPR' → ε` | `NUMEXPR'.lugar = NUMEXPR'.h` |
| `TERM → UNARYEXPR TERM'` | `TERM'.h = UNARYEXPR.lugar`; `TERM.lugar = TERM'.lugar` |
| `TERM' → * UNARYEXPR TERM'₁` | `t = novotemp(); emit(t '=' TERM'.h '*' UNARYEXPR.lugar); TERM'₁.h = t; TERM'.lugar = TERM'₁.lugar` |
| `TERM' → / UNARYEXPR TERM'₁` | análogo com `/` |
| `TERM' → % UNARYEXPR TERM'₁` | análogo com `%` |
| `TERM' → ε` | `TERM'.lugar = TERM'.h` |
| `UNARYEXPR → + FACTOR` | `UNARYEXPR.lugar = FACTOR.lugar` (sinal `+` é identidade) |
| `UNARYEXPR → - FACTOR` | `t = novotemp(); emit(t '= -' FACTOR.lugar); UNARYEXPR.lugar = t` |
| `UNARYEXPR → FACTOR` | `UNARYEXPR.lugar = FACTOR.lugar` |
| `FACTOR → int_constant \| float_constant \| string_constant \| null` | `FACTOR.lugar = lexema` (a própria constante) |
| `FACTOR → LVALUE` | `FACTOR.lugar = LVALUE.lugar` (carga — §3) |
| `FACTOR → ( NUMEXPRESSION )` | `FACTOR.lugar = NUMEXPRESSION.lugar` |

> Observação: em `codegen.py`, `_gen_unaryexpr` emite `t = +x` / `t = -x` quando há
> sinal explícito; o resultado e a ordem dos temporários são determinísticos. O
> efeito sobre a precedência/associatividade é idêntico ao da tabela acima.

**Exemplo (GCI-02).** `a = b + c * d;` →

```
t1 = c * d
t2 = b + t1
a  = t2
```

(`TERM'` gera `t1 = c * d` antes de `NUMEXPR'` combinar com `b`.)

**Prova (L-atribuída).** Os herdados de RHS (`EXPRESSION'.h`, `NUMEXPR'₁.h`,
`TERM'₁.h`) dependem só de irmãos à esquerda (`NUMEXPRESSION.lugar`, `TERM.lugar`,
`UNARYEXPR.lugar`) e do herdado do pai (`NUMEXPR'.h`, `TERM'.h`) — exatamente como
na §1.3 de `sdd-semantica.md`. ∎

---

## 2. Comandos

### 2.1. Atribuição, `print`, `read`, `return`

| Produção | Regras semânticas |
| --- | --- |
| `ATRIBSTAT → LVALUE = ATRIBSTAT_RHS` | `lugar = ATRIBSTAT_RHS.lugar`; `alvo = LVALUE.alvo` (§3); `emit(alvo '=' lugar)` |
| `ATRIBSTAT_RHS → EXPRESSION` | `ATRIBSTAT_RHS.lugar = EXPRESSION.lugar` |
| `ATRIBSTAT_RHS → ALLOCEXPRESSION` | `ATRIBSTAT_RHS.lugar = ALLOCEXPRESSION.lugar` (§4) |
| `ATRIBSTAT_RHS → FUNCCALL` | `ATRIBSTAT_RHS.lugar = FUNCCALL.lugar` (§5) |
| `PRINTSTAT → print EXPRESSION` | `emit('print' EXPRESSION.lugar)` |
| `READSTAT → read LVALUE` | `emit('read' LVALUE.alvo)` |
| `RETURNSTAT → return` | `emit('return')` |

(`RETURNSTAT` não tem expressão na gramática de ConvCC-2026-1; emite-se apenas
`return`.)

### 2.2. `if` / `else` (rótulos e saltos)

Atributos herdados sintetizados localmente: rótulos novos `L_else`, `L_fim`.

| Produção | Regras semânticas |
| --- | --- |
| `IFSTAT → if ( EXPRESSION ) STATEMENT IFSTAT'` com `IFSTAT' → ε` | `c = EXPRESSION.lugar; Lf = novorotulo(); emit('ifFalse' c 'goto' Lf);` gerar `STATEMENT`; `emit(Lf ':')` |
| `IFSTAT → if ( EXPRESSION ) STATEMENT₁ else STATEMENT₂` | `c = EXPRESSION.lugar; Le = novorotulo(); Lf = novorotulo(); emit('ifFalse' c 'goto' Le);` gerar `STATEMENT₁`; `emit('goto' Lf); emit(Le ':');` gerar `STATEMENT₂`; `emit(Lf ':')` |

### 2.3. `for` e `break`

Atributo herdado de ambiente: a **pilha de rótulos de saída** dos `for` abertos
(`CodeGen._fim_for`), usada por `break`.

```
FORSTAT → for ( ATRIBSTAT_init ; EXPRESSION ; ATRIBSTAT_incr ) STATEMENT
```
Regras:

```
gerar ATRIBSTAT_init
Linicio = novorotulo();  Lfim = novorotulo()
emit(Linicio ':')
c = EXPRESSION.lugar
emit('ifFalse' c 'goto' Lfim)
empilhar Lfim em _fim_for          // alvo de break no corpo
gerar STATEMENT                    // corpo
desempilhar _fim_for
gerar ATRIBSTAT_incr
emit('goto' Linicio)
emit(Lfim ':')
```

```
STATEMENT → break ;   ⇒   emit('goto' topo(_fim_for))
```

A pré-condição "`break` só dentro de `for`" é garantida pela análise semântica
(ASEM-05) antes da geração; logo `_fim_for` nunca está vazio ao emitir o `break`.

### 2.4. Funções: `def`, chamada

```
FUNCDEF → def ident ( PARAMLIST ) { STATELIST }
```
```
emit('func' ident.lexema ':')
gerar STATELIST
```

```
FUNCCALL → ident ( PARAMLISTCALL )
```
Atributo sintetizado `args` de `PARAMLISTCALL` (lista dos nomes — só `ident`s,
pela gramática). Regras:

```
para cada a em PARAMLISTCALL.args:  emit('param' a)
t = novotemp()
emit(t '= call' ident.lexema ',' tamanho(args))
FUNCCALL.lugar = t
```

`PARAMLISTCALL → ident PARAMLISTCALL' | ε` sintetiza `args` por concatenação à
esquerda (`_args` em `codegen.py`). As declarações (`VARDECL`) **não emitem
código** (`_gen` retorna sem emitir para `VARDECL`).

**Exemplo.** `r = soma(a, b);` →

```
param a
param b
t1 = call soma, 2
r  = t1
```

---

## 3. `LVALUE`: carga (leitura) e alvo (escrita)

`LVALUE → ident LVALUE'`, com `LVALUE' → ( [ NUMEXPRESSION ] )*` produzindo a
lista de índices (cada `NUMEXPRESSION.lugar`).

**Carga** (`LVALUE` usado como operando, `_lvalue_carga`):

```
lugar = ident.lexema
para cada idx em índices:  t = novotemp(); emit(t '=' lugar '[' idx ']'); lugar = t
LVALUE.lugar = lugar
```

**Alvo** (`LVALUE` à esquerda de `=`, `_lvalue_alvo`): sem índices ⇒ o próprio
nome; com índices, os anteriores ao último viram cargas e o último é a escrita:

```
se sem índices:  LVALUE.alvo = ident.lexema
senão:           lugar = ident.lexema
                 para idx em índices[:-1]: t = novotemp(); emit(t '=' lugar '[' idx ']'); lugar = t
                 LVALUE.alvo = lugar '[' índices[-1] ']'
```

**Exemplo (matriz).** `g[i][j] = x;` →

```
t1 = g[i]
t1[j] = x
```

(`g[i]` é carga; `[j]` é a escrita.)

---

## 4. Alocação dinâmica (`new`)

```
ALLOCEXPRESSION → new TYPE [ NUMEXPRESSION ] ALLOCEXPRESSION'
```
com `ALLOCEXPRESSION' → ( [ NUMEXPRESSION ] )*` sintetizando as demais dimensões.

```
dims = [ NUMEXPRESSION.lugar ] ++ ALLOCEXPRESSION'.dims     // cada lugar gerado
t = novotemp()
emit(t '= new' TYPE.lexema concat("[" d "]" para d em dims))
ALLOCEXPRESSION.lugar = t
```

**Exemplo.** `p = new int[10];` → `t1 = new int[10]` seguido de `p = t1`.

---

## 5. Coerência com o código

- `CodeGen._gen_expression` / `_gen_numexpression` / `_gen_term` /
  `_gen_unaryexpr` / `_gen_factor` realizam a §1 (laços `while` = recursão à
  direita dos auxiliares com o acumulador `h`; temporários determinísticos).
- `_gen_atribstat`, `_gen_printstat`, `_gen_readstat`, `RETURNSTAT` (no `_gen`),
  `_gen_ifstat`, `_gen_forstat` realizam a §2; `break` usa `_fim_for`.
- `_gen_funcdef`, `_gen_funccall` e `_args` realizam a §2.4 / §5.
- `_lvalue_carga`, `_lvalue_alvo`, `_indices` realizam a §3; `_gen_allocexpression`
  realiza a §4.
- A lista de saída de `gerar(arvore)` é impressa como bloco **(f)** das saídas de
  sucesso em [`main.py`](../main.py) (OUT-01).
