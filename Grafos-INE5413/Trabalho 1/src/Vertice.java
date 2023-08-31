import java.util.HashMap;
import java.util.Map;

public class Vertice {
    int index;
    String rotulo;
    Map<Vertice, Double> arestas;

    public Vertice(int index, String rotulo) {
        this.index = index;
        this.rotulo = rotulo;
        this.arestas = new HashMap<Vertice, Double>();
    }
}