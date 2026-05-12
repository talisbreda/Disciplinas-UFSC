package com.lexgen.core;

import java.util.Map;
import java.util.Set;

/**
 * A Tabela de Transição usa 'null' como chave para transições-épsilon.
 * (EstadoOrigem -> (Símbolo -> Set<EstadoDestino>))
 */
public record NFA(
        Set<String> states,
        Set<String> alphabet,
        Map<String, Map<String, Set<String>>> transitionTable,
        String startState,
        Set<String> finalStates
) {}