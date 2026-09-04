package com.lexgen.parser;

import java.util.ArrayList;
import java.util.List;

public class RegexLexer {

    public static List<RegexToken> tokenize(String regex) {
        List<RegexToken> tokens = new ArrayList<>();
        int i = 0;
        while (i < regex.length()) {
            char c = regex.charAt(i);

            switch (c) {
                case '(':
                    tokens.add(new RegexToken(RegexTokenType.LPAREN));
                    i++;
                    break;
                case ')':
                    tokens.add(new RegexToken(RegexTokenType.RPAREN));
                    i++;
                    break;
                case '|':
                    tokens.add(new RegexToken(RegexTokenType.OR));
                    i++;
                    break;
                case '*':
                    tokens.add(new RegexToken(RegexTokenType.STAR));
                    i++;
                    break;
                case '+':
                    tokens.add(new RegexToken(RegexTokenType.PLUS));
                    i++;
                    break;
                case '?':
                    tokens.add(new RegexToken(RegexTokenType.QMARK));
                    i++;
                    break;
                case '[': // Início de uma classe de caracteres
                    int closingBracket = regex.indexOf(']', i);
                    if (closingBracket == -1) {
                        throw new IllegalArgumentException("Classe de caracteres não fechada: " + regex.substring(i));
                    }
                    // Captura todo o conteúdo, ex: '[a-zA-Z]'
                    String classContent = regex.substring(i, closingBracket + 1);
                    tokens.add(new RegexToken(RegexTokenType.CHAR_CLASS, classContent));
                    i = closingBracket + 1;
                    break;
                case '\\': // Caractere de escape
                    if (i + 1 >= regex.length()) {
                        throw new IllegalArgumentException("Caractere de escape inválido no final da ER.");
                    }
                    // Trata o próximo caractere como um literal, ex: '\*' ou '\|'
                    char escapedChar = regex.charAt(i + 1);
                    tokens.add(new RegexToken(RegexTokenType.LITERAL, String.valueOf(escapedChar)));
                    i += 2;
                    break;
                default:
                    // Se não for um operador, é um literal
                    // (Ignoramos espaços em branco, assumindo que não fazem parte da ER)
                    if (Character.isWhitespace(c)) {
                        i++;
                    } else {
                        // É um literal simples
                        tokens.add(new RegexToken(RegexTokenType.LITERAL, String.valueOf(c)));
                        i++;
                    }
                    break;
            }
        }
        return tokens;
    }
}
