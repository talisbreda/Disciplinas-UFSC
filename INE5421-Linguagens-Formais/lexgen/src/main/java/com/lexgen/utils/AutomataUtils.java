package com.lexgen.utils;

import com.lexgen.core.DFA;
import com.lexgen.core.NFA;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Classe de utilidade para operações com autômatos, como impressão.
 */
public class AutomataUtils {

    @Getter
    @Setter
    private static int testIndex = 0;

    private static String getFilePath(String filename) {
        if (testIndex != -1) return "src/main/resources/testes_automatizados/teste" + testIndex + "/resultado/" + filename + ".txt";
        else return "src/main/resources/teste_manual/resultado/" + filename + ".txt";
    }

    public static void printDFA(DFA dfa, String title, String filename) {
        String filePath = getFilePath("dfas/" + filename);
        printToFile(filePath, out -> printDFAInternal(dfa, title, out));
    }

    public static void printNFA(NFA nfa, String title, String filename) {
        String filePath = getFilePath(filename);
        printToFile(filePath, out -> printNFAInternal(nfa, title, out));
    }

    public static void printLexicalAnalysisTable(DFA dfa, Map<String, String> finalStateTokenMap, String title, String filename) {
        String filePath = getFilePath(filename);
        printToFile(filePath, out -> printLexicalAnalysisTableInternal(dfa, finalStateTokenMap, title, out));
    }

    private interface Printer {
        void print(PrintStream out);
    }

    private static void printToFile(String filename, AutomataUtils.Printer printer) {
        try (PrintStream fileOut = new PrintStream(new File(filename))) {
            printer.print(fileOut);
            System.out.println("Arquivo gerado com sucesso: " + filename);
        } catch (IOException e) {
            System.err.println("Erro ao escrever no arquivo " + filename + ": " + e.getMessage());
        }
    }

    /**
     * Imprime qualquer objeto DFA em um formato de tabela legível.
     * @param dfa O AFD a ser impresso.
     * @param title O título a ser exibido (ex: "AFD para 'id'")
     */
    public static void printDFAInternal(DFA dfa, String title, PrintStream out) {
        if (dfa == null) {
            out.println("DFA é nulo.");
            return;
        }

        out.println("\n====== " + title + " ======");
        out.println("Alfabeto: " + dfa.alphabet());
        out.println("Estado Inicial: " + dfa.startState());
        out.println("Estados Finais: " + dfa.finalStates());

        List<String> alphabetList = new ArrayList<>(dfa.alphabet());
        Collections.sort(alphabetList);

        out.println("\n--- Tabela de Transições ---");
        out.printf("%-10s", "Estado");
        for (String symbol : alphabetList) {
            out.printf("| %-8s", symbol);
        }
        out.println("\n" + "=".repeat(10 + (alphabetList.size() * 11)));

        // Ordena os nomes dos estados para impressão consistente
        List<String> stateNames = new ArrayList<>(dfa.states());
        Collections.sort(stateNames);

        for (String stateName : stateNames) {
            String stateLabel = stateName;
            if (stateName.equals(dfa.startState())) stateLabel = "->" + stateLabel;
            if (dfa.finalStates().contains(stateName)) stateLabel = stateLabel + "*";

            out.printf("%-10s", stateLabel);

            Map<String, String> transitions = dfa.transitionTable().get(stateName);
            for (String symbol : alphabetList) {
                String targetState = transitions.get(symbol);
                targetState = (targetState == null) ? "-" : targetState;
                out.printf("| %-8s", targetState);
            }
            out.println();
        }
        out.println("==============================================");
    }

    // Dentro de AutomataUtils.java...

    /**
     * Imprime qualquer objeto NFA em um formato de tabela legível.
     * @param nfa O AFND a ser impresso.
     * @param title O título a ser exibido (ex: "AFND Combinado")
     */
    public static void printNFAInternal(NFA nfa, String title, PrintStream out) {
        if (nfa == null) {
            out.println("NFA é nulo.");
            return;
        }

        out.println("\n====== " + title + " ======");
        out.println("Alfabeto: " + nfa.alphabet());
        out.println("Estado Inicial: " + nfa.startState());
        out.println("Estados Finais: " + nfa.finalStates());

        // Prepara o cabeçalho da tabela, incluindo Épsilon
        List<String> alphabetList = new ArrayList<>(nfa.alphabet());
        Collections.sort(alphabetList);
        // Adiciona a coluna Épsilon
        List<String> columns = new ArrayList<>();
        columns.add("&"); // Épsilon primeiro
        columns.addAll(alphabetList);

        out.println("\n--- Tabela de Transições ---");
        out.printf("%-20s", "Estado");
        for (String symbol : columns) {
            out.printf("| %-20s", symbol);
        }
        out.println("\n" + "=".repeat(10 + (columns.size() * 15)));

        // Ordena os nomes dos estados para impressão consistente
        List<String> stateNames = new ArrayList<>(nfa.states());
        Collections.sort(stateNames);

        for (String stateName : stateNames) {
            String stateLabel = stateName;
            if (stateName.equals(nfa.startState())) stateLabel = "->" + stateLabel;
            if (nfa.finalStates().contains(stateName)) stateLabel = stateLabel + "*";

            out.printf("%-20s", stateLabel);

            Map<String, Map<String, Set<String>>> transitionTable = nfa.transitionTable();
            Map<String, Set<String>> transitions = transitionTable.get(stateName);
            if (transitions == null) transitions = Collections.emptyMap();

            // Imprime transições para cada símbolo (incluindo épsilon)
            for (String symbol : columns) {
                // 'null' é a chave para épsilon
                String symbolKey = symbol.equals("&") ? null : symbol;

                Set<String> targetStates = transitions.get(symbolKey);

                if (targetStates == null || targetStates.isEmpty()) {
                    out.printf("| %-20s", "-");
                } else {
                    // Formata como {S1, S2}
                    out.printf("| %-20s", targetStates);
                }
            }
            out.println();
        }
        out.println("==============================================");
    }

