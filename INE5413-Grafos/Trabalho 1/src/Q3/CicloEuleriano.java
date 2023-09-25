package Q3;

import Q1.Aresta;
import Q1.Grafo;
import Q1.Vertice;

import java.util.*;

public class CicloEuleriano {
    public static void run(String arquivo) {
        Grafo g = new Grafo();
        g.lerArquivo(arquivo);
        System.out.println("Questão 3 - Ciclo Euleriano");
        System.out.println("------------------------------------------------------------------------------");
        if (temCiclo(g)) {
            hierholzer(g);
        } else {
            System.out.println(0);
        }
        System.out.println("------------------------------------------------------------------------------\n");
    }

    private static boolean temCiclo(Grafo g) {
        List<Vertice> vertices = g.getVertices();
        for (Vertice v : vertices) {
            if (g.grau(v.index) % 2 != 0) return false;
        }
        return true;
    }

    private static class RespostaHierholzer {
        public List<Vertice> caminho;
        public boolean temCiclo;

        public RespostaHierholzer(boolean temCiclo, List<Vertice> caminho) {
            this.temCiclo = temCiclo;
            this.caminho = caminho;
        }
    }

    private static void hierholzer(Grafo g) {
        Map<Aresta, Boolean> visitados = new HashMap<>();
        for (Aresta aresta : g.getArestas()) {
            visitados.put(aresta, false);
        }
        Vertice v = g.getVertices().get(0);

        RespostaHierholzer subciclo = buscarSubcicloEuleriano(g, v, visitados);

        if (!subciclo.temCiclo) {
            System.out.println(0);
        } else {
            if (visitados.containsValue(false)) {
                System.out.println(0);
            } else {
                printCiclo(subciclo.caminho);
            }
        }
    }

    private static RespostaHierholzer buscarSubcicloEuleriano(Grafo g, Vertice v, Map<Aresta, Boolean> visitados) {
        List<Vertice> ciclo = new ArrayList<>();
        ciclo.add(v);
        Vertice t = v;

        do {
            Aresta vu = selecionaArestaNaoVisitada(visitados, v);
            if (vu != null) {
                visitados.put(vu, true);
                v = vu.v2;
                ciclo.add(v);
            } else {
                return new RespostaHierholzer(false, null);
            }
        } while (t != v);

        for (Vertice vertice : ciclo) {
            Aresta a = selecionaArestaNaoVisitada(visitados, vertice);
            if (a != null) {
                RespostaHierholzer subciclo = buscarSubcicloEuleriano(g, vertice, visitados);
                if (!subciclo.temCiclo) {
                    return new RespostaHierholzer(false, null);
                }
            }
        }
        return new RespostaHierholzer(true, ciclo);
    }

    private static Aresta selecionaArestaNaoVisitada(Map<Aresta, Boolean> visitados, Vertice v) {
        Set<Vertice> vizinhos = v.arestas.keySet();
        for (Vertice vizinho : vizinhos) {
            Aresta a = new Aresta(v, vizinho);
            if (!visitados.get(a)) {
                return a;
            }
        }
        return null;
    }

    private static void printCiclo(List<Vertice> caminho) {
        System.out.println(1);
        for (int i = 0; i < caminho.size(); i++) {
            System.out.print(caminho.get(i).index);
            if (i < caminho.size() - 1) {
                System.out.print(", ");
            }
        }
        System.out.println();
    }

}
