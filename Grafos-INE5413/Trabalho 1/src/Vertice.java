import java.util.*;

public class Vertice {
    int index;
    String rotulo;
    Set<Aresta> arestas;

    public Vertice(int index, String rotulo) {
        this.index = index;
        this.rotulo = rotulo;
        this.arestas = new LinkedHashSet<>();
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
}