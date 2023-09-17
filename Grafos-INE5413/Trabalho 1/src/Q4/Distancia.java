package Q4;

import Q1.Vertice;

public class Distancia implements Comparable {
    public Vertice vertice;
    public double peso;

    public Distancia(Vertice v, double peso) {
        this.vertice = v;
        this.peso = peso;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Vertice v) {
            return (v.index == this.vertice.index);
        } else if (obj instanceof Distancia d) {
            return (d.vertice.index == this.vertice.index);
        }
        return false;
    }

    @Override
    public int hashCode() {
        int result = 41;

        result = 47 * result + vertice.index;

        return result;
    }

    @Override
    public int compareTo(Object o) {
        if (o instanceof Distancia d) {
            return Double.compare(this.peso, d.peso);
        }
        return 0;
    }
}
