# Diagramas de transição do analisador léxico — ConvCC-2026-1

Documenta o autômato finito determinístico (DFA) implementado **char-a-char** em
`src/lexer.py` (AD-003). Não há gerador léxico. A linguagem **não tem
comentários**: `/` é apenas o operador de divisão.

Convenções:
- `L` = letra (`a..z A..Z`) ou `_`; `D` = dígito (`0..9`); `alnum` = `L | D`.
- Posições são 1-based; a coluna de um token é a do seu **primeiro** caractere.
  O caractere `\n` incrementa a linha e zera a coluna (`coluna = 1`).
- Estados de aceitação entre colchetes, ex.: `[IDENT]`. Transições de erro
  levantam `LexicalError(linha, coluna, mensagem)`.

## Laço principal (`proximo_token`)

```
INICIO
  | espaço/\t/\r/\n  -> consome e permanece em INICIO   (_pular_espacos)
  | fim da fonte     -> [EOF]
  | L                -> IDENT_KW
  | D                -> NUMERO
  | "                -> CADEIA
  | < > = !          -> OPERADOR_COMPOSTO
  | ( ) { } [ ] ; ,  -> [símbolo de 1 caractere]
  | + - * / %        -> [operador simples]
  | outro            -> ERRO "caractere inválido: '<c>'"
```

## 1. Identificador / palavra-chave (`_ler_identificador`)

```
INICIO --L--> S1
S1 --alnum--> S1            (maximal munch)
S1 --(outro)--> [IDENT_KW]
```

No estado de aceitação, o lexema é classificado por busca na tabela
`PALAVRAS_CHAVE` (`def, int, float, string, print, read, return, if, else, for,
break, new, null`). Se não for palavra-chave, o token é `IDENT` e a ocorrência
`(linha, coluna)` é registrada na tabela de símbolos via
`registrar_ocorrencia` (AL-02).

## 2. Constantes numéricas int/float (`_ler_numero`)

```
INICIO --D--> INT
INT --D--> INT
INT --(outro, != '.')--> [INT_CONST]
INT --'.'--> PONTO
PONTO --D--> FRAC
PONTO --(não-D)--> ERRO "número malformado"      (ex.: 12.)
FRAC --D--> FRAC
FRAC --'.'--> ERRO "número malformado"           (ex.: 1.2.3)
FRAC --(outro)--> [FLOAT_CONST]
```

`12.` (sem parte fracionária) e `1.2.3` (segundo ponto) são malformados; o erro
é reportado na **posição inicial** do lexema.

## 3. Constante de cadeia (`_ler_cadeia`)

```
INICIO --"--> ABERTA
ABERTA --(qualquer != " e != \n)--> ABERTA
ABERTA --"--> [STRING_CONST]                     (lexema inclui as aspas)
ABERTA --\n ou fim da fonte--> ERRO "string não fechada"
```

`string` não fechada (quebra de linha ou EOF antes da aspa de fechamento) é erro
reportado na **posição da aspa de abertura**.

## 4. Operadores compostos e simples (`_ler_operador`)

```
'<' --'='--> [LE  <=]     senão [LT  <]
'>' --'='--> [GE  >=]     senão [GT  >]
'=' --'='--> [EQ  ==]     senão [ASSIGN =]
'!' --'='--> [NE  !=]     senão ERRO "caractere inválido: '!'"
```

`!` só é válido como parte de `!=` (não há operador de negação na gramática). Os
demais operadores/pontuação são tokens de um único caractere (tabela
`SIMBOLOS`): `+ - * / % ( ) { } [ ] ; ,`.

## 5. Fim de entrada

Ao esgotar a fonte, `proximo_token` devolve `Token(EOF, "", linha, coluna)`;
`tokens()` emite o `EOF` por último e encerra. Programa vazio é **válido**
lexicamente (apenas `EOF`).
