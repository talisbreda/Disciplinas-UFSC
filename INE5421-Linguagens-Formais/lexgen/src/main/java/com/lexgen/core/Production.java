package com.lexgen.core;

import lombok.Getter;

import java.util.List;

/**
 * @param head Lado esquerdo (Não-terminal)
 * @param body Lado direito (Símbolos)
 */
public record Production(String head, List<String> body) {

    // Útil para verificar se é uma produção vazia (epsilon)
    public boolean isEpsilon() {
        return body.size() == 1 & body.get(0).equals("&"); // Assumindo '&' como símbolo de vazio
    }

    @Override
    public String toString() {
        return head + " ::= " + String.join(" ", body);
    }

}
