package org.trabalho2;

import org.trabalho2.Q1.ComponentesFortementeConexas;
import org.trabalho2.Q2.OrdenacaoTopologica;
import org.trabalho2.Q3.Kruskal;

public class Main {
    public static void main(String[] args) {
        ComponentesFortementeConexas.run("./teste_componente1.net");
        OrdenacaoTopologica.run("./teste_ordenacao3.net");
        Kruskal.run("./teste_kruskal2.net");
    }
}