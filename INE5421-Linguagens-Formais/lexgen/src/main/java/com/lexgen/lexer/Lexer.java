package com.lexgen.lexer;

import com.lexgen.core.DFA;
import com.lexgen.utils.AutomataUtils;
import com.lexgen.utils.CharSetUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Interface de execução
 */
public class Lexer {

    private final DFA dfa;
    private final Map<String, String> actionMap;

    /**
     * caractere (ex: 'a') para o símbolo do alfabeto do DFA (ex: "[a-zA-Z]").
     */
    private final Map<Character, Set<String>> charToSymbolSetsMap;

    /**
     * Constrói a interface de execução do analisador léxico.
     * @param dfa O AFD final e minimizado.
     * @param actionMap O mapa que vincula estados finais a nomes de tokens.
     */
    public Lexer(DFA dfa, Map<String, String> actionMap) {
        this.dfa = dfa;
        this.actionMap = actionMap;
        this.charToSymbolSetsMap = new HashMap<>();

        buildCharToSymbolSetsMap(dfa.alphabet());
    }

    public void abortIfErrors(List<Token> tokens) {
        for (Token token : tokens) {
            if (token.tokenName().equals("erro!")) {
                throw new RuntimeException("Erro léxico: Token inválido encontrado: " + token);
            }
        }
    }

    /**
     * Analisa um arquivo de entrada e retorna a lista de tokens encontrados.
     */
    public List<Token> analyzeFile(String filePath) throws IOException {
        List<String> lines = Files.readAllLines(Paths.get(filePath));
        List<Token> allTokens = new ArrayList<>();

        System.out.println("--- Analisando Arquivo: " + filePath + " ---");

        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty()) {
                continue;
            }

            // Analisa a linha
            allTokens.addAll(analyzeLine(line));
        }

        StringBuilder sb = new StringBuilder();
        for (Token token : allTokens) {
            sb.append(token).append("\n");
        }

        AutomataUtils.printToFile(sb, "tokens");
        AutomataUtils.printTokenListAsTestFile(sb);
        System.out.println("--- Fim da Análise Léxica ---");

        abortIfErrors(allTokens);

        return allTokens;
    }

    /**
     * Analisa uma única linha (lexema) do arquivo de entrada.
     * Tenta encontrar a correspondência mais longa
     */
    private List<Token> analyzeLine(String line) {
        List<Token> tokens = new ArrayList<>();
        int cursor = 0;

        while (cursor < line.length()) {

            char startChar = line.charAt(cursor);
            if (Character.isWhitespace(startChar)) {
                cursor++;
                continue;
            }

            String currentState = dfa.startState();
            int lastMatchEnd = -1;
            String lastMatchToken = null;

            int currentScanPos = cursor;

            while (currentScanPos < line.length()) {
                char c = line.charAt(currentScanPos);


                // 1. Obtém o CONJUNTO de símbolos possíveis para este caractere
                Set<String> possibleSymbols = charToSymbolSetsMap.get(c);

                if (possibleSymbols == null) {
                    // Caractere não pertence a nenhum alfabeto conhecido.
                    break;
                }

                // 2. Obtém as transições do estado atual
                Map<String, String> transitions = dfa.transitionTable().get(currentState);
                if (transitions == null) transitions = Map.of(); // Estado sem saídas

                // 3. Encontra a transição válida
                String nextState = null;
                for (String symbol : possibleSymbols) {
                    String targetState = transitions.get(symbol);
                    if (targetState != null) {
                        // Encontramos a transição!
                        // (Não deve haver duas, ex: uma para "[0-9]" e uma para "0")
                        nextState = targetState;
                        break;
                    }
                }

                if (nextState == null) {
                    // Sem transição (estado de erro implícito).
                    break;
                }

                currentState = nextState;
                currentScanPos++;

                String tokenNameIfFinal = actionMap.get(currentState);
                if (tokenNameIfFinal != null) {
                    lastMatchEnd = currentScanPos;
                    lastMatchToken = tokenNameIfFinal;
                }
            }

            if (lastMatchEnd == -1) {
                String lexeme = String.valueOf(line.charAt(cursor));
                tokens.add(new Token(lexeme, "erro!"));
                cursor++;
            } else {
                String lexeme = line.substring(cursor, lastMatchEnd);
                tokens.add(new Token(lexeme, lastMatchToken));
                cursor = lastMatchEnd;
            }
        }
        return tokens;
    }


    /**
     * (Auxiliar) Constrói o mapa de tradução char -> symbol.
     * Ex: 'a' -> "[a-zA-Z]", '1' -> "[0-9]", '+' -> "+"
     */
    private void buildCharToSymbolSetsMap(Set<String> symbols) {
        for (String symbol : symbols) {
            if (symbol.equals(CharSetUtils.END_MARKER)) continue;

            if (symbol.startsWith("[") && symbol.endsWith("]")) {
                // É uma classe de caracteres (ex: "[a-zA-Z0-9]")
                String content = symbol.substring(1, symbol.length() - 1);
                int i = 0;
                while (i < content.length()) {
                    char c = content.charAt(i);

                    if (c == '\\') {
                        i++;
                        if (i < content.length()) {
                            char escapedChar = content.charAt(i);
                            charToSymbolSetsMap.computeIfAbsent(escapedChar, k -> new HashSet<>()).add(symbol);
                        }
                        i++;
                    } else if (i + 2 < content.length() && content.charAt(i + 1) == '-') { // Range a-z
                        char start = c;
                        char end = content.charAt(i + 2);
                        for (char ch = start; ch <= end; ch++) {
                            if (!Character.isWhitespace(ch)) {
                                charToSymbolSetsMap.computeIfAbsent(ch, k -> new HashSet<>()).add(symbol);
                            }
                        }
                        i += 3;
                    } else { // Literal dentro de colchetes
                        if (!Character.isWhitespace(c)) {
                            charToSymbolSetsMap.computeIfAbsent(c, k -> new HashSet<>()).add(symbol);
                        }
                        i++;
                    }
                }
            } else if (symbol.length() == 1) {
                // Literal simples fora de colchetes
                char c = symbol.charAt(0);
                if (!Character.isWhitespace(c)) {
                    charToSymbolSetsMap.computeIfAbsent(c, k -> new HashSet<>()).add(symbol);
                }
            }
        }
    }
}
