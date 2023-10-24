package org.trabalho2.Grafo;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class GrafoDirigido {

    private final List<Vertice> vertices;

    private final Set<Aresta> arestas;


    public GrafoDirigido() {
        this.vertices = new ArrayList<>();
        this.arestas = new HashSet<>();
    }

    public GrafoDirigido(List<Vertice> vertices, Set<Aresta> arestas) {
        this.vertices = vertices;
        this.arestas = arestas;
    }

    public int qtdVertices() {
        return vertices.size();
    }

    public int qtdArestas() { return arestas.size(); }

    public int grau(int vertice) {
        return vertices.get(vertice-1).arestas.size();
    }

    public String rotulo(int vertice) {
        return vertices.get(vertice-1).rotulo;
    }

    public Set<Vertice> vizinhos(int vertice) {
        return vertices.get(vertice-1).arestas.keySet();
    }

    public boolean haAresta(int v1, int v2) {
        double pesoAresta = this.vertices.get(v1-1).arestas.get(this.vertices.get(v2-1));
        return pesoAresta != Double.POSITIVE_INFINITY;
    }

    public Double peso(int v1, int v2) {
        return this.vertices.get(v1-1).arestas.get(this.vertices.get(v2-1));
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
            if (linha.contains("*edges") || linha.contains("*arcs")) {
                inVertices = false;
                inEdges = true;
                continue;
            }

            if (inVertices) {
                String[] partes = linha.split(" ", 2);
                String index = partes[0];
                String rotulo = partes[1];
                Vertice v = new Vertice(Integer.parseInt(index)-1, rotulo);
                vertices.add(v);
            }

            if (inEdges) {
                String[] partes = linha.split(" ");
                String index1 = partes[0];
                String index2 = partes[1];
                String peso = partes[2];
                Vertice v1 = vertices.get(Integer.parseInt(index1) - 1);
                Vertice v2 = vertices.get(Integer.parseInt(index2) - 1);
                double pesoDouble = Double.parseDouble(peso);
                v1.arestas.put(v2, pesoDouble);
                this.arestas.add(new Aresta(v1, v2, pesoDouble));
            }
        }
    }

    public List<Vertice> getVertices() {
        return vertices;
    }

    public void setVertices(List<Vertice> vertices) {
        this.vertices.clear();
        this.vertices.addAll(vertices);
    }

    public Set<Aresta> getArestas() {
        return arestas;
    }

    public void addAresta(Vertice v1, Vertice v2, double peso) {
        v1.arestas.put(v2, peso);
        this.arestas.add(new Aresta(v1, v2, peso));
    }

    public void setArestas(Set<Aresta> arestas) {
        this.arestas.clear();
        this.arestas.addAll(arestas);
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
            stringBuilder.deleteCharAt(stringBuilder.length() - 1);
            reader.close();

            return stringBuilder.toString();
        } catch (IOException e) {
            System.out.println("Erro ao ler arquivo: " + e.getMessage());
            return "";
        } 
    }

}
