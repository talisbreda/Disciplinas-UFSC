package org.trabalho2.Q1;

import org.trabalho2.Grafo.Vertice;

import java.util.List;
import java.util.PriorityQueue;

public class RespostaDFS {
    List<Boolean> visitados;
    List<Integer> temposEntrada;
    PriorityQueue<Tempo> temposFinais;
    List<Vertice> antecessores;
    int tempo;

    public RespostaDFS(
            List<Boolean> visitados,
            List<Integer> temposEntrada,
            PriorityQueue<Tempo> temposFinais,
            List<Vertice> antecessores,
            int tempo
    ) {
        this.visitados = visitados;
        this.temposEntrada = temposEntrada;
        this.temposFinais = temposFinais;
        this.antecessores = antecessores;
        this.tempo = tempo;
    }

    public void setTemposFinais(PriorityQueue<Tempo> temposFinais) {
        this.temposFinais = temposFinais;
    }
}
