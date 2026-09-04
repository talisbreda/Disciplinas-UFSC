package com.lexgen.synt;

import com.lexgen.utils.SyntacticUtils;
import lombok.Getter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
public class SymbolTable {
    private final Map<String, SymbolEntry> table;
    private int counter;

    public SymbolTable() {
        this.table = new HashMap<>();
        this.counter = 0;
    }

    public record SymbolEntry(String lexeme, String type, int address) {
        @Override
        public String toString() {
            // Se endereço for -1, imprimimos como PR (Palavra Reservada) ou pelo tipo
            if (address == -1) return "<" + lexeme + ", " + type + ">";
            return "<" + lexeme + ", " + address + ">"; // Ex: <x, 10>
        }
    }

    public List<SymbolEntry> getEntries() {
        return table.values().stream().toList();
    }

    /**
     * Inicializa a tabela com a lista de palavras reservadas.
     * Isso deve ser feito na Interface de Projeto.
     * @param reservedWords Lista de lexemas (ex: "if", "while", "int")
     */
    public void initializeReservedWords(List<String> reservedWords) {
        for (String word : reservedWords) {
            // Para palavras reservadas, assumimos que o 'type' (Nome do Token)
            // é igual ao próprio lexema (ex: lexema "if" tem token "if").
            // O endereço é -1 para indicar que não é um ID endereçável.
            table.put(word, new SymbolEntry(word, "PR", -1));
        }
        SyntacticUtils.printSymbolTable(this, "symbol_table_reserved_words");
    }

    /**
     * Adiciona ou recupera um token da tabela.
     */
    public SymbolEntry addOrGet(String lexeme, String tokenType) {
        // Se já existe (seja palavra reservada carregada antes ou ID já visto), retorna.
        if (table.containsKey(lexeme)) {
            return table.get(lexeme);
        }

        // Se não existe, é um novo Identificador.
        // O enunciado diz para retornar <id, 10>.
        // Aqui assumimos que se chegou um lexema novo, ele é um ID.

        // Nota: Se o tokenType não for "id" (ex: chegou um número "123"),
        // a lógica de endereço depende se você quer guardar literais na tabela.
        // Geralmente tabela de símbolos é para IDs. Vamos assumir IDs.

        int addr = -1;
        // Apenas geramos endereço se for classificado como identificador pelo Lexer
        if ("id".equals(tokenType)) {
            addr = ++counter;
        }

        SymbolEntry entry = new SymbolEntry(lexeme, tokenType, addr);
        table.put(lexeme, entry);
        return entry;
    }
}