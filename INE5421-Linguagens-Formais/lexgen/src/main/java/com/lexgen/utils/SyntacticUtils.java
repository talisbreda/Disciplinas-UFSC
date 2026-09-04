package com.lexgen.utils;

import com.lexgen.core.Grammar;
import com.lexgen.core.Production;
import com.lexgen.synt.CanonicalCollection;
import com.lexgen.synt.FirstFollow;
import com.lexgen.synt.LR0Item;
import com.lexgen.synt.SLRTable;
import com.lexgen.synt.SymbolTable;
import lombok.Getter;
import lombok.Setter;

import java.util.*;

/**
 * Classe utilitária para visualização das estruturas do analisador sintático.
 */
import java.io.File;
import java.io.PrintStream;
import java.io.IOException;

public class SyntacticUtils {

    @Getter
    @Setter
    private static int testIndex = 0;

    public static void printGrammar(Grammar g) {
        printToFile("grammar", out -> printGrammarInternal(g, out));
    }

    public static void printFirstFollow(FirstFollow ff, Grammar g) {
        printToFile("first_follow", out -> printFirstFollowInternal(ff, g, out));
    }

    public static void printCanonicalCollection(CanonicalCollection cc) {
        printToFile("canonical_collection", out -> printCanonicalCollectionInternal(cc, out));
    }

    public static void printSLRTable(SLRTable slrTable) {
        printToFile("slr_table", out -> printSLRTableInternal(slrTable, out));
    }

    public static void printSymbolTable(SymbolTable st, String filename) {
        printToFile("symbol_table", out -> printSymbolTableInternal(st, out));
    }

    private interface Printer {
        void print(PrintStream out);
    }

    private static void printToFile(String filename, Printer printer) {
        String filePath;
        if (testIndex != -1) filePath = "src/main/resources/testes_automatizados/teste" + testIndex + "/resultado/" + filename + ".txt";
        else filePath = "src/main/resources/teste_manual/resultado/" + filename + ".txt";

        try (PrintStream fileOut = new PrintStream(new File(filePath))) {
            printer.print(fileOut);
            System.out.println("Arquivo gerado com sucesso: " + filePath);
        } catch (IOException e) {
            System.err.println("Erro ao escrever no arquivo " + filePath + ": " + e.getMessage());
        }
    }

    private static void printGrammarInternal(Grammar g, PrintStream out) {
        out.println("\n=== GRAMÁTICA ===");
        out.println("Símbolo Inicial: " + g.getStartSymbol());
        out.println("Terminais: " + sortSet(g.getTerminals()));
        out.println("Não-Terminais: " + sortSet(g.getNonTerminals()));
        out.println("Produções:");

        List<Production> prods = g.getProductions();
        for (int i = 0; i < prods.size(); i++) {
            out.printf("  (%d) %s\n", i, prods.get(i));
        }
    }

    private static void printFirstFollowInternal(FirstFollow ff, Grammar g, PrintStream out) {
        out.println("\n=== CONJUNTOS FIRST & FOLLOW ===");
        out.printf("%-15s | %-30s | %-30s\n", "Não-Terminal", "FIRST", "FOLLOW");
        out.println("-".repeat(80));

        for (String nt : g.getNonTerminals()) {
            String first = sortSet(ff.getFirst(nt)).toString();
            String follow = sortSet(ff.getFollow(nt)).toString();
            out.printf("%-15s | %-30s | %-30s\n", nt, first, follow);
        }
    }

    private static void printCanonicalCollectionInternal(CanonicalCollection cc, PrintStream out) {
        List<Set<LR0Item>> states = cc.getStates();
        Map<Integer, Map<String, Integer>> transitions = cc.getTransitions();

        out.println("\n=== COLEÇÃO CANÔNICA (AUTÔMATO) ===");
        out.println("Total de Estados: " + states.size());

        for (int i = 0; i < states.size(); i++) {
            out.println("\nEstado I" + i + ":");
            List<String> itemStrings = new ArrayList<>();
            for (LR0Item item : states.get(i)) {
                itemStrings.add(item.toString());
            }
            Collections.sort(itemStrings);
            for (String s : itemStrings) {
                out.println("  " + s);
            }

            if (transitions.containsKey(i)) {
                out.println("  Transições:");
                Map<String, Integer> trans = transitions.get(i);
                List<String> keys = new ArrayList<>(trans.keySet());
                Collections.sort(keys);
                for (String key : keys) {
                    out.printf("    --(%s)--> I%d\n", key, trans.get(key));
                }
            }
        }
    }

    private static void printSLRTableInternal(SLRTable slrTable, PrintStream out) {
        out.println("\n=== TABELA DE ANÁLISE SLR ===");
        List<String> terminals = sortSet(slrTable.getTerminals());
        if (!terminals.contains("$")) terminals.add("$");
        List<String> nonTerminals = sortSet(slrTable.getNonTerminals());
        List<String> allHeaders = new ArrayList<>(terminals);
        allHeaders.addAll(nonTerminals);

        final int COL_WIDTH = 18;
        out.printf("%-6s", "State");
        for (String h : allHeaders) {
            out.printf("| %-" + COL_WIDTH + "s", h);
        }

        int totalWidth = 6 + (allHeaders.size() * (COL_WIDTH + 3));
        out.println("\n" + "-".repeat(totalWidth));

        Map<Integer, Map<String, String>> table = slrTable.getTable();
        for (int i = 0; i < slrTable.getTotalStates(); i++) {
            out.printf("%-6d", i);
            Map<String, String> row = table.getOrDefault(i, Collections.emptyMap());
            for (String h : allHeaders) {
                String val = row.get(h);
                out.printf("| %-" + COL_WIDTH + "s", val == null ? "" : val);
            }
            out.println();
        }
    }

    private static void printSymbolTableInternal(SymbolTable st, PrintStream out) {
        out.println("\n=== TABELA DE SÍMBOLOS ===");
        out.printf("%-20s | %-15s | %-10s\n", "Lexema", "Tipo", "Endereço");
        out.println("-".repeat(55));

        List<SymbolTable.SymbolEntry> entries = new ArrayList<>(st.getEntries());
        entries.sort((e1, e2) -> {
            if (e1.address() != -1 && e2.address() != -1) return Integer.compare(e1.address(), e2.address());
            if (e1.address() == -1 && e2.address() == -1) return e1.lexeme().compareTo(e2.lexeme());
            return e1.address() != -1 ? -1 : 1;
        });

        for (SymbolTable.SymbolEntry e : entries) {
            String addrStr = (e.address() == -1) ? "-" : String.valueOf(e.address());
            out.printf("%-20s | %-15s | %-10s\n", e.lexeme(), e.type(), addrStr);
        }
    }

    private static List<String> sortSet(Set<String> set) {
        List<String> list = new ArrayList<>(set);
        Collections.sort(list);
        return list;
    }
}
