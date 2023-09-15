import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class BuscaLargura {
    public static void run(String arquivo, int index) {
        Grafo g = new Grafo();
        g.lerArquivo(arquivo);
        busca(g, index);
    }

    private static void busca(Grafo g, int index) {
        List<Vertice> nivelAtual = new ArrayList<Vertice>();
        List<Vertice> proxNivel = new ArrayList<Vertice>();
        List<Vertice> visitados = new ArrayList<Vertice>();
        nivelAtual.add(g.getVertices().get(index-1));
        visitados.add(g.getVertices().get(index-1));
        int nivel = 0;
        while (!nivelAtual.isEmpty()) {
            printNivel(nivel, nivelAtual);
            for (Vertice v : nivelAtual) {
                Set<Aresta> arestas = v.arestas;
                for (Aresta a : arestas) {
                    if (!visitados.contains(a.v2)) {
                        proxNivel.add(a.v2);
                        visitados.add(a.v2);
                    }
                }
            }
            nivelAtual = proxNivel;
            proxNivel = new ArrayList<Vertice>();
            nivel++;
        }
    }

    private static void printNivel(int nivel, List<Vertice> lista) {
        StringBuilder sb = new StringBuilder();
        sb.append("Nível " + nivel + ": ");
        for (Vertice v : lista) {
            sb.append(v.index + ", ");
        }
        System.out.println(sb.toString().substring(0, sb.length() - 2));
    }
}
