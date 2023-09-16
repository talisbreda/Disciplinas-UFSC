package Q1;

import Q3.Aresta;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class Grafo {

    private final List<Vertice> vertices;

    private final Set<Aresta> arestas;

    public Grafo() {
        this.vertices = new ArrayList<>();
        this.arestas = new HashSet<>();
    }

    public int qtdVertices() {
        return vertices.size();
    }

    public int qtdArestas() { return arestas.size(); }

    public int grau(int vertice) {
        return vertices.get(vertice-1).arestas.size();
    }

    public String rotulo(int vertice) {
        return vertices.get(vertice).rotulo;
    }

    public Set<Vertice> vizinhos(int vertice) {
        return vertices.get(vertice).arestas.keySet();
    }

    public boolean haAresta(int v1, int v2) {
        return vertices.get(v1).arestas.containsKey(new Vertice(v2));
    }

    public Double peso(int v1, int v2) {
        Map<Vertice, Double> arestas = vertices.get(v1).arestas;
        Vertice v = new Vertice(v2);
        if (arestas.containsKey(v)) {
            return arestas.get(v);
        }
        return Double.POSITIVE_INFINITY;
    }

    public void lerArquivo(String nomeArquivo) {
        String content;
        content = readFileToString(nomeArquivo);
        boolean inVertices = false;
        boolean inEdges = false;
        for (String linha : content.split("\n")) {

            if (linha.contains("*vertices")) {
                inVertices = true;
                inEdges = false;
                continue;
            }
            if (linha.contains("*edges")) {
                inVertices = false;
                inEdges = true;
                continue;
            }

            if (inVertices) {
                String[] partes = linha.split(" ");
                String index = partes[0];
                String rotulo = partes[1];
                Vertice v = new Vertice(Integer.parseInt(index), rotulo);
                vertices.add(v);
            }

            if (inEdges) {
                String[] partes = linha.split(" ");
                String index1 = partes[0];
                String index2 = partes[1];
                String peso = partes[2];
                Vertice v1 = vertices.get(Integer.parseInt(index1) - 1);
                Vertice v2 = vertices.get(Integer.parseInt(index2) - 1);
                v1.arestas.put(v2, Double.parseDouble(peso));
                v2.arestas.put(v1, Double.parseDouble(peso));
                this.arestas.add(new Aresta(v1, v2, Double.parseDouble(peso)));
            }
        }
    }

    public List<Vertice> getVertices() {
        return vertices;
    }

    public String readFileToString(String fileName) {
        try {
            BufferedReader reader = new BufferedReader(new FileReader(fileName));
            StringBuilder stringBuilder = new StringBuilder();
            String line = null;
            String ls = System.getProperty("line.separator");
            while ((line = reader.readLine()) != null) {
                stringBuilder.append(line);
                stringBuilder.append(ls);
            }
            // delete the last new line separator
            stringBuilder.deleteCharAt(stringBuilder.length() - 1);
            reader.close();

            return stringBuilder.toString();
        } catch (IOException e) {
            System.out.println("Erro ao ler arquivo: " + e.getMessage());
            return "";
        } 
    }

}
