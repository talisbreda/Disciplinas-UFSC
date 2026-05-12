package com.lexgen.lexer;

/**
 * Representa um token encontrado pelo analisador léxico.
 * Corresponde ao formato (lexema, padrão).
 */
public record Token(String lexeme, String tokenName) {

    @Override
    public String toString() {
        // Formata a saída como nos exemplos <al,id>
        return "<" + lexeme + ", " + tokenName + ">";
    }
}
