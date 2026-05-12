package com.lexgen.parser;

import com.lexgen.lexer.Token;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class TokenParser {

    public static List<Token> parseTokenFile(String filePath) throws IOException {
        List<Token> tokens = new ArrayList<>();
        List<String> lines = Files.readAllLines(Paths.get(filePath), StandardCharsets.UTF_8);

        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty()) continue;

            // Validação básica do formato
            if (!line.startsWith("<") || !line.endsWith(">")) {
                System.err.println("Linha ignorada (formato inválido): " + line);
                continue;
            }

            // Remove o prefixo "<" e o sufixo ">"
            // Exemplo entrada: "<program, PROGRAM>"
            // Conteúdo extraído: "program, PROGRAM"
            String content = line.substring(1, line.length() - 1);

            int separatorIndex = content.lastIndexOf(", ");

            if (separatorIndex == -1) {
                System.err.println("Linha ignorada (sem separador): " + line);
                continue;
            }

            String lexeme = content.substring(0, separatorIndex);
            String tokenName = content.substring(separatorIndex + 2); // Pula ", "

            tokens.add(new Token(lexeme, tokenName));
        }

        return tokens;
    }
}