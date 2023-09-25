package Q4;

import Q1.Grafo;
import Q1.Vertice;

import java.util.*;

public class Dijkstra {
    public static void run(String arquivo, int index) {
        Grafo g = new Grafo();
        g.lerArquivo(arquivo);
        RespostaDijkstra resposta = dijkstra(g, index-1);
        printResposta(g, resposta, index-1);
    }

    public static class RespostaDijkstra {
        public List<Distancia> distancias;
        public List<Vertice> ancestrais;

        public RespostaDijkstra(List<Distancia> distancias, List<Vertice> ancestrais) {
            this.distancias = distancias;
            this.ancestrais = ancestrais;
        }
    }

    public static RespostaDijkstra dijkstra(Grafo g, int index) {
        int nVertices = g.getVertices().size();
        List<Vertice> visitados = new ArrayList<>();
        PriorityQueue<Distancia> distancias = new PriorityQueue<>();
        List<Distancia> listDistancias = new ArrayList<>();
        for (Vertice v : g.getVertices()) {
            Distancia d;
            double peso = v.index-1 == index ? 0 : Double.POSITIVE_INFINITY;
            d = new Distancia(v, peso);
            distancias.add(d);
            listDistancias.add(d);
        }
        List<Vertice> ancestrais = new ArrayList<>(Collections.nCopies(nVertices+1, null));

        while (visitados.size() < nVertices) {
            Vertice u = Objects.requireNonNull(distancias.poll()).vertice;
            visitados.add(u);

            Set<Vertice> vizinhos = u.arestas.keySet();

            for (Vertice vizinho : vizinhos) {
                double distanciaU = listDistancias.get(u.index-1).peso;
                double distanciaVizinho = listDistancias.get(vizinho.index-1).peso;
                double peso = u.arestas.get(vizinho);
                if (distanciaVizinho > distanciaU + peso) {
                    distancias.remove(new Distancia(vizinho, distanciaVizinho));
                    Distancia novaDistancia = new Distancia(vizinho, distanciaU + peso);
                    distancias.add(novaDistancia);
                    listDistancias.set(vizinho.index-1, novaDistancia);
                    ancestrais.set(vizinho.index-1, u);
                }
            }
        }
        return new RespostaDijkstra(listDistancias, ancestrais);
    }

    public static void printResposta(Grafo g, RespostaDijkstra resposta, int origem) {
        System.out.println("Questão 4 - Djikstra");
        System.out.println("------------------------------------------------------------------------------");
        for (Vertice v : g.getVertices()) {
            List<Integer> caminho = new ArrayList<>();
            double distancia = 0;
            int vAtual = v.index;
            caminho.add(vAtual);
            while (vAtual != origem+1) {
                distancia += resposta.distancias.get(vAtual-1).peso;
                vAtual = resposta.ancestrais.get(vAtual-1).index;
                caminho.add(vAtual);
            }
            System.out.printf("%d: ", v.index);
            for (int i = caminho.size()-1; i >= 0; i--) {
                System.out.print(caminho.get(i));
                if (i > 0) {
                    System.out.print(", ");
                }
            }
            System.out.printf("; d=%.1f\n", distancia);
        }
        System.out.println("------------------------------------------------------------------------------\n");
    }

}
