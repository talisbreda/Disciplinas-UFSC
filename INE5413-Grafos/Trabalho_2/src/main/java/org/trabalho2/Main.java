package org.trabalho2;

import org.trabalho2.Q1.ComponentesFortementeConexas;
import org.trabalho2.Q2.OrdenacaoTopologica;
import org.trabalho2.Q3.Kruskal;

public class Main {
    public static void main(String[] args) {
//        ComponentesFortementeConexas.run("./tcc_completo.net");
//        OrdenacaoTopologica.run("./tcc_completo.net");
        Kruskal.run("./karate_show.net");
    }
}