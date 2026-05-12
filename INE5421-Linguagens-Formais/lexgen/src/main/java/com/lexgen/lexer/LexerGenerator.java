package com.lexgen.lexer;

import com.lexgen.core.DFA;
import com.lexgen.core.NFA;
import com.lexgen.parser.ERFileParser;
import com.lexgen.parser.RegexToken;
import com.lexgen.regex.RegexToDfaConverter;
import com.lexgen.utils.AutomataUtils;
import com.lexgen.utils.CharSetUtils;
import lombok.Data;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;
import java.util.Stack;

/**
 * Classe principal do framework.
 * 1. Lê definições de ER de um arquivo.
 * 2. Usa RegexToDfaConverter para criar um AFD para cada ER.
 * 3. Armazena todos os AFDs individuais.
 */
@Data
public class LexerGenerator {

    private final RegexToDfaConverter dfaConverter;
    private final Map<String, DFA> tokenDfas;
    private NFA combinedNfa;
    private final Map<String, String> nfaFinalStateToTokenMap;
    private DFA finalDfa;
    private final Map<String, String> dfaFinalStateToTokenMap;
    private final Map<String, String> minimizedFinalStateToTokenMap;

    public LexerGenerator() {
        this.dfaConverter = new RegexToDfaConverter();
        this.tokenDfas = new LinkedHashMap<>(); // LinkedHashMap preserva a ordem de prioridade
        this.nfaFinalStateToTokenMap = new HashMap<>();
        this.dfaFinalStateToTokenMap = new HashMap<>();
        this.minimizedFinalStateToTokenMap = new HashMap<>();
    }

    public Lexer generate(String filename) {
        this.buildIndividualDfas(filename);
        this.combineAutomata();
        this.determinize();
        this.minimizeFinalDFA();

        AutomataUtils.printLexicalAnalysisTable(
                this.finalDfa,
                this.minimizedFinalStateToTokenMap,
                "Tabela de Análise Léxica do AFD Final Minimizado",
                "lexical_analysis_table_minimized");

        return new Lexer(this.finalDfa, this.minimizedFinalStateToTokenMap);
    }

    /**
     * Etapa 1: Carrega e constrói todos os AFDs individuais.
     */
    public void buildIndividualDfas(String definitionsFilePath) {
        System.out.println("Iniciando construção de AFDs individuais...");

        // --- 1. Lê o arquivo de definições ---
        Map<String, List<RegexToken>> definitions;
        try {
            definitions = ERFileParser.parse(definitionsFilePath);
        } catch (IOException | IllegalArgumentException e) {
            System.err.println("Falha ao ler o arquivo de definições: " + e.getMessage());
            return;
        }

        // --- 2. Constrói um AFD para cada definição ---
        for (Map.Entry<String, List<RegexToken>> entry : definitions.entrySet()) {
            String tokenName = entry.getKey();
            List<RegexToken> regex = entry.getValue();

            System.out.println("\n... Processando token: " + tokenName + " (" + regex + ")");

            try {
                // 3. Converte ER -> AFD (via Aho)
                DFA dfa = dfaConverter.convert(regex);

                // 4. Minimiza AFD
                DFA minimizedDFA = Minimizer.minimizeIndividualDFA(dfa);

                this.tokenDfas.put(tokenName, minimizedDFA);
                AutomataUtils.printDFA(minimizedDFA,
                        "AFD minimizado para '" + tokenName + "'",
                        "dfa_" + tokenName);

            } catch (Exception e) {
                System.err.println("  [ERRO] Falha ao converter regex para '" + tokenName + "': " + e.getMessage());
                e.printStackTrace();
            }
        }

        System.out.println("\nConstrução de AFDs individuais concluída.");
    }

