package com.lexgen.core;

import lombok.Data;

import java.util.*;

@Data
public class Grammar {
    private final List<Production> productions;
    private final Set<String> nonTerminals;
    private final Set<String> terminals;
    private String startSymbol;

    public Grammar() {
        this.productions = new ArrayList<>();
        this.nonTerminals = new LinkedHashSet<>(); // Linked para preservar ordem de descoberta
        this.terminals = new HashSet<>();
    }

    public void addProduction(String head, List<String> body) {
        if (productions.isEmpty()) {
            startSymbol = head; // A primeira produção define o símbolo inicial
        }

        nonTerminals.add(head);
        productions.add(new Production(head, body));

        // Por enquanto, adicionamos tudo do corpo como terminais potenciais.
        // Depois, faremos uma limpeza (o que estiver em nonTerminals não é terminal).
        terminals.addAll(body);
    }

    /**
     * Deve ser chamado após adicionar todas as produções para limpar os conjuntos.
     */
    public void finalizeGrammar() {
        terminals.removeAll(nonTerminals);
        terminals.remove("&");// Epsilon não é terminal nem não-terminal, é especial
    }

    public List<Production> getProductionsFor(String nonTerminal) {
        List<Production> list = new ArrayList<>();
        for (Production p : productions) {
            if (p.head().equals(nonTerminal)) {
                list.add(p);
            }
        }
        return list;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Terminais: ").append(terminals).append("\n");
        sb.append("Não-Terminais: ").append(nonTerminals).append("\n");
        sb.append("Inicial: ").append(startSymbol).append("\n");
        sb.append("Produções:\n");
        for (Production p : productions) {
            sb.append("  ").append(p).append("\n");
        }
        return sb.toString();
    }
}