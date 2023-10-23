package org.trabalho2.Grafo;

import java.util.*;
import java.lang.Comparable;

public class Vertice implements Comparable<Vertice> {
    public int index;
    public String rotulo;
    public Map<Vertice, Double> arestas;

    public Vertice(int index, String rotulo) {
        this.index = index;
        this.rotulo = rotulo;
        this.arestas = new HashMap<>();
    }

    public Vertice(int index) {
        this.index = index;
    }

    @Override
    public int compareTo(Vertice o) {
        return Integer.compare(this.index, o.index);
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Vertice v) {
            return (v.index == this.index);
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        int result = 37;

        result = 43 * result + index;

        return result;
    }
}