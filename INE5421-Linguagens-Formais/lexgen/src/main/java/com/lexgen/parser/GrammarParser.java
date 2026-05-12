package com.lexgen.parser;

import com.lexgen.core.Grammar;
import com.lexgen.utils.SyntacticUtils;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class GrammarParser {

    public static Grammar loadGrammar(String filePath) throws IOException {
        Grammar grammar = new Grammar();
        List<String> lines = Files.readAllLines(Paths.get(filePath), StandardCharsets.UTF_8);

        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty()) continue;

            // Formato esperado: HEAD ::= BODY
            String[] parts = line.split("::=");
            if (parts.length < 2) {
                throw new IllegalArgumentException("Formato de produção inválido: " + line);
            }

            String head = parts[0].trim();
            // Remove < e > se o input usar a notação <S>, senão usa o texto puro
            if (head.startsWith("<") && head.endsWith(">")) {
                head = head.substring(1, head.length() - 1);
            }

            String bodyStr = parts[1].trim();
            // Divide o corpo por espaços
            List<String> body = Arrays.stream(bodyStr.split("\\s+"))
                    .map(s -> {
                        // Remove < > se houver
                        if (s.startsWith("<") && s.endsWith(">")) {
                            return s.substring(1, s.length() - 1);
                        }
                        return s;
                    })
                    .collect(Collectors.toList());

            grammar.addProduction(head, body);
        }

        grammar.finalizeGrammar();
        SyntacticUtils.printGrammar(grammar);
        return grammar;
    }

}