package com.lexgen.synt;

import com.lexgen.core.Grammar;
import com.lexgen.core.Production;
import com.lexgen.utils.SyntacticUtils;
import lombok.Getter;

import java.util.*;

@Getter
public class CanonicalCollection {

    private final Grammar grammar;

    // Lista de todos os estados (Conjuntos de Itens I0, I1, ...)
    private final List<Set<LR0Item>> states;

    // Tabela de transições GOTO: (IndiceDoEstado, Simbolo) -> IndiceDoProximoEstado
    // Usamos Integer (índice em states') para identificar os estados I0, I1...
    private final Map<Integer, Map<String, Integer>> transitions;

    public CanonicalCollection(Grammar grammar) {
        this.grammar = grammar;
        this.states = new ArrayList<>();
        this.transitions = new HashMap<>();

        build();
        SyntacticUtils.printCanonicalCollection(this);
    }

    /**
     * Implementa o Algoritmo da Coleção Canônica
     */
    private void build() {
        System.out.println("Construindo Coleção Canônica de Itens LR(0)...");
        // 1. Criar Gramática Aumentada (S' -> S)
        // Adicionamos artificialmente uma produção inicial
        String startSymbol = grammar.getStartSymbol();
        Production augmentedProduction = new Production(startSymbol + "'", List.of(startSymbol));

        // 2. Estado Inicial I0 = Closure({S' -> .S})
        LR0Item startItem = new LR0Item(augmentedProduction, 0);
        Set<LR0Item> startSet = closure(Collections.singleton(startItem));

        states.add(startSet); // I0 é o índice 0

        // 3. Loop até que nenhum estado novo seja adicionado
        boolean changed = true;
        while (changed) {
            changed = false;
            // Copia do tamanho atual para iterar sem ConcurrentModificationException
            int currentSize = states.size();

            for (int i = 0; i < currentSize; i++) {
                Set<LR0Item> I = states.get(i);

                // Para cada símbolo gramatical X (terminal ou não-terminal)
                Set<String> symbols = getSymbolsAfterDot(I);

                for (String X : symbols) {
                    // Calcula J = Goto(I, X)
                    Set<LR0Item> J = goTo(I, X);

                    if (!J.isEmpty()) {
                        // Verifica se J já existe na coleção
                        int existingIndex = states.indexOf(J); // Set.equals funciona aqui

                        if (existingIndex == -1) {
                            // Estado novo!
                            states.add(J);
                            existingIndex = states.size() - 1;
                            changed = true;
                        }

                        // Registra a transição: goto(I, X) = J
                        transitions.computeIfAbsent(i, k -> new HashMap<>()).put(X, existingIndex);
                    }
                }
            }
        }
        System.out.println("Coleção Canônica construída com " + states.size() + " estados.");
    }

    /**
     * Algoritmo Closure.
     */
    private Set<LR0Item> closure(Set<LR0Item> items) {
        Set<LR0Item> closureSet = new HashSet<>(items);
        boolean changed = true;

        while (changed) {
            changed = false;
            Set<LR0Item> newItems = new HashSet<>();

            for (LR0Item item : closureSet) {
                // Para cada item A -> alpha . B beta
                String B = item.getNextSymbol();

                // Se B é um não-terminal, adicionamos as produções de B
                if (B != null && grammar.getNonTerminals().contains(B)) {
                    List<Production> bProductions = grammar.getProductionsFor(B);

                    for (Production prod : bProductions) {
                        // Adiciona item B -> . gamma
                        LR0Item newItem = new LR0Item(prod, 0);
                        if (!closureSet.contains(newItem) && !newItems.contains(newItem)) {
                            newItems.add(newItem);
                            changed = true;
                        }
                    }
                }
            }
            closureSet.addAll(newItems);
        }
        return closureSet;
    }

    /**
     * Função Goto(I, X).
     * Retorna o fecho do conjunto de todos os itens A -> alpha X . beta
     * tais que A -> alpha . X beta está em I.
     */
    private Set<LR0Item> goTo(Set<LR0Item> I, String X) {
        Set<LR0Item> movedItems = new HashSet<>();

        for (LR0Item item : I) {
            String next = item.getNextSymbol();
            if (X.equals(next)) {
                movedItems.add(item.advance());
            }
        }

        return closure(movedItems);
    }

    /**
     * Retorna todos os símbolos que aparecem imediatamente após o ponto
     * em um conjunto de itens. Útil para saber quais 'X' testar no Goto.
     */
    private Set<String> getSymbolsAfterDot(Set<LR0Item> I) {
        Set<String> symbols = new HashSet<>();
        for (LR0Item item : I) {
            String sym = item.getNextSymbol();
            if (sym != null) {
                symbols.add(sym);
            }
        }
        return symbols;
    }
}