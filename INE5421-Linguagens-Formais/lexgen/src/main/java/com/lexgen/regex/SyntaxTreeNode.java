package com.lexgen.regex;

import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Data
class SyntaxTreeNode {
    public enum NodeType {
        LEAF,     // Um literal ou '#'
        OR,       // Operador |
        CONCAT,   // Operador .
        STAR,     // Operador *
        PLUS,     // Operador +
        QMARK     // Operador ?
    }

    private final NodeType type;
    private final String value;     // O caractere literal (ex: 'a') ou '#'
    private final int position;    // A posição única (para followpos)

    private SyntaxTreeNode left;
    private SyntaxTreeNode right;

    // Funções calculadas por Aho
    private boolean nullable;
    private final Set<Integer> firstpos;
    private final Set<Integer> lastpos;

    // Construtor para nós binários (operadores)
    public SyntaxTreeNode(NodeType type, SyntaxTreeNode left, SyntaxTreeNode right) {
        this.type = type;
        this.value = null;
        this.position = -1;
        this.left = left;
        this.right = right;
        this.firstpos = new HashSet<>();
        this.lastpos = new HashSet<>();
    }

    // Construtor para nós unários (operadores)
    public SyntaxTreeNode(NodeType type, SyntaxTreeNode left) {
        this(type, left, null);
    }

    // Construtor para nós folha (literais)
    public SyntaxTreeNode(String value, int position) {
        this.type = NodeType.LEAF;
        this.value = value;
        this.position = position;
        this.left = null;
        this.right = null;
        this.firstpos = new HashSet<>();
        this.lastpos = new HashSet<>();
    }

    public void addToFirstPos(Set<Integer> positions) {
        this.firstpos.addAll(positions);
    }

    public void addToLastPos(Set<Integer> positions) {
        this.lastpos.addAll(positions);
    }

    @Override
    public String toString() {
        if (type == NodeType.LEAF) return value + "(" + position + ")";
        return type.toString();
    }
}
