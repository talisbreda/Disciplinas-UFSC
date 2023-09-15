import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class Grafo {

    private List<Vertice> vertices;

    public Grafo() {
        this.vertices = new ArrayList<>();
    }

    public int qtdVertices() {
        return vertices.size();
    }

    public int qtdArestas() {
        int qtd = 0;
        for (Vertice v : vertices) {
            qtd += v.arestas.size();
        }
        return qtd;
    }

    public int grau(int vertice) {
        return vertices.get(vertice-1).arestas.size();
    }

    public String rotulo(int vertice) {
        return vertices.get(vertice).rotulo;
    }

    public List<Vertice> vizinhos(int vertice) {
        Set<Aresta> arestas = vertices.get(vertice).arestas;
        List<Vertice> vizinhos = new ArrayList<>();
        for (Aresta a : arestas) {
            vizinhos.add(a.v2);
        }
        return vizinhos;
    }

    public boolean haAresta(int v1, int v2) {
        return vertices.get(v1).arestas.contains(new Aresta(new Vertice(v1), new Vertice(v2)));
    }

    public Double peso(int v1, int v2) {
        Set<Aresta> arestas = vertices.get(v1).arestas;
        Aresta aresta = new Aresta(new Vertice(v1), new Vertice(v2));
        for (Aresta a : arestas) {
            if (a == aresta) {
                return a.peso;
            }
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
                v1.arestas.add(new Aresta(v1, v2, Double.parseDouble(peso)));
                v2.arestas.add(new Aresta(v2, v1, Double.parseDouble(peso)));
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
    
            String content = stringBuilder.toString();
            return content;
        } catch (IOException e) {
            System.out.println("Erro ao ler arquivo: " + e.getMessage());
            return "";
        } 
    }

}
