package com.lexgen.parser;

// Enum para os tipos de tokens que uma ER pode ter
public enum RegexTokenType {
    LITERAL,     // 'a', 'b', '1', ou um caractere escapado como '\'
    CHAR_CLASS,  // '[a-z]', '[0-9]', '[a-zA-Z_]'
    OR,          // '|'
    STAR,        // '*'
    PLUS,        // '+'
    QMARK,       // '?'
    LPAREN,      // '('
    RPAREN,      // ')'
    CONCAT       // Operador '.' (adicionado internamente)
}
