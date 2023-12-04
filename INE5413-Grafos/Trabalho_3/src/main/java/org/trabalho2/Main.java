package org.trabalho2;

import org.trabalho2.Q3.Coloracao;
import org.trabalho2.Q1.EdmondsKarp;

public class Main {
    public static void main(String[] args) {
        EdmondsKarp.run("./fluxo_maximo_aula.net");
        Coloracao.run("./cor3.net");
    }
}