package com.lexgen.synt;

import com.lexgen.core.Production;
import lombok.Getter;

public record LR0Item(Production production, int dotPosition) {


    /**
     * Retorna o símbolo após o ponto (o próximo símbolo esperado).
     * Retorna null se o ponto estiver no final (item de redução).
     */
    public String getNextSymbol() {
        if (dotPosition >= production.body().size()) {
            return null;
        }
        String s = production.body().get(dotPosition);
        // Tratamento especial para epsilon explícito:
        // Se a produção é A -> &, o ponto tecnicamente já passou por ele.
        if (s.equals("&")) return null;
        return s;
    }

    /**
     * Cria um novo item com o ponto avançado em uma posição.
     * Ex: E -> E . + T  avança para  E -> E + . T
     */
    public LR0Item advance() {
        if (dotPosition >= production.body().size()) {
            throw new IllegalStateException("Não é possível avançar um item finalizado.");
        }
        // Se o atual é epsilon, avançar significa ir para o final
        String current = production.body().get(dotPosition);
        if (current.equals("&")) {
            return new LR0Item(production, dotPosition + 1);
        }
        return new LR0Item(production, dotPosition + 1);
    }

    /**
     * Verifica se o item é uma redução (ponto no final).
     * Ex: E -> E + T .  ou  E -> & .
     */
    public boolean isReduce() {
        // Se o corpo é "&", qualquer posição (0 ou 1) é reduce,
        // mas a convenção padrão é A -> . representa o reduce de A -> &
        if (production.isEpsilon()) return true;
        return dotPosition >= production.body().size();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(production.head()).append(" ::= ");
        var body = production.body();
        for (int i = 0; i < body.size(); i++) {
            if (i == dotPosition) sb.append("· "); // Ponto
            sb.append(body.get(i)).append(" ");
        }
        if (dotPosition == body.size()) sb.append("·"); // Ponto no final
        return sb.toString().trim();
    }

}