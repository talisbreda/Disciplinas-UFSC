package com.lexgen.parser;

import lombok.Data;

// Classe para armazenar cada token
@Data
public class RegexToken {
    private final RegexTokenType type;
    private final String value; // 'a' para LITERAL, '[a-z]' para CHAR_CLASS

    public RegexToken(RegexTokenType type, String value) {
        this.type = type;
        this.value = value;
    }

    public boolean isConcatPreceded() {
        return switch (type) {
            case LITERAL, CHAR_CLASS, RPAREN, STAR, PLUS, QMARK -> true;
            default -> false;
        };
    }

    public boolean isConcatFollowed() {
        return switch (type) {
            case LITERAL, CHAR_CLASS, LPAREN -> true;
            default -> false;
        };
    }

    public RegexToken(RegexTokenType type) {
        this(type, null);
    }

    @Override
    public String toString() {
        return type + (value != null ? "(" + value + ")" : "");
    }
}