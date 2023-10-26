package org.trabalho2.Q3;

import org.trabalho2.Grafo.Aresta;
import org.trabalho2.Grafo.Grafo;
import org.trabalho2.Grafo.Vertice;

import java.util.*;

public class Kruskal {
    public static void run(String path) {
         Grafo g = new Grafo();
         g.lerArquivo(path);
        System.out.println("Questão 3 - Kruskal");
        System.out.println("------------------------------------------------------------------------------");
         kruskal(g);
        System.out.println("------------------------------------------------------------------------------\n");
    }

    private static void kruskal(Grafo g) {
        Set<Aresta> arvoreMinima = new HashSet<>();
        List<Set<Vertice>> s = new ArrayList<>();
        for (Vertice v : g.getVertices()) {
            s.add(new HashSet<>(Collections.singletonList(v)));
        }
        List<Aresta> arestasOrdenadads = g.getArestas().stream().sorted().toList();
        for (Aresta a : arestasOrdenadads) {
            Vertice u = a.v1;
            Vertice v = a.v2;
            if (!s.get(u.index).equals(s.get(v.index))) {
                arvoreMinima.add(a);
                Set<Vertice> x = new HashSet<>(s.get(u.index));
                x.addAll(s.get(v.index));
                for (Vertice y : x) {
                    s.get(y.index).addAll(x);
                }
            }
        }
        printArvoreMinima(arvoreMinima);
    }

    private static void printArvoreMinima(Set<Aresta> arvoreMinima) {
        System.out.println("Arvore Minima:");
        StringBuilder sb = new StringBuilder();
        double sum = 0;
        for (Aresta a : arvoreMinima) {
            sum += a.peso;
            sb.append(a.v1.index);
            sb.append("-");
            sb.append(a.v2.index);
            sb.append(", ");
        }
        sb.delete(sb.length() - 2, sb.length());
        System.out.println(sum);
        System.out.println(sb);
    }
}
