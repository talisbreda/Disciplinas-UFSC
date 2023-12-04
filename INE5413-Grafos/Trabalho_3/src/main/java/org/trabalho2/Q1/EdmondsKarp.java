package org.trabalho2.Q1;

import org.trabalho2.Grafo.Aresta;
import org.trabalho2.Grafo.GrafoDirigido;
import org.trabalho2.Grafo.Vertice;

import java.util.*;

public class EdmondsKarp {
    public static void run(String path) {
        GrafoDirigido g = new GrafoDirigido();
        g.lerArquivo(path);
        Vertice s = g.getVertices().get(0);
        Vertice t = g.getVertices().get(g.qtdVertices() - 1);
        System.out.println("Questão 1 - Edmonds-Karp");
        System.out.println("------------------------------------------------------------------------");
        fordFulkerson(g, s, t);
        System.out.println("------------------------------------------------------------------------\n");
    }

    private static void fordFulkerson(GrafoDirigido g, Vertice s, Vertice t) {
        double F = 0;
        List<Vertice> p = bfs(g, s, t);
        while (p != null) {
            double fp = menorAresta(g, p);
            F += fp;

            List<Aresta> arestas = new ArrayList<>();
            for (int i = 0; i < p.size() - 1; i++) {
                Vertice u = p.get(i);
                Vertice v = p.get(i + 1);
                arestas.add(new Aresta(u, v, g.peso(u.index, v.index)));
            }
            for (Aresta a : arestas) {
                g.atualizaPeso(a.v1, a.v2, g.peso(a.v1.index, a.v2.index) - fp);
                g.atualizaPeso(a.v2, a.v1, g.peso(a.v2.index, a.v1.index) + fp);
            }
            p = bfs(g, s, t);
        }
        System.out.println("Fluxo máximo: " + F);
    }

    private static double menorAresta(GrafoDirigido g, List<Vertice> p) {
        double menor = Double.MAX_VALUE;
        for (int i = 0; i < p.size() - 1; i++) {
            double peso = g.peso(p.get(i).index, p.get(i + 1).index);
            if (peso < menor) {
                menor = peso;
            }
        }
        return menor;
    }

    private static List<Vertice> bfs(GrafoDirigido g, Vertice s, Vertice t) {
        List<Boolean> visitados = new ArrayList<>(Collections.nCopies(g.qtdVertices(), false));
        List<Vertice> ancestrais = new ArrayList<>(Collections.nCopies(g.qtdVertices(), null));
        visitados.set(s.index, true);
        Queue<Vertice> Q = new LinkedList<>();
        Q.add(s);
        while (!Q.isEmpty()) {
            Vertice u = Q.poll();
            for (Vertice v : u.arestas.keySet()) {
                if (!visitados.get(v.index) && u.arestas.get(v) > 0) {
                    visitados.set(v.index, true);
                    ancestrais.set(v.index, u);

                    if (v == t) {
                        List<Vertice> p = new ArrayList<>();
                        p.add(t);
                        Vertice w = t;
                        while (w != s) {
                            w = ancestrais.get(w.index);
                            p.add(w);
                        }
                        Collections.reverse(p);
                        return p;
                    }
                    Q.add(v);
                }
            }
        }
        return null;
    }
}
