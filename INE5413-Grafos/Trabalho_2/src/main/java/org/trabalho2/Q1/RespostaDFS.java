package org.trabalho2.Q1;

import org.trabalho2.Grafo.Vertice;

import java.util.List;

public class RespostaDFS {
    List<Boolean> visitados;
    List<Integer> tempos;
    List<Integer> temposFinais;
    List<Vertice> antecessores;
    public RespostaDFS(
            List<Boolean> visitados,
            List<Integer> tempos,
            List<Integer> temposFinais,
            List<Vertice> antecessores
    ) {
        this.visitados = visitados;
        this.tempos = tempos;
        this.temposFinais = temposFinais;
        this.antecessores = antecessores;
    }
}
