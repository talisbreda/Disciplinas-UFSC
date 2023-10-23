package org.trabalho2.Grafo;

public class Aresta {
    public final Vertice v1;
    public final Vertice v2;
    public final double peso;

    public Aresta(Vertice v1, Vertice v2) {
        this.v1 = v1;
        this.v2 = v2;
        this.peso = 1.0;
    }

    public Aresta(Vertice v1, Vertice v2, double peso) {
        this.v1 = v1;
        this.v2 = v2;
        this.peso = peso;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Aresta a) {
            return (a.v1.equals(this.v1) && a.v2.equals(this.v2)) ||
                   (a.v1.equals(this.v2) && a.v2.equals(this.v1));
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        int result = 17;

        int a = 31 * result + v1.hashCode();
        int b = 31 * result + v2.hashCode();

        return result * a * b;
    }
}
