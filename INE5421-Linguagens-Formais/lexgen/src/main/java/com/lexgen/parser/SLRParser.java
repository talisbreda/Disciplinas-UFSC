package com.lexgen.parser;

import com.lexgen.core.Grammar;
import com.lexgen.core.Production;
import com.lexgen.lexer.Token;
import com.lexgen.synt.SLRTable;
import com.lexgen.synt.SymbolTable;
import com.lexgen.utils.AutomataUtils;
import com.lexgen.utils.SyntacticUtils;

import java.util.*;

public class SLRParser {

    private final SLRTable table;
    private final Grammar grammar;
    private final SymbolTable symbolTable;

    public SLRParser(SLRTable table, Grammar grammar) {
        this.table = table;
        this.grammar = grammar;
        this.symbolTable = new SymbolTable();
    }

    /**
     * Executa a análise sintática sobre uma lista de tokens.
     */
    public void parse(List<Token> tokens) {
        Stack<Integer> stack = new Stack<>();
        stack.push(0); // Estado inicial é sempre 0

        Stack<String> symbolStack = new Stack<>();

        // Adiciona o marcador de fim de arquivo à lista de tokens
        List<Token> input = new ArrayList<>(tokens);
        input.add(new Token("$", "$"));

        int cursor = 0;

        StringBuilder sb = new StringBuilder();
        System.out.println("\n=== INÍCIO DA ANÁLISE SINTÁTICA ===");
        sb.append(String.format("%-30s | %-50s | %-30s | %-30s\n", "STACK", "SYMBOL", "INPUT", "ACTION"));
        sb.append("-".repeat(110));

        while (true) {
            int currentState = stack.peek();
            Token currentToken = input.get(cursor);

            String symbol = currentToken.tokenName(); // Do record Token(lexeme, tokenName)

            // Apenas para registro/impressão, pois a decisão sintática depende só do 'symbol'
            if (!symbol.equals("$")) {
                symbolTable.addOrGet(currentToken.lexeme(), symbol);
            }

            // Consulta a tabela SLR
            String action = table.getAction(currentState, symbol);

            // Formata output para debug
            String stackStr = stack.toString();
            String symbolStackStr = symbolStack.toString();
            String inputStr = currentToken.lexeme() + " (" + symbol + ")";
            sb.append(String.format("\n%-30s | %-80s | %-30s | %s",
                    stackStr.length() > 30 ? "..." + stackStr.substring(stackStr.length()-27) : stackStr,
                    symbolStackStr.length() > 80 ? "..." + symbolStackStr.substring(symbolStackStr.length()-77) : symbolStackStr,
                    inputStr,
                    (action == null ? "ERRO" : action)));

            if (action == null) {
                sb.append("\n");
                throw new RuntimeException("Erro Sintático! Estado " + currentState + ", Símbolo inesperado: " + currentToken);
            }

            // --- Tipos de Ação ---

            // 1. SHIFT (sN)
            if (action.startsWith("s")) {
                int nextState = Integer.parseInt(action.substring(1));
                stack.push(nextState);
                symbolStack.push(symbol);
                cursor++; // Avança a entrada
            }
            // 2. REDUCE (rN)
            else if (action.startsWith("r")) {
                int prodIndex = Integer.parseInt(action.substring(1));
                Production production = grammar.getProductions().get(prodIndex);

                // Regra: Desempilha |beta| estados (tamanho do corpo da produção)
                int symbolsToPop = production.isEpsilon() ? 0 : production.body().size();

                for (int i = 0; i < symbolsToPop; i++) {
                    stack.pop();
                    symbolStack.pop();
                }

                // Olha o topo da pilha (t)
                int topState = stack.peek();
                // Faz GOTO[t, A] (onde A é a cabeça da produção)
                String gotoAction = table.getAction(topState, production.head());

                if (gotoAction == null) {
                    sb.append("\n");
                    throw new RuntimeException("Erro de GOTO após redução! Tabela inconsistente.");
                }

                int gotoState = Integer.parseInt(gotoAction);
                stack.push(gotoState);

                symbolStack.push(production.head());

                sb.append("\t>> REDUCE: ").append(production);
            }
            // 3. ACCEPT (acc)
            else if (action.equals("acc")) {
                sb.append("\n=== SUCCESSO! A entrada foi aceita. ===");
                break;
            }
        }

        SyntacticUtils.printSymbolTable(symbolTable, "src/main/resources/output/final_symbol_table.txt");
        AutomataUtils.printToFile(sb, "slr_parse_table");

        System.out.println("=== FIM DA ANÁLISE SINTÁTICA ===\n");

    }
}
