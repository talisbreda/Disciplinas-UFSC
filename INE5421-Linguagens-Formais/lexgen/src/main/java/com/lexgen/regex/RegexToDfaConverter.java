package com.lexgen.regex;

import com.lexgen.core.DFA;
import com.lexgen.parser.RegexToken;
import com.lexgen.parser.RegexTokenType;
import com.lexgen.utils.CharSetUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;
import java.util.Stack;

public class RegexToDfaConverter {

    // --- Estruturas de Dados da ER ---
    private SyntaxTreeNode syntaxTreeRoot;
    private int nextPosition = 1;
    private Map<Integer, Set<Integer>> followPosTable;
    private Map<Integer, String> positionToChar;
    private final Set<String> alphabet = new HashSet<>();
    private final Map<RegexTokenType, Integer> precedence;

    /** Tabela de Transições: (EstadoOrigem -> (Símbolo -> EstadoDestino)) */
    private Map<String, Map<String, String>> transitionTable;

    /** Conjunto de nomes de estados finais (ex: "S1", "S3") */
    private Set<String> finalStates;

    /** Nome do estado inicial (será sempre "S0") */
    private String startState;

    /** Mapeia a definição do estado (conjunto de posições) ao seu nome */
    private Map<Set<Integer>, String> dfaStates;

    public RegexToDfaConverter() {
        precedence = new HashMap<>();
        precedence.put(RegexTokenType.LPAREN, 1);
        precedence.put(RegexTokenType.OR, 2);
        precedence.put(RegexTokenType.CONCAT, 3);
        precedence.put(RegexTokenType.QMARK, 4);
        precedence.put(RegexTokenType.STAR, 4);
        precedence.put(RegexTokenType.PLUS, 4);
    }

    /**
     * Ponto de entrada principal.
     */
    public DFA convert(List<RegexToken> tokens) {
        // Reinicializa o estado para uma nova conversão
        reset();

        List<RegexToken> augmentedTokens = addExplicitConcatAndEndMarker(tokens);
        List<RegexToken> postfixTokens = toPostfix(augmentedTokens);
        buildSyntaxTree(postfixTokens);
        computeTreeFunctions(syntaxTreeRoot);

        // Inicializa o followPosTable
        for (int i = 1; i < nextPosition; i++) {
            followPosTable.put(i, new HashSet<>());
        }
        computeFollowPos(syntaxTreeRoot);

        // Constrói as estruturas de dados do AFD
        return buildDFA();
    }

    /**
     * Reseta as estruturas de dados para uma nova conversão.
     */
    private void reset() {
        syntaxTreeRoot = null;
        nextPosition = 1;
        followPosTable = new HashMap<>();
        positionToChar = new HashMap<>();
        alphabet.clear();
        transitionTable = new HashMap<>();
        finalStates = new HashSet<>();
        dfaStates = new LinkedHashMap<>(); // Preserva a ordem de descoberta
        startState = null;
    }

    // --- Etapa 1: Pré-processamento ---

    private List<RegexToken> addExplicitConcatAndEndMarker(List<RegexToken> tokens) {
        List<RegexToken> result = new ArrayList<>();

        for (int i = 0; i < tokens.size(); i++) {
            RegexToken current = tokens.get(i);
            result.add(current);

            if (i + 1 < tokens.size()) {
                RegexToken next = tokens.get(i + 1);

                // Quando inserir '.' (CONCAT)?
                // (LITERAL ou CHAR_CLASS ou ')' ou '*' ou '+' ou '?')
                // seguido por
                // (LITERAL ou CHAR_CLASS ou '(')

                if (current.isConcatPreceded() && next.isConcatFollowed()) {
                    result.add(new RegexToken(RegexTokenType.CONCAT));
                }
            }
        }

        // Adiciona o marcador final
        result.add(new RegexToken(RegexTokenType.CONCAT));
        result.add(new RegexToken(RegexTokenType.LITERAL, CharSetUtils.END_MARKER));
        return result;
    }

    // --- Etapa 2: Conversão Pós-fixo ---

    private List<RegexToken> toPostfix(List<RegexToken> infixTokens) {
        List<RegexToken> postfix = new ArrayList<>();
        Stack<RegexToken> operatorStack = new Stack<>();

        for (RegexToken token : infixTokens) {
            switch (token.getType()) {
                case LITERAL:
                case CHAR_CLASS:
                    postfix.add(token);
                    break;
                case LPAREN:
                    operatorStack.push(token);
                    break;
                case RPAREN:
                    while (!operatorStack.isEmpty() && operatorStack.peek().getType() != RegexTokenType.LPAREN) {
                        postfix.add(operatorStack.pop());
                    }
                    operatorStack.pop(); // Remove o LPAREN
                    break;
                default: // É um operador (OR, CONCAT, STAR, PLUS, QMARK)
                    while (!operatorStack.isEmpty() &&
                            operatorStack.peek().getType() != RegexTokenType.LPAREN &&
                            precedence.get(token.getType()) <= precedence.get(operatorStack.peek().getType())) {
                        postfix.add(operatorStack.pop());
                    }
                    operatorStack.push(token);
                    break;
            }
        }

        while (!operatorStack.isEmpty()) {
            postfix.add(operatorStack.pop());
        }
        return postfix;
    }

    // --- Etapa 3: Construir Árvore de Sintaxe ---

