package com.lexgen.synt;

import com.lexgen.core.Grammar;
import com.lexgen.core.Production;
import com.lexgen.utils.SyntacticUtils;
import lombok.Getter;

import java.util.*;

@Getter
public class FirstFollow {

    private final Grammar grammar;
    private final Map<String, Set<String>> firstSets;
    private final Map<String, Set<String>> followSets;

    // Constantes para facilitar
    public static final String EPSILON = "&";
    public static final String EOF = "$"; // Marcador de fim de arquivo (Follow)

    public FirstFollow(Grammar grammar) {
        this.grammar = grammar;
        this.firstSets = new HashMap<>();
        this.followSets = new HashMap<>();

        initialize();
        computeFirst();
        computeFollow();
        SyntacticUtils.printFirstFollow(this, grammar);
    }

    private void initialize() {
        // Inicializa conjuntos vazios para todos os Não-Terminais
        for (String nt : grammar.getNonTerminals()) {
            firstSets.put(nt, new HashSet<>());
            followSets.put(nt, new HashSet<>());
        }

        // Inicializa First para Terminais: First(a) = {a}
        for (String t : grammar.getTerminals()) {
            firstSets.put(t, new HashSet<>(Collections.singletonList(t)));
        }
        // First(&) = {&}
        firstSets.put(EPSILON, new HashSet<>(Collections.singletonList(EPSILON)));
    }

    /**
     * Algoritmo para cálculo do conjunto FIRST.
     * Executa iterativamente até que nenhum conjunto sofra alteração.
     */
    private void computeFirst() {
        System.out.println("Calculando conjuntos FIRST...");
        boolean changed = true;

        while (changed) {
            changed = false;

            for (Production p : grammar.getProductions()) {
                String head = p.head();
                List<String> body = p.body();
                Set<String> headFirst = firstSets.get(head);

                // Calcula o First da parte direita (corpo) da produção
                // Regra: First(Y1 Y2 ...)
                int sizeBefore = headFirst.size();

                computeFirstOfSequence(body, headFirst);

                if (headFirst.size() > sizeBefore) {
                    changed = true;
                }
            }
        }

        System.out.println("Conjuntos FIRST calculados.");
    }

    /**
     * Algoritmo para cálculo do conjunto FOLLOW.
     * Executa após o cálculo do FIRST.
     */
    private void computeFollow() {
        System.out.println("Calculando conjuntos FOLLOW...");
        // Regra 1: Follow(S) contém $ (onde S é o símbolo inicial)
        String startSymbol = grammar.getStartSymbol();
        if (startSymbol != null) {
            followSets.get(startSymbol).add(EOF);
        }

        boolean changed = true;
        while (changed) {
            changed = false;

            for (Production p : grammar.getProductions()) {
                String A = p.head();
                List<String> body = p.body();

                // Para cada produção A -> X1 X2 ... Xn
                // Precisamos atualizar o Follow dos NÃO-TERMINAIS no corpo

                for (int i = 0; i < body.size(); i++) {
                    String symbol = body.get(i);

                    // Só calculamos Follow para Não-Terminais
                    if (!grammar.getNonTerminals().contains(symbol)) {
                        continue;
                    }

                    Set<String> symbolFollow = followSets.get(symbol);
                    int sizeBefore = symbolFollow.size();

                    // Olhamos para o que vem DEPOIS de 'symbol' (Beta)
                    // A -> alpha B beta
                    List<String> beta = body.subList(i + 1, body.size());

                    // Calcula First(beta)
                    Set<String> firstOfBeta = computeFirstOfSequence(beta, new HashSet<>());

                    // Regra 2: Adiciona First(beta) - {&} ao Follow(symbol)
                    for (String f : firstOfBeta) {
                        if (!f.equals(EPSILON)) {
                            symbolFollow.add(f);
                        }
                    }

                    // Regra 3: Se beta é & ou First(beta) contém &,
                    // então tudo que está em Follow(A) vai para Follow(symbol)
                    if (firstOfBeta.contains(EPSILON) || beta.isEmpty()) {
                        symbolFollow.addAll(followSets.get(A));
                    }

                    if (symbolFollow.size() > sizeBefore) {
                        changed = true;
                    }
                }
            }
        }
        System.out.println("Conjuntos FOLLOW calculados.");
    }

    /**
     * Método auxiliar: Calcula o First de uma sequência de símbolos.
     * Útil para o algoritmo do Follow (First(beta)).
     */
    public Set<String> computeFirstOfSequence(List<String> sequence, Set<String> result) {
        boolean allNullable = true;

        for (String symbol : sequence) {
            Set<String> f = firstSets.get(symbol);
            if (f == null) f = Collections.singleton(symbol); // Terminal não mapeado

            for (String s : f) {
                if (!s.equals(EPSILON)) result.add(s);
            }

            if (!f.contains(EPSILON)) {
                allNullable = false;
                break;
            }
        }

        if (allNullable) {
            result.add(EPSILON);
        }

        return result;
    }


    public Set<String> getFirst(String symbol) {
        return firstSets.getOrDefault(symbol, Collections.emptySet());
    }

    public Set<String> getFollow(String nonTerminal) {
        return followSets.getOrDefault(nonTerminal, Collections.emptySet());
    }

}
