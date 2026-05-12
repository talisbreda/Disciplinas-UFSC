package com.lexgen.core;

import java.util.Map;
import java.util.Set;

public record DFA(
        Set<String> states,
        Set<String> alphabet,
        Map<String, Map<String, String>> transitionTable,
        String startState,
        Set<String> finalStates
) {}