    private void buildSyntaxTree(List<RegexToken> postfixTokens) {
        Stack<SyntaxTreeNode> stack = new Stack<>();
        positionToChar = new HashMap<>();

        for (RegexToken token : postfixTokens) {
            switch (token.getType()) {
                case LITERAL:
                case CHAR_CLASS:
                    String val = token.getValue();
                    SyntaxTreeNode node = new SyntaxTreeNode(val, nextPosition);
                    positionToChar.put(nextPosition, val);
                    if (!val.equals(CharSetUtils.END_MARKER)) {
                        alphabet.add(val);
                    }
                    stack.push(node);
                    nextPosition++; // Incrementa a posição global
                    break;
                case STAR:
                    stack.push(new SyntaxTreeNode(SyntaxTreeNode.NodeType.STAR, stack.pop()));
                    break;
                case PLUS:
                    stack.push(new SyntaxTreeNode(SyntaxTreeNode.NodeType.PLUS, stack.pop()));
                    break;
                case QMARK:
                    stack.push(new SyntaxTreeNode(SyntaxTreeNode.NodeType.QMARK, stack.pop()));
                    break;
                case OR:
                case CONCAT:
                    SyntaxTreeNode right = stack.pop();
                    SyntaxTreeNode left = stack.pop();
                    SyntaxTreeNode.NodeType nType = (token.getType() == RegexTokenType.OR) ?
                            SyntaxTreeNode.NodeType.OR :
                            SyntaxTreeNode.NodeType.CONCAT;
                    stack.push(new SyntaxTreeNode(nType, left, right));
                    break;
                default:
                    throw new IllegalArgumentException("Token pós-fixo inesperado: " + token.getType());
            }
        }
        syntaxTreeRoot = stack.pop();
    }

    // --- Etapa 4: Calcular Nullable, Firstpos, Lastpos ---

    private void computeTreeFunctions(SyntaxTreeNode node) {
        if (node == null) return;

        computeTreeFunctions(node.getLeft());
        computeTreeFunctions(node.getRight());

        switch (node.getType()) {
            case LEAF:
                node.setNullable(false);
                node.getFirstpos().add(node.getPosition());
                node.getLastpos().add(node.getPosition());
                break;
            case OR:
                node.setNullable(node.getLeft().isNullable() || node.getRight().isNullable());
                node.addToFirstPos(node.getLeft().getFirstpos());
                node.addToFirstPos(node.getRight().getFirstpos());
                node.addToLastPos(node.getLeft().getLastpos());
                node.addToLastPos(node.getRight().getLastpos());
                break;
            case CONCAT:
                node.setNullable(node.getLeft().isNullable() && node.getRight().isNullable());
                node.addToFirstPos(node.getLeft().getFirstpos());
                if (node.getLeft().isNullable()) {
                    node.addToFirstPos(node.getRight().getFirstpos());
                }
                node.addToLastPos(node.getRight().getLastpos());
                if (node.getRight().isNullable()) {
                    node.addToLastPos(node.getLeft().getLastpos());
                }
                break;
            case STAR, QMARK:
                node.setNullable(true);
                node.addToFirstPos(node.getLeft().getFirstpos());
                node.addToLastPos(node.getLeft().getLastpos());
                break;
            case PLUS:
                node.setNullable(node.getLeft().isNullable());
                node.addToFirstPos(node.getLeft().getFirstpos());
                node.addToLastPos(node.getLeft().getLastpos());
                break;
        }
    }

    // --- Etapa 5: Calcular FollowPos ---

    private void computeFollowPos(SyntaxTreeNode node) {
        if (node == null) return;

        computeFollowPos(node.getLeft());
        computeFollowPos(node.getRight());

        switch (node.getType()) {
            case CONCAT:
                // Regra: C1.C2 -> para i em lastpos(C1), followpos(i) += firstpos(C2)
                for (int i : node.getLeft().getLastpos()) {
                    followPosTable.get(i).addAll(node.getRight().getFirstpos());
                }
                break;
            case STAR:
            case PLUS:
                // Regra: C* ou C+ -> para i em lastpos(C), followpos(i) += firstpos(C)
                for (int i : node.getLastpos()) {
                    followPosTable.get(i).addAll(node.getFirstpos());
                }
                break;
            default:
                // LEAF, OR, QMARK não geram novas regras.
                break;
        }
    }

    // --- Etapa 6: Construir o AFD ---

    private DFA buildDFA() {
        Set<Integer> initialStateSet = syntaxTreeRoot.getFirstpos();
        int endPosition = nextPosition - 1; // Posição do '#'

        Queue<Set<Integer>> workQueue = new LinkedList<>();

        startState = "S0";
        dfaStates.put(initialStateSet, startState);
        workQueue.add(initialStateSet);

        int stateCounter = 1;

        while (!workQueue.isEmpty()) {
            Set<Integer> currentPosSet = workQueue.poll();
            String currentStateName = dfaStates.get(currentPosSet);

            if (currentPosSet.contains(endPosition)) {
                finalStates.add(currentStateName);
            }

            transitionTable.put(currentStateName, new HashMap<>());

            for (String symbol : alphabet) {
                Set<Integer> nextPosSet = new HashSet<>();
                for (int pos : currentPosSet) {
                    if (symbol.equals(positionToChar.get(pos))) {
                        nextPosSet.addAll(followPosTable.get(pos));
                    }
                }

                if (nextPosSet.isEmpty()) continue;

                String nextStateName;
                if (!dfaStates.containsKey(nextPosSet)) {
                    nextStateName = "S" + stateCounter++;
                    dfaStates.put(nextPosSet, nextStateName);
                    workQueue.add(nextPosSet);
                } else {
                    nextStateName = dfaStates.get(nextPosSet);
                }

                transitionTable.get(currentStateName).put(symbol, nextStateName);
            }
        }

        return new DFA(
                new HashSet<>(dfaStates.values()),
                new HashSet<>(alphabet),
                transitionTable,
                startState,
                finalStates
        );
    }
}
