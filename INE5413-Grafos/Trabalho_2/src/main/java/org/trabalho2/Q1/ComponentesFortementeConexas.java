package org.trabalho2.Q1;

import org.trabalho2.Grafo.Aresta;
import org.trabalho2.Grafo.GrafoDirigido;
import org.trabalho2.Grafo.Vertice;

import java.util.*;

public class ComponentesFortementeConexas {
    public static void run(String path) {
        GrafoDirigido g = new GrafoDirigido();
        g.lerArquivo(path);
        encontraComponentes(g);
    }

    private static void encontraComponentes(GrafoDirigido g) {
        RespostaDFS resposta = DFS(g, g.getVertices());
        Set<Aresta> arestasTranspostas = new HashSet<>();
        for (Aresta a : g.getArestas()) {
            arestasTranspostas.add(new Aresta(a.v2, a.v1, a.peso));
        }
        GrafoDirigido gTransposto = new GrafoDirigido(g.getVertices(), arestasTranspostas);
        List<Vertice> verticesOrdenados = new ArrayList<>();
        while (!resposta.temposFinais.isEmpty()) {
            verticesOrdenados.add(resposta.temposFinais.poll().vertice);
        }
        RespostaDFS respostaTransposta = DFS(gTransposto, verticesOrdenados);
        List<PriorityQueue<Integer>> trees = identificaArvores(g, respostaTransposta.antecessores);
        printArvores(trees);
    }

    private static RespostaDFS DFS(GrafoDirigido g, List<Vertice> vertices) {
        int n = g.qtdVertices();
        List<Boolean> visitados = new ArrayList<>(Collections.nCopies(n, false));
        List<Integer> temposEntrada = new ArrayList<>(Collections.nCopies(n, Integer.MAX_VALUE));
        PriorityQueue<Tempo> temposFinais = new PriorityQueue<>();
        List<Vertice> antecessores = new ArrayList<>(Collections.nCopies(n, null));

        int tempo = 0;
        RespostaDFS r = new RespostaDFS(visitados, temposEntrada, temposFinais, antecessores, tempo);

        for (Vertice v : vertices) {
            if (!visitados.get(v.index)) {
                r = DFSVisit(g, v, visitados, temposEntrada, temposFinais, antecessores, tempo);
            }
        }
        return r;
    }

    private static RespostaDFS DFSVisit(
            GrafoDirigido g,
            Vertice v,
            List<Boolean> visitados,
            List<Integer> temposEntrada,
            PriorityQueue<Tempo> temposFinais,
            List<Vertice> antecessores,
            int tempo
    ) {
        visitados.set(v.index, true);
        tempo++;
        temposEntrada.set(v.index, tempo);
        RespostaDFS r = new RespostaDFS(visitados, temposEntrada, temposFinais, antecessores, tempo);

        for (Vertice u : v.arestas.keySet()) {
            if (!visitados.get(u.index)) {
                antecessores.set(u.index, v);
                r = DFSVisit(g, u, visitados, temposEntrada, temposFinais, antecessores, tempo);
            }
        }

        tempo = r.tempo+1;
        Tempo newTempo = new Tempo(v, tempo);
        temposFinais.add(newTempo);
        r.setTemposFinais(temposFinais);

        return r;
    }

    public static List<PriorityQueue<Integer>> identificaArvores(GrafoDirigido g, List<Vertice> AT) {
        int n = g.qtdVertices(); // Number of vertices in the graph.
        List<Boolean> visitados = new ArrayList<>(Collections.nCopies(n, false));
        List<PriorityQueue<Integer> > trees = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (AT.get(i) == null || !visitados.get(i)) {
                int current = i;
                PriorityQueue<Integer> tree = new PriorityQueue<>();
                Stack<Integer> stack = new Stack<>();
                stack.push(current);

                while (!stack.isEmpty()) {
                    current = stack.pop();
                    if (!visitados.get(current)) {
                        visitados.set(current, true);
                        tree.add(current);
                        for (Vertice vizinho : AT) {
                            if (vizinho == null) {
                                continue;
                            }
                            stack.push(vizinho.index);
                        }
                    }
                }

                if (!tree.isEmpty()) {
                    trees.add(tree);
                }
            }
        }

        return trees;
    }

    private static void printArvores(List<PriorityQueue<Integer>> trees) {
        System.out.printf("%d componentes fortemente conexas encontradas:\n", trees.size());
        for (PriorityQueue<Integer> tree : trees) {
            System.out.print("{ ");
            while (!tree.isEmpty()) {
                if (tree.size() == 1) {
                    System.out.printf("%s", tree.poll());
                    break;
                }
                System.out.printf("%s, ", tree.poll());
            }
            System.out.print(" }\n");
        }
    }
}