    /**
     * Etapa 2: Combina todos os AFDs individuais em um único AFND.
     */
    public void combineAutomata() {
        if (tokenDfas.isEmpty()) {
            System.out.println("Nenhum AFD individual foi construído. Execute buildIndividualDfas() primeiro.");
            return;
        }
        System.out.println("\nIniciando união de autômatos...");

        // --- 1. Inicializa o novo AFND ---
        Set<String> nfaStates = new HashSet<>();
        Set<String> nfaAlphabet = new HashSet<>();
        Map<String, Map<String, Set<String>>> nfaTransitions = new HashMap<>();
        Set<String> nfaFinalStates = new HashSet<>();

        // --- 2. Cria o novo estado inicial global ---
        String nfaStartState = "N0"; // "N" de NFA
        nfaStates.add(nfaStartState);
        nfaTransitions.put(nfaStartState, new HashMap<>());

        // --- 3. Itera e mescla cada AFD ---
        for (Map.Entry<String, DFA> entry : tokenDfas.entrySet()) {
            String tokenName = entry.getKey();
            DFA dfa = entry.getValue();

            // Adiciona o alfabeto do AFD ao alfabeto global
            nfaAlphabet.addAll(dfa.alphabet());

            // --- 4. Renomeia estados para evitar colisões ---
            // Ex: "S0" do "id" vira "id_S0"
            for (String dfaState : dfa.states()) {
                String newStateName = tokenName + "_" + dfaState;
                nfaStates.add(newStateName);
                nfaTransitions.put(newStateName, new HashMap<>());

                // --- 5. Adiciona a e-transição do início global ---
                if (dfaState.equals(dfa.startState())) {
                    nfaTransitions.get(nfaStartState)
                            .computeIfAbsent(null, k -> new HashSet<>()) // 'null' é épsilon
                            .add(newStateName);
                }

                // --- 6. Mapeia o estado final renomeado ao seu token ---
                if (dfa.finalStates().contains(dfaState)) {
                    nfaFinalStates.add(newStateName);
                    // Armazena qual token este estado reconhece
                    nfaFinalStateToTokenMap.put(newStateName, tokenName);
                }
            }

            // --- 7. Copia as transições (com estados renomeados) ---
            for (Map.Entry<String, Map<String, String>> transEntry : dfa.transitionTable().entrySet()) {
                String dfaOrigin = transEntry.getKey();
                Map<String, String> dfaTargets = transEntry.getValue();

                String nfaOrigin = tokenName + "_" + dfaOrigin;
                Map<String, Set<String>> nfaTargets = nfaTransitions.get(nfaOrigin);

                for (Map.Entry<String, String> targetEntry : dfaTargets.entrySet()) {
                    String symbol = targetEntry.getKey();
                    String dfaTarget = targetEntry.getValue();
                    String nfaTarget = tokenName + "_" + dfaTarget;

                    // Adiciona a transição (não-épsilon)
                    nfaTargets.computeIfAbsent(symbol, k -> new HashSet<>()).add(nfaTarget);
                }
            }
        }

        this.combinedNfa = new NFA(
                nfaStates,
                nfaAlphabet,
                nfaTransitions,
                nfaStartState,
                nfaFinalStates
        );

        AutomataUtils.printNFA(this.combinedNfa, "União dos AFDs", "combined_nfa");

        System.out.println("AFND combinado criado com " + nfaStates.size() + " estados.");
        System.out.println("Estados finais mapeados para tokens: " + nfaFinalStateToTokenMap.size());
    }

    public void determinize() {
        if (combinedNfa == null) {
            System.out.println("AFND combinado não existe. Execute combineAutomata() primeiro.");
            return;
        }
        System.out.println("\nIniciando determinização ...");

        // --- 1. Calcula o Alfabeto Disjunto ---
        // Isso resolve o problema de conflito entre "1" e "[0-9]"
        Map<String, Set<Character>> disjointAlphabet = CharSetUtils.computeDisjointSets(combinedNfa.alphabet());

        System.out.println("Alfabeto Refinado (" + disjointAlphabet.size() + " símbolos): " + disjointAlphabet.keySet());

        Map<String, Map<String, String>> dfaTransitionTable = new HashMap<>();
        Set<String> dfaFinalStates = new HashSet<>();
        Map<Set<String>, String> dfaStateSets = new LinkedHashMap<>();
        Queue<Set<String>> workQueue = new LinkedList<>();

        this.dfaFinalStateToTokenMap.clear();

        Set<String> dfaStartSet = eClosure(Set.of(combinedNfa.startState()));
        String dfaStartStateName = "D0";
        dfaStateSets.put(dfaStartSet, dfaStartStateName);
        workQueue.add(dfaStartSet);
        int dfaStateCounter = 1;

        while (!workQueue.isEmpty()) {
            Set<String> currentNfaStates = workQueue.poll();
            String currentDfaStateName = dfaStateSets.get(currentNfaStates);
            dfaTransitionTable.put(currentDfaStateName, new HashMap<>());

            String highestPriorityToken = null;
            searchLoop:
            for (String tokenName : tokenDfas.keySet()) {
                for (String nfaState : currentNfaStates) {
                    String nfaStateToken = nfaFinalStateToTokenMap.get(nfaState);
                    if (nfaStateToken != null && nfaStateToken.equals(tokenName)) {
                        highestPriorityToken = tokenName;
                        break searchLoop; // Escolhe o primeiro token encontrado (maior prioridade)
                    }
                }
            }
            if (highestPriorityToken != null) {
                dfaFinalStates.add(currentDfaStateName);
                dfaFinalStateToTokenMap.put(currentDfaStateName, highestPriorityToken);
            }

            // --- Transições usando o ALFABETO DISJUNTO ---
            // Iteramos sobre os novos símbolos gerados (ex: "{1}", "{0}", "{2..9}")
            for (Map.Entry<String, Set<Character>> entry : disjointAlphabet.entrySet()) {
                String newSymbolLabel = entry.getKey();
                Set<Character> charSet = entry.getValue();

                // Escolhe um caractere representativo do conjunto para testar as transições
                Character representative = charSet.iterator().next();

                // Calcula o move() baseando-se nas transições originais do NFA
                Set<String> moveSet = move(currentNfaStates, representative);

                if (moveSet.isEmpty()) continue;

                Set<String> targetNfaStates = eClosure(moveSet);
                String targetDfaStateName;

                if (!dfaStateSets.containsKey(targetNfaStates)) {
                    targetDfaStateName = "D" + (dfaStateCounter++);
                    dfaStateSets.put(targetNfaStates, targetDfaStateName);
                    workQueue.add(targetNfaStates);
                } else {
                    targetDfaStateName = dfaStateSets.get(targetNfaStates);
                }

                // Adiciona a transição usando o NOVO rótulo disjunto
                dfaTransitionTable.get(currentDfaStateName).put(newSymbolLabel, targetDfaStateName);
            }
        }

        this.finalDfa = new DFA(
                new HashSet<>(dfaStateSets.values()),
                disjointAlphabet.keySet(),
                dfaTransitionTable,
                dfaStartStateName,
                dfaFinalStates
        );

        AutomataUtils.printDFA(
                this.finalDfa,
                "Autômato Determinístico Final (AFD)",
                "final_dfa_before_minimization");
        AutomataUtils.printLexicalAnalysisTable(
                this.finalDfa,
                this.dfaFinalStateToTokenMap,
                "Tabela de Análise Léxica do AFD Final Antes da Minimização",
                "lexical_analysis_table_before_minimization");

        System.out.println("Determinização concluída.");
    }

