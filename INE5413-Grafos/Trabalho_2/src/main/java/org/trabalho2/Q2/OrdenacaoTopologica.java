package org.trabalho2.Q2;

import org.trabalho2.Grafo.GrafoDirigido;
import org.trabalho2.Grafo.Vertice;

import java.util.*;

public class OrdenacaoTopologica {
    public static void run(String path) {
        GrafoDirigido g = new GrafoDirigido();
        g.lerArquivo(path);
        ordenacaoTopologica(g);
    }

    private static void ordenacaoTopologica(GrafoDirigido g) {
        int n = g.qtdVertices();
        List<Boolean> visitados = new ArrayList<>(Collections.nCopies(n, false));
        List<Integer> tempos = new ArrayList<>(Collections.nCopies(n, Integer.MAX_VALUE));
        List<Integer> temposFinais = new ArrayList<>(Collections.nCopies(n, Integer.MAX_VALUE));
        LinkedList<Vertice> ordem = new LinkedList<>();

        int tempo = 0;
        RespostaDFS_OT r = new RespostaDFS_OT(visitados, tempos, temposFinais, ordem, tempo);

        for (int i = 0; i < n; i++) {
            if (!visitados.get(i)) {
                r = DFSVisit(g, g.getVertices().get(i), visitados, tempos, temposFinais, tempo, ordem);
            }
        }
        printOrdem(r.ordem);
    }

    private static RespostaDFS_OT DFSVisit(
            GrafoDirigido g,
            Vertice v,
            List<Boolean> visitados,
            List<Integer> tempos,
            List<Integer> temposFinais,
            int tempo,
            LinkedList<Vertice> ordem
    ) {
        visitados.set(v.index, true);
        tempo++;
        tempos.set(v.index, tempo);
        RespostaDFS_OT r = new RespostaDFS_OT(visitados, tempos, temposFinais, ordem, tempo);
        for (Vertice u : v.arestas.keySet()) {
            if (!r.visitados.get(u.index)) {
                r = DFSVisit(g, u, r.visitados, r.temposEntrada, r.temposFinais, r.tempo, r.ordem);
            }
        }
        tempo = r.tempo + 1;
        r.temposFinais.set(v.index, tempo);
        r.ordem.addFirst(v);
        return r;
    }

    private static void printOrdem(LinkedList<Vertice> ordem) {
        System.out.println("Ordem topológica:");
        List<Vertice> ordemL = ordem.stream().toList();
        int index = 1;
        for (Vertice v : ordemL) {
            String rotulo = v.getRotulo();
            System.out.printf("%d. %s\n", index, rotulo);
            index++;
        }
    }
}
