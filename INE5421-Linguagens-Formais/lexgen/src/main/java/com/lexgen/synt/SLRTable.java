package com.lexgen.synt;

import lombok.Getter;

import java.util.*;

@Getter
public class SLRTable {
    // Tabela: Estado (Int) -> (Símbolo (String) -> Ação (String))
    private final Map<Integer, Map<String, String>> table;
    private final Set<String> terminals;
    private final Set<String> nonTerminals;
    private final int totalStates;

    public SLRTable(Set<String> terminals, Set<String> nonTerminals, int totalStates) {
        this.table = new HashMap<>();
        this.terminals = terminals;
        this.nonTerminals = nonTerminals;
        this.totalStates = totalStates;
    }

    public void addAction(int state, String symbol, String action) {
        table.computeIfAbsent(state, k -> new HashMap<>());

        String existing = table.get(state).get(symbol);

        if (existing != null && !existing.equals(action)) {
            // --- RESOLUÇÃO DE CONFLITOS ---

            boolean isShiftReduce = existing.startsWith("s") && action.startsWith("r");
            boolean isReduceShift = existing.startsWith("r") && action.startsWith("s");

            // (Shift/Reduce)
            // Se já temos um SHIFT e estamos tentando adicionar um REDUCE:
            // PREFERIMOS O SHIFT. (Mantemos o existente, ignoramos o novo)
            if (isShiftReduce) {
                System.out.println("AVISO: Conflito Shift/Reduce resolvido a favor de Shift em " +
                        state + " símbolo '" + symbol + "' (Ignorando " + action + ")");
                return;
            }

            // Se já temos um REDUCE e estamos tentando adicionar um SHIFT:
            // PREFERIMOS O SHIFT. (Sobrescrevemos o existente pelo novo)
            if (isReduceShift) {
                System.out.println("AVISO: Conflito Reduce/Shift resolvido a favor de Shift em " +
                        state + " símbolo '" + symbol + "' (Substituindo " + existing + " por " + action + ")");
                table.get(state).put(symbol, action);
                return;
            }

            // Se for Reduce/Reduce, é um erro grave na gramática (ambiguidade real)
            throw new RuntimeException(
                    String.format("CONFLITO GRAVE (Reduce/Reduce) na tabela SLR! Estado %d, Símbolo '%s'. " +
                                    "Existente: %s, Novo: %s.",
                            state, symbol, existing, action)
            );
        }

        // Se não houver conflito, adiciona normalmente
        table.get(state).put(symbol, action);
    }

    public String getAction(int state, String symbol) {
        if (!table.containsKey(state)) return null;
        return table.get(state).get(symbol);
    }
}