    private Set<String> move(Set<String> nfaStates, Character representative) {
        Set<String> reachableStates = new HashSet<>();

        for (String state : nfaStates) {
            Map<String, Set<String>> transitions = combinedNfa.transitionTable().get(state);
            if (transitions == null) continue;

            // Verifica TODAS as transições saindo deste estado
            for (Map.Entry<String, Set<String>> entry : transitions.entrySet()) {
                String nfaSymbol = entry.getKey();
                if (nfaSymbol == null) continue; // Ignora Epsilon

                // Parseia o símbolo original do NFA (ex: "[0-9]")
                Set<Character> allowedChars = CharSetUtils.parseSymbol(nfaSymbol);

                // Se o nosso caractere representativo (ex: '1') é aceito por essa transição (ex: [0-9])
                if (allowedChars.contains(representative)) {
                    reachableStates.addAll(entry.getValue());
                }
            }
        }
        return reachableStates;
    }

    private Set<String> eClosure(Set<String> nfaStates) {
        Set<String> closure = new HashSet<>(nfaStates);
        Stack<String> stack = new Stack<>();
        stack.addAll(nfaStates);

        while (!stack.isEmpty()) {
            String currentState = stack.pop();
            Map<String, Set<String>> transitions = combinedNfa.transitionTable().get(currentState);

            // Verifica se há transições épsilon (chave 'null')
            if (transitions != null && transitions.containsKey(null)) {
                for (String targetState : transitions.get(null)) {
                    if (closure.add(targetState)) { // Se 'add' retornar true, é um novo estado
                        stack.push(targetState);
                    }
                }
            }
        }
        return closure;
    }

    /**
     * Etapa 4: (Item b) Minimização de Autômatos
     * Minimiza o 'finalDfa' separando estados finais por TOKEN.
     */
    public void minimizeFinalDFA() {
        if (finalDfa == null) {
            System.out.println("AFD final não existe. Execute determinize() primeiro.");
            return;
        }
        System.out.println("\nIniciando minimização do AFD final...");

        // --- 1. Partição Inicial (P0) ---
        Set<Set<String>> partitions = Minimizer.createPartitionsWithNonFinalStates(this.finalDfa);

        // --- 1b. Grupos dos Finais (Separados por Token) ---
        // Agrupa estados finais pelo token que eles representam
        Map<String, Set<String>> finalStatesByToken = new HashMap<>();

        for (String finalState : finalDfa.finalStates()) {
            String tokenType = dfaFinalStateToTokenMap.get(finalState);

            finalStatesByToken.computeIfAbsent(tokenType, k -> new HashSet<>()).add(finalState);
        }

        // Adiciona cada grupo de token como uma partição separada
        partitions.addAll(finalStatesByToken.values());

        System.out.println("Partições iniciais criadas (separadas por token): " + partitions.size());

        // --- 2. Refinamento Iterativo (P1...Pk) ---
        partitions = Minimizer.performMinimization(this.finalDfa, partitions);

        // --- 3. Reconstrução do AFD Minimizado ---
        this.finalDfa = Minimizer.reconstructMinimizedDfa(this.finalDfa, partitions, true,
                this.dfaFinalStateToTokenMap, this.minimizedFinalStateToTokenMap, "M");

        System.out.println("Minimização do AFD final concluída.");
    }


}
