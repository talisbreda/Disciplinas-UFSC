public class Aresta {
    final Vertice v1;
    final Vertice v2;
    final double peso;

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
            return (a.v1.equals(this.v1) && a.v2.equals(this.v2));
        } else {
            return false;
        }
    }
}
