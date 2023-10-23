package org.trabalho2.Grafo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class MatrizAdjacencia {
    private final List<List<Double>> matriz;

    public MatrizAdjacencia() {
        this.matriz = new ArrayList<>();
        matriz.add(new ArrayList<>());
    }

    public void addVertice() {
        matriz.add(new ArrayList<>(Collections.nCopies(matriz.size()+1, Double.POSITIVE_INFINITY)));
        for (List<Double> doubles : matriz) {
            doubles.add(Double.POSITIVE_INFINITY);
        }
        matriz.get(matriz.size()-1).set(matriz.size()-1, 0.0);
    }

    public void setPeso(int i, int j, double valor) {
        if (i >= matriz.size()) {
            for (int k = matriz.size(); k <= i; k++) {
                matriz.add(new ArrayList<>());
            }
        }
        matriz.get(i).set(j, valor);
    }

    public double get(int i, int j) {
        return matriz.get(i).get(j);
    }

    public List<List<Double>> getMatriz() {
        return matriz;
    }

    public void clear() {
        matriz.clear();
    }
}
