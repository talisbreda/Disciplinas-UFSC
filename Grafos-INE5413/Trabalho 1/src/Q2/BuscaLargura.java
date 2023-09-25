package Q2;

import Q1.Grafo;
import Q1.Vertice;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class BuscaLargura {
    public static void run(String arquivo, int index) {
        Grafo g = new Grafo();
        g.lerArquivo(arquivo);
        System.out.println("Questão 2 - Busca em Largura");
        System.out.println("------------------------------------------------------------------------------");
        busca(g, index);
        System.out.println("------------------------------------------------------------------------------\n");
    }

    private static void busca(Grafo g, int index) {
        List<Vertice> nivelAtual = new ArrayList<>();
        List<Vertice> proxNivel = new ArrayList<>();
        Set<Vertice> visitados = new HashSet<>();
        nivelAtual.add(g.getVertices().get(index-1));
        visitados.add(g.getVertices().get(index-1));
        int nivel = 0;
        while (!nivelAtual.isEmpty()) {
            printNivel(nivel, nivelAtual);
            for (Vertice v : nivelAtual) {
                Set<Vertice> vizinhos = v.arestas.keySet();
                for (Vertice vizinho : vizinhos) {
                    if (!visitados.contains(vizinho)) {
                        proxNivel.add(vizinho);
                        visitados.add(vizinho);
                    }
                }
            }
            nivelAtual = proxNivel;
            proxNivel = new ArrayList<>();
            nivel++;
        }
    }

    private static void printNivel(int nivel, List<Vertice> lista) {
        StringBuilder sb = new StringBuilder();
        sb.append("Nível ").append(nivel).append(": ");
        for (Vertice v : lista) {
            sb.append(v.index).append(", ");
        }
        System.out.println(sb.substring(0, sb.length() - 2));
    }
}
