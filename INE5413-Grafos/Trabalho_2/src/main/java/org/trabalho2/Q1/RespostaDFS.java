package org.trabalho2.Q1;

import org.trabalho2.Grafo.Vertice;

import java.util.List;

public class RespostaDFS {
    List<Boolean> visitados;
    List<Integer> temposEntrada;
    List<Integer> temposFinais;
    List<Vertice> antecessores;
    int tempo;

    public RespostaDFS(
            List<Boolean> visitados,
            List<Integer> temposEntrada,
            List<Integer> temposFinais,
            List<Vertice> antecessores,
            int tempo
    ) {
        this.visitados = visitados;
        this.temposEntrada = temposEntrada;
        this.temposFinais = temposFinais;
        this.antecessores = antecessores;
        this.tempo = tempo;
    }
}
