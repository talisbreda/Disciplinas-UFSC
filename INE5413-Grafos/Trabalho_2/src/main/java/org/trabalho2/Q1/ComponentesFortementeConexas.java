package org.trabalho2.Q1;

import org.trabalho2.Grafo.Aresta;
import org.trabalho2.Grafo.GrafoDirigido;
import org.trabalho2.Grafo.Vertice;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ComponentesFortementeConexas {
    public static void run(String caminho) {
        GrafoDirigido g = new GrafoDirigido();
        g.lerArquivo(caminho);

    }

    private static List<Vertice> encontraComponentes(GrafoDirigido g) {
        RespostaDFS resposta = DFS(g);
        Set<Aresta> arestas = g.getArestas();
        GrafoDirigido gt = new GrafoDirigido();
        gt.setVertices(g.getVertices());
        for (Aresta a : g.getArestas()) {
            gt.addAresta(a.v2, a.v1, a.peso);
        }
    }

    private static RespostaDFS DFS(GrafoDirigido g) {
        List<Boolean> visitados = new ArrayList<>();
        List<Integer> tempos = new ArrayList<>();
        List<Vertice> antecessores = new ArrayList<>();
        List<Integer> temposFinais = new ArrayList<>();
        for (Vertice v : g.getVertices()) {
            visitados.set(v.index, false);
            tempos.set(v.index, Integer.MAX_VALUE);
            temposFinais.set(v.index, Integer.MAX_VALUE);
            antecessores.set(v.index, null);
        }

        int tempo = 0;
        for (Vertice v : g.getVertices()) {
            if (!visitados.get(v.index)) {
                DFS_visit(g, v, visitados, tempos, antecessores, temposFinais, tempo);
            }
        }
        return new RespostaDFS(visitados, tempos, temposFinais, antecessores);
    }

    private static RespostaDFS DFS_visit(
            GrafoDirigido g,
            Vertice v,
            List<Boolean> visitados,
            List<Integer> tempos,
            List<Vertice> antecessores,
            List<Integer> temposFinais,
            int tempo
    ) {
        visitados.set(v.index, true);
        tempo++;
        tempos.set(v.index, tempo);
        for (Vertice u : g.vizinhos(v.index)) {
            if (!visitados.get(u.index)) {
                antecessores.set(u.index, v);
                DFS_visit(g, u, visitados, tempos, antecessores, temposFinais, tempo);
            }
        }
        tempo++;
        temposFinais.set(v.index, tempo);
        return new RespostaDFS(visitados, tempos, temposFinais, antecessores);
    }
}