    public static void printLexicalAnalysisTableInternal(DFA dfa, Map<String, String> finalStateTokenMap, String title, PrintStream out) {
        if (dfa == null) {
            out.println("DFA é nulo.");
            return;
        }

        out.println("\n====== " + title + " ======");
        out.println("Alfabeto: " + dfa.alphabet());
        out.println("Estado Inicial: " + dfa.startState());

        // Prepara os cabeçalhos das colunas
        List<String> alphabetList = new ArrayList<>(dfa.alphabet());
        Collections.sort(alphabetList);

        // Define o preenchimento (padding) para alinhamento
        final int COL_WIDTH = 12; // Largura da coluna para símbolos
        final String STATE_COL_HEADER = "Estado";
        final String ACTION_COL_HEADER = "Ação (Token)";

        out.println("\n--- Tabela de Análise Léxica ---");

        // --- Imprime o Cabeçalho ---
        out.printf("%-" + COL_WIDTH + "s", STATE_COL_HEADER);
        for (String symbol : alphabetList) {
            out.printf("| %-" + COL_WIDTH + "s", symbol);
        }
        out.printf("| %-" + COL_WIDTH + "s%n", ACTION_COL_HEADER);

        // --- Imprime a Linha Divisória ---
        int totalWidth = COL_WIDTH + (alphabetList.size() * (COL_WIDTH + 2)) + (COL_WIDTH + 2);
        out.println("=".repeat(totalWidth));

        // --- Imprime as Linhas de Estado ---
        List<String> stateNames = new ArrayList<>(dfa.states());
        Collections.sort(stateNames); // Garante uma ordem de impressão consistente

        for (String stateName : stateNames) {
            // Coluna 1: Estado (com marcadores -> e *)
            String stateLabel = stateName;
            if (stateName.equals(dfa.startState())) stateLabel = "->" + stateLabel;
            if (dfa.finalStates().contains(stateName)) stateLabel = stateLabel + "*";
            out.printf("%-" + COL_WIDTH + "s", stateLabel);

            // Colunas 2...N: Transições do Alfabeto
            Map<String, String> transitions = dfa.transitionTable().get(stateName);
            for (String symbol : alphabetList) {
                String targetState = transitions.get(symbol);
                targetState = (targetState == null) ? "-" : targetState;
                out.printf("| %-" + COL_WIDTH + "s", targetState);
            }

            // Coluna N+1: Ação (Token)
            String tokenName = finalStateTokenMap.get(stateName); // Busca no mapa de ações
            tokenName = (tokenName == null) ? "-" : "-> " + tokenName; // Ex: "-> id"
            out.printf("| %-" + COL_WIDTH + "s%n", tokenName);
        }
        out.println("=".repeat(totalWidth));
    }

    public static void printTokenListAsTestFile(StringBuilder sb) {
        String filePath;
        if (testIndex != -1) filePath = "src/main/resources/testes_automatizados/teste" + testIndex + "/token-list.txt";
        else filePath = "src/main/resources/teste_manual/token-list.txt";

        write(filePath, sb);
    }

    public static void printToFile(StringBuilder sb, String filename) {
        String filePath = getFilePath(filename);
        write(filePath, sb);
    }

    public static void write(String filePath, StringBuilder sb) {
        try (java.io.PrintWriter out = new java.io.PrintWriter(filePath, StandardCharsets.UTF_8)) {
            out.print(sb.toString());
            System.out.println("Arquivo gerado com sucesso: " + filePath);
        } catch (java.io.IOException e) {
            System.err.println("Erro ao escrever no arquivo " + filePath + ": " + e.getMessage());
        }
    }
}
