import java.util.*;

public class CicloEuleriano {
    public static void run(String arquivo) {
        Grafo g = new Grafo();
        g.lerArquivo(arquivo);
        if (temCiclo(g)) {
            encontraCiclo(g);
        } else {
            System.out.println(0);
        }
    }

    private static boolean temCiclo(Grafo g) {
        List<Vertice> vertices = g.getVertices();
        for (Vertice v : vertices) {
            if (g.grau(v.index) % 2 != 0) return false;
        }
        return true;
    }

    private static void encontraCiclo(Grafo g) {
        LinkedHashSet<Aresta> visitados = new LinkedHashSet<>();
        Stack<Vertice> pilha = new Stack<>();
        List<Aresta> remover = new ArrayList<>();
        Stack<Aresta> caminho = new Stack<>();
        boolean continua = false;
        pilha.add(g.getVertices().get(0));
        while (!pilha.isEmpty()) {
            Vertice v = pilha.peek();
            Set<Aresta> arestas = v.arestas;
            for (Aresta a : arestas) {
                if (!visitados.contains(a)) {
                    visitados.add(a);
                    pilha.add(a.v2);
                    remover.forEach(visitados::remove);
                    remover.clear();
                    caminho.add(a);
                    continua = true;
                    break;
                }
                continua = false;
            }
            if (caminho.size() == g.getVertices().size()-1) {
                printCiclo(caminho);
                break;
            } else if (!continua) {
                remover.add(caminho.pop());
                pilha.pop();
            }
        }
    }

    private static void printCiclo(Stack<Aresta> arestas) {
        System.out.println(1);
        for (int i = 0; i < arestas.size(); i++) {
            System.out.print(arestas.get(i).v2.index);
            if (i < arestas.size() - 1) {
                System.out.print(", ");
            }
        }
    }

}
