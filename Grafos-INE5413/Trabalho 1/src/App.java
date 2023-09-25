import Q2.BuscaLargura;
import Q3.CicloEuleriano;
import Q4.Djikstra;
import Q5.FloydWarshall;

public class App {
    public static void main(String[] args) throws Exception {
        BuscaLargura.run("./karate_show.net", 12);
        CicloEuleriano.run("./ContemCicloEuleriano.net");
        Djikstra.run("./fln_pequena.net", 1);
        FloydWarshall.run("./fln_pequena.net");
    }
}
