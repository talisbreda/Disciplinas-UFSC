package org.trabalho2.Q1;

import org.trabalho2.Grafo.Vertice;

public class Tempo implements Comparable {
    Vertice vertice;
    int tempo;

    public Tempo(Vertice vertice, int tempo) {
        this.vertice = vertice;
        this.tempo = tempo;
    }

    @Override
    public int compareTo(Object obj) {
        if (obj instanceof Tempo t) {
            return Integer.compare(this.tempo, t.tempo);
        } else {
            return 0;
        }
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Tempo t) {
            return (t.tempo == this.tempo);
        } else {
            return false;
        }
    }
}
