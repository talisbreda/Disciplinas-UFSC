package com.lexgen.synt;

import com.lexgen.core.Grammar;
import com.lexgen.core.Production;
import com.lexgen.utils.SyntacticUtils;

import java.util.*;

public class SLRTableGenerator {

    private final Grammar grammar;
    private final CanonicalCollection canonicalCollection;
    private final FirstFollow firstFollow;

    public SLRTableGenerator(Grammar grammar) {
        this.grammar = grammar;
        // Precisamos recalcular ou receber prontos
        this.firstFollow = new FirstFollow(grammar);
        this.canonicalCollection = new CanonicalCollection(grammar);
    }

    public SLRTable generate() {
        List<Set<LR0Item>> states = canonicalCollection.getStates();
        Map<Integer, Map<String, Integer>> transitions = canonicalCollection.getTransitions();

        SLRTable table = new SLRTable(
                grammar.getTerminals(),
                grammar.getNonTerminals(),
                states.size()
        );

        // Para cada estado I_i da coleção canônica
        for (int i = 0; i < states.size(); i++) {
            Set<LR0Item> I = states.get(i);

            // 1. Ações baseadas nas transições do autômato (SHIFT e GOTO)
            if (transitions.containsKey(i)) {
                for (Map.Entry<String, Integer> transition : transitions.get(i).entrySet()) {
                    String symbol = transition.getKey();
                    Integer targetState = transition.getValue();

                    if (grammar.getTerminals().contains(symbol)) {
                        // Regra 1: Shift (se símbolo é terminal) -> Action[i, a] = sj
                        table.addAction(i, symbol, "s" + targetState);
                    } else if (grammar.getNonTerminals().contains(symbol)) {
                        // Regra 4: Goto (se símbolo é não-terminal) -> Goto[i, A] = j
                        table.addAction(i, symbol, String.valueOf(targetState));
                    }
                }
            }

            // 2. Ações baseadas nos itens completos (REDUCE e ACCEPT)
            for (LR0Item item : I) {
                if (item.isReduce()) {
                    // O ponto está no final: A -> alpha .
                    Production prod = item.production();
                    String head = prod.head();

                    // Regra 3: Accept
                    // Se for a produção aumentada S' -> S .
                    if (head.equals(grammar.getStartSymbol() + "'")) {
                        table.addAction(i, "$", "acc");
                    }
                    // Regra 2: Reduce
                    // Se A -> alpha .  então para todo 'a' em FOLLOW(A), Action[i, a] = reduce A -> alpha
                    else {
                        // Descobre o índice da produção na gramática original (para gerar r1, r2...)
                        int prodIndex = grammar.getProductions().indexOf(prod);

                        // Se prodIndex for -1, algo está errado (produção fantasma?)
                        if (prodIndex != -1) {
                            Set<String> followA = firstFollow.getFollow(head);
                            for (String terminalInFollow : followA) {
                                table.addAction(i, terminalInFollow, "r" + prodIndex);
                            }
                        }
                    }
                }
            }
        }

        SyntacticUtils.printSLRTable(table);

        return table;
    }
}