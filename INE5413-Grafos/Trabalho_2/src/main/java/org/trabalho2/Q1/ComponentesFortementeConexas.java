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
        RespostaDFS resposta = DFS(g);
        Set<Aresta> arestasTranspostas = new HashSet<>();
        for (Aresta a : g.getArestas()) {
            arestasTranspostas.add(new Aresta(a.v2, a.v1, a.peso));
        }
        GrafoDirigido gTransposto = new GrafoDirigido(g.getVertices(), arestasTranspostas);
        
    }

    private static RespostaDFS DFS(GrafoDirigido g) {
        int n = g.qtdVertices();
        List<Boolean> visitados = new ArrayList<>(Collections.nCopies(n, false));
        List<Integer> temposEntrada = new ArrayList<>(Collections.nCopies(n, Integer.MAX_VALUE));
        List<Integer> temposFinais = new ArrayList<>(Collections.nCopies(n, Integer.MAX_VALUE));
        List<Vertice> antecessores = new ArrayList<>(Collections.nCopies(n, null));

        int tempo = 0;
        RespostaDFS r = new RespostaDFS(visitados, temposEntrada, temposFinais, antecessores, tempo);

        for (Vertice v : g.getVertices()) {
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
            List<Integer> temposFinais,
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
        temposFinais.set(v.index, tempo);

        return r;
    }
}
