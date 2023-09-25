package Q5;

import Q1.Grafo;
import Q1.Vertice;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;



public class FloydWarshall {
    public static void run(String path) {
        Grafo g = new Grafo();
        g.lerArquivo(path);
        List<List<Double>> resposta = floydWarshall(g);
        printResposta(resposta);
    }

    public static List<List<Double>> floydWarshall(Grafo g) {
        List<Vertice> vertices = g.getVertices();

        List<List<List<Double>>> D = new ArrayList<>();
        D.add(g.getMatrizAdjacencia());

        for (Vertice k : vertices) {
            D.add(novaMatriz(vertices.size()+1));
            for (Vertice u : vertices) {
                for (Vertice v : vertices) {
                    double duv = D.get(k.index-1).get(u.index).get(v.index);
                    double duk = D.get(k.index-1).get(u.index).get(k.index);
                    double dkv = D.get(k.index-1).get(k.index).get(v.index);
                    D.get(k.index).get(u.index).set(v.index, Math.min(duv, duk + dkv));
                }
            }
        }
        return D.get(vertices.size()-1);
    }

    public static List<List<Double>> novaMatriz(int size) {
        List<List<Double>> matriz = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            matriz.add(new ArrayList<>());
            for (int j = 0; j < size; j++) {
                matriz.get(i).add(Double.POSITIVE_INFINITY);
            }
        }
        return matriz;
    }

    public static void printResposta(List<List<Double>> D) {
        for (int i = 1; i < D.size(); i++) {
            System.out.printf("%d: ", i);
            for (int j = 1; j < D.size(); j++) {
                double distancia = D.get(i).get(j);
                if (distancia != Double.POSITIVE_INFINITY) System.out.printf("%d", (int)distancia);
                if (j != D.size()-1) System.out.print(", ");
            }
            System.out.println();
        }
    }
}
