package com.lexgen.parser;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

public class ReservedWordsParser {

    /**
     * Lê um arquivo de texto contendo palavras reservadas (uma por linha).
     * @param filePath Caminho do arquivo.
     * @return Lista de strings contendo as palavras.
     * @throws IOException Se houver erro na leitura.
     */
    public static List<String> loadReservedWords(String filePath) throws IOException {
        return Files.readAllLines(Paths.get(filePath), StandardCharsets.UTF_8)
                .stream()
                .map(String::trim)           // Remove espaços (ex: " if " -> "if")
                .filter(line -> !line.isEmpty()) // Ignora linhas em branco
                .collect(Collectors.toList());
    }
}
