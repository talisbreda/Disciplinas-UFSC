package com.lexgen.utils;

import java.util.*;

public class CharSetUtils {

    public static final String END_MARKER = "\u0000";

    /**
     * Converte uma string de símbolo (ex: "[a-z]", "0") em um conjunto de caracteres Java.
     */
    public static Set<Character> parseSymbol(String symbol) {
        Set<Character> chars = new HashSet<>();
        if (symbol.equals(END_MARKER) || symbol.equals("&")) return chars; // Ignora especiais

        if (symbol.startsWith("[") && symbol.endsWith("]")) {
            // É uma classe, ex: [a-zA-Z0-9]
            String content = symbol.substring(1, symbol.length() - 1);
            int i = 0;
            while (i < content.length()) {
                char c = content.charAt(i);
                if (c == '\\') { // Escape
                    i++;
                    if (i < content.length()) chars.add(content.charAt(i));
                    i++;
                } else if (i + 2 < content.length() && content.charAt(i + 1) == '-') { // Range
                    char start = c;
                    char end = content.charAt(i + 2);
                    for (char ch = start; ch <= end; ch++) {
                        chars.add(ch);
                    }
                    i += 3;
                } else { // Literal
                    chars.add(c);
                    i++;
                }
            }
        } else if (symbol.length() == 1) {
            chars.add(symbol.charAt(0));
        } else {
            // Fallback para literais escapados ou complexos
            chars.add(symbol.charAt(0));
        }
        return chars;
    }

    /**
     * Calcula conjuntos disjuntos a partir de uma lista de símbolos brutos.
     * Ex: Entrada ["1", "[0-9]"] -> Saída [{"1"}, {"0", "2-9"}]
     */
    public static Map<String, Set<Character>> computeDisjointSets(Set<String> rawSymbols) {
        // 1. Mapeia cada símbolo original para seu conjunto de caracteres
        Map<String, Set<Character>> symbolToChars = new HashMap<>();
        Set<Character> universe = new HashSet<>();

        for (String sym : rawSymbols) {
            if (sym.equals("&") || sym.equals(END_MARKER)) continue;
            Set<Character> chars = parseSymbol(sym);
            symbolToChars.put(sym, chars);
            universe.addAll(chars);
        }

        // 2. Algoritmo de Particionamento
        // Começa com o universo como uma única partição
        List<Set<Character>> partitions = new ArrayList<>();
        if (!universe.isEmpty()) {
            partitions.add(universe);
        }

        // Para cada símbolo do regex, refina as partições existentes
        for (Set<Character> symbolSet : symbolToChars.values()) {
            List<Set<Character>> nextPartitions = new ArrayList<>();

            for (Set<Character> partition : partitions) {
                // Interseção: Caracteres que estão na partição E no símbolo atual
                Set<Character> intersection = new HashSet<>(partition);
                intersection.retainAll(symbolSet);

                // Diferença: Caracteres que estão na partição MAS NÃO no símbolo atual
                Set<Character> difference = new HashSet<>(partition);
                difference.removeAll(symbolSet);

                if (!intersection.isEmpty()) {
                    nextPartitions.add(intersection);
                }
                if (!difference.isEmpty()) {
                    nextPartitions.add(difference);
                }
            }
            partitions = nextPartitions;
        }

        // 3. Gera nomes legíveis para as novas partições
        Map<String, Set<Character>> disjointMap = new LinkedHashMap<>();
        for (Set<Character> partition : partitions) {
            String label = generateLabel(partition);
            disjointMap.put(label, partition);
        }
        return disjointMap;
    }

    /**
     * Gera um rótulo seguro para o conjunto de caracteres, sem usar vírgulas extras
     * que confundiriam o Lexer.
     * Ex: {a, b, c} vira "[abc]" em vez de "[a, b, c]"
     */
    private static String generateLabel(Set<Character> chars) {
        if (chars.isEmpty()) return "[]";

        // Se for apenas um caractere, retorna ele puro (ex: "a", "+")
        // Isso facilita a leitura na tabela
        if (chars.size() == 1) {
            return String.valueOf(chars.iterator().next());
        }

        StringBuilder sb = new StringBuilder();
        sb.append("[");

        List<Character> sorted = new ArrayList<>(chars);
        Collections.sort(sorted);

        for (char c : sorted) {
            // Precisamos escapar caracteres que têm significado especial dentro de []
            // O Lexer trata '\', ']' e '-' como especiais dentro de classes.
            if (c == ']' || c == '\\' || c == '-') {
                sb.append('\\');
            }
            sb.append(c);
        }

        sb.append("]");
        return sb.toString();
    }
}
