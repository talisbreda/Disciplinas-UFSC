package org.trabalho2.Q3;

import org.trabalho2.Grafo.Grafo;
import org.trabalho2.Grafo.Vertice;

import java.util.*;

public class Coloracao {
    public static void run(String path) {
        Grafo g = new Grafo();
        g.lerArquivo(path);
        System.out.println("Questão 3 - Coloração de vértices");
        System.out.println("------------------------------------------------------------------------");
        lawler(g);
        System.out.println("------------------------------------------------------------------------\n");
    }

    private static void lawler(Grafo g) {
        int n = (int) Math.pow(2, g.qtdVertices());
        ArrayList<Integer> X = new ArrayList<>(Collections.nCopies(n, 0));
        ArrayList<Set<Vertice>> subsets = geraSubconjuntos(new ArrayList<>(g.getVertices()));

        for (Set<Vertice> subset : subsets) {
            if (subset.isEmpty()) continue;

            int s = subsets.indexOf(subset);
            X.set(s, 2000000);
            Grafo gg = new Grafo();
            gg.setVertices(new ArrayList<>(subset));

            for (Vertice v : subset) {
                for (Vertice u : subset) {
                    if (v != u && g.haAresta(v.index, u.index)) {
                        gg.addAresta(v, u, g.peso(v.index, u.index));
                    }
                }
            }
            List<Set<Vertice>> maximais = conjuntosIndependentesMaximais(gg);
            for (Set<Vertice> maximal : maximais) {
                Set<Vertice> difference = new HashSet<>(subset);
                difference.removeAll(maximal);
                int i = subsets.indexOf(difference);
                if (X.get(i) + 1 < X.get(s)) {
                    X.set(s, X.get(i) + 1);
                }
            }
        }
        System.out.println("Cores: " + X.get(n-1));
    }

    private static List<Set<Vertice>> conjuntosIndependentesMaximais(Grafo g) {
        List<Set<Vertice>> subsets = geraSubconjuntos(new ArrayList<>(g.getVertices()));
        Collections.reverse(subsets);
        List<Set<Vertice>> R = new ArrayList<>();
        for (Set<Vertice> subset : subsets) {
            boolean c = true;
            for (Vertice v : subset) {
                for (Vertice u : subset) {
                    if (v != u && g.haAresta(v.index, u.index)) {
                        c = false;
                        break;
                    }
                }
            }
            if (c) {
                R.add(subset);
                break;
            }
        }
        R.sort(new SubsetSizeComparator());
        return R;
    }

    public static ArrayList<Set<Vertice>> geraSubconjuntos(ArrayList<Vertice> conjunto) {

        ArrayList<Set<Vertice>> allsubsets = new ArrayList<>();
        int max = 1 << conjunto.size();

        for (int i = 0; i < max; i++) {
            Set<Vertice> subset = new HashSet<>();
            for (int j = 0; j < conjunto.size(); j++) {
                if (((i >> j) & 1) == 1) {
                    subset.add(conjunto.get(j));
                }
            }
            allsubsets.add(subset);
        }
        allsubsets.sort(new SubsetSizeComparator());
        return allsubsets;
    }

    private static class SubsetSizeComparator implements Comparator<Set<Vertice>>, org.trabalho2.Q3.SubsetSizeComparator {
        @Override
        public int compare(Set<Vertice> set1, Set<Vertice> set2) {
            return Integer.compare(set1.size(), set2.size());
        }
    }
}
