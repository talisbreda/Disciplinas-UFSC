package com.lexgen.parser;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ERFileParser {
    public static Map<String, List<RegexToken>> parse(String filePath) throws IOException {
        Map<String, List<RegexToken>> definitions = new LinkedHashMap<>();

        try (BufferedReader reader = Files.newBufferedReader(Paths.get(filePath), StandardCharsets.UTF_8)) {
            String line;
            int lineNumber = 0;

            while ((line = reader.readLine()) != null) {
                lineNumber++;
                line = line.trim();

                if (line.isEmpty()) {
                    continue; // Ignora linhas em branco
                }

                int separatorIndex = line.indexOf(':');

                if (separatorIndex <= 0) {
                    throw new IllegalArgumentException(
                            "Formato inválido na linha " + lineNumber + ": " +
                                    "Faltando nome do token ou separador ':'. Linha: \"" + line + "\""
                    );
                }

                String tokenName = line.substring(0, separatorIndex).trim();
                String regexString = "(" + line.substring(separatorIndex + 1).trim() + ")"; // Adiciona parênteses

                if (regexString.equals("()")) { // Verifica regex vazia
                    throw new IllegalArgumentException(
                            "Formato inválido na linha " + lineNumber + ": " +
                                    "Definição de regex ausente para o token '" + tokenName + "'."
                    );
                }

                if (definitions.containsKey(tokenName)) {
                    throw new IllegalArgumentException(
                            "Formato inválido na linha " + lineNumber + ": " +
                                    "Nome do token duplicado '" + tokenName + "'."
                    );
                }

                try {
                    List<RegexToken> tokens = RegexLexer.tokenize(regexString);
                    definitions.put(tokenName, tokens);
                } catch (IllegalArgumentException e) {
                    throw new IllegalArgumentException(
                            "Erro ao analisar regex para '" + tokenName + "' na linha " + lineNumber + ": " + e.getMessage()
                    );
                }
            }
        }

        return definitions;
    }
}
