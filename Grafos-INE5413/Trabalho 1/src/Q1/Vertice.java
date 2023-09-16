package Q1;

import java.util.*;

public class Vertice {
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