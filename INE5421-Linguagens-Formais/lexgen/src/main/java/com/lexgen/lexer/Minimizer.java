package com.lexgen.lexer;

import com.lexgen.core.DFA;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Minimizer {
    public static DFA minimizeIndividualDFA(DFA inputDfa) {
        System.out.println("  ... Minimizando AFD para definição individual...");
        // --- 1. Partição inicial (P0) ---
        Set<Set<String>> partitions = createPartitionsWithNonFinalStates(inputDfa);
        if (!inputDfa.finalStates().isEmpty()) partitions.add(inputDfa.finalStates());

        // --- 2. Refinamento iterativo ---
        partitions = performMinimization(inputDfa, partitions);

        // --- 3. Reconstrução do AFD Minimizado ---
        return reconstructMinimizedDfa(inputDfa, partitions, false,
                null, null, "S");

    }

    public static Set<Set<String>> createPartitionsWithNonFinalStates(DFA dfa) {
        Set<Set<String>> partitions = new HashSet<>();
        Set<String> nonFinalStates = new HashSet<>(dfa.states());
        nonFinalStates.removeAll(dfa.finalStates());
        if (!nonFinalStates.isEmpty()) {
            partitions.add(nonFinalStates);
        }
        return partitions;
    }

    public static Set<Set<String>> performMinimization(DFA dfa, Set<Set<String>> partitions) {
        while (true) {
            boolean changed = false;

            // Conjunto de trabalho que será modificado dinamicamente
            Set<Set<String>> workingPartitions = new HashSet<>(partitions);

            Map<String, Set<String>> stateToPartitionMap = new HashMap<>();
            for (Set<String> p : partitions) {
                for (String state : p) {
                    stateToPartitionMap.put(state, p);
                }
            }

            // LOOP EXTERNO: SÍMBOLOS
            for (String symbol : dfa.alphabet()) {

                // LOOP INTERNO: GRUPOS
                // Criamos uma cópia da lista porque vamos modificar 'workingPartitions' dentro do loop
                List<Set<String>> currentGroupsToCheck = new ArrayList<>(workingPartitions);

                for (Set<String> group : currentGroupsToCheck) {
                    if (group.size() <= 1) continue;

                    Map<Set<String>, Set<String>> splits = new HashMap<>();

                    // Verifica se o símbolo atual divide este grupo específico
                    for (String state : group) {
                        String targetState = dfa.transitionTable().get(state).get(symbol);
                        Set<String> targetPartition = (targetState == null) ? null : stateToPartitionMap.get(targetState);

                        splits.computeIfAbsent(targetPartition, k -> new HashSet<>()).add(state);
                    }

                    // Se houve divisão
                    if (splits.size() > 1) {
                        // Remove o grupo "velho" (grande)
                        workingPartitions.remove(group);
                        // Adiciona os novos grupos (pedaços menores)
                        workingPartitions.addAll(splits.values());

                        changed = true;
                    }
                }
            }

            if (!changed) {
                break;
            } else {
                partitions = workingPartitions;
            }
        }
        return partitions;
    }

    /*
     * Reconstrói o DFA minimizado a partir das partições finais.
     * Os parâmetros 'isFinalDfa', 'dfaFinalStateToTokenMap' e 'minimizedFinalStateToTokenMap' devem ser enviados
     * apenas se o DFA sendo minimizado for o DFA final (após combinar todos os DFAs individuais e determinizar).
     */
    public static DFA reconstructMinimizedDfa(DFA inputDfa, Set<Set<String>> partitions, boolean isFinalDfa,
                                            Map<String, String> dfaFinalStateToTokenMap,
                                            Map<String, String> minimizedFinalStateToTokenMap,
                                            String defaultStateName) {
        // --- 3. Reconstruct the Minimized DFA ---
        // Map old partition -> New State Name (S0, S1...)
        Map<Set<String>, String> partitionToNewName = new HashMap<>();
        Map<String, Set<String>> stateToPartitionMap = new HashMap<>();
        for (Set<String> p : partitions) {
            for (String s : p) stateToPartitionMap.put(s, p);
        }

        int counter = 0;
        Set<String> startPartition = stateToPartitionMap.get(inputDfa.startState());
        String newStartName = defaultStateName + "0";
        partitionToNewName.put(startPartition, newStartName);

        for (Set<String> p : partitions) {
            if (!partitionToNewName.containsKey(p)) {
                partitionToNewName.put(p, defaultStateName + (++counter));
            }
        }

        Set<String> newStates = new HashSet<>(partitionToNewName.values());
        Set<String> newFinalStates = new HashSet<>();
        Map<String, Map<String, String>> newTransitions = new HashMap<>();
        for (Set<String> p : partitions) {
            String newName = partitionToNewName.get(p);

            // Pega um representante qualquer
            String rep = p.iterator().next();

            // Verifica se é final
            if (inputDfa.finalStates().contains(rep)) {
                newFinalStates.add(newName);
                if (isFinalDfa) {
                    String token = dfaFinalStateToTokenMap.get(rep);
                    minimizedFinalStateToTokenMap.put(newName, token);
                }
            }
            Map<String, String> transRow = new HashMap<>();
            for (String symbol : inputDfa.alphabet()) {
                String target = inputDfa.transitionTable().get(rep).get(symbol);
                if (target != null) {
                    String targetName = partitionToNewName.get(stateToPartitionMap.get(target));
                    transRow.put(symbol, targetName);
                }
            }
            newTransitions.put(newName, transRow);
        }
        return new DFA(
                newStates,
                inputDfa.alphabet(),
                newTransitions,
                newStartName,
                newFinalStates
        );
    }
}
