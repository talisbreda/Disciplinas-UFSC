import Q2.BuscaLargura;
import Q3.CicloEuleriano;
import Q4.Dijkstra;
import Q5.FloydWarshall;

public class App {
    public static void main(String[] args) throws Exception {
        BuscaLargura.run("./karate.net", 1);
        CicloEuleriano.run("./ContemCicloEuleriano.net");
        Dijkstra.run("./fln_pequena.net", 1);
        FloydWarshall.run("./fln_pequena.net");
    }
}
