package org.trabalho2.Q2;

import org.trabalho2.Grafo.Vertice;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class RespostaDFS_OT {
    List<Boolean> visitados;
    List<Integer> temposEntrada;
    List<Integer> temposFinais;
    LinkedList<Vertice> ordem;
    int tempo;

    public RespostaDFS_OT(
            List<Boolean> visitados,
            List<Integer> temposEntrada,
            List<Integer> temposFinais,
            LinkedList<Vertice> ordem,
            int tempo
    ) {
        this.visitados = visitados;
        this.temposEntrada = temposEntrada;
        this.temposFinais = temposFinais;
        this.ordem = ordem;
        this.tempo = tempo;
    }
}
