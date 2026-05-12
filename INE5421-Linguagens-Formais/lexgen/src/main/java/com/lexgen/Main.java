package com.lexgen;

import com.lexgen.core.Grammar;
import com.lexgen.lexer.Lexer;
import com.lexgen.lexer.LexerGenerator;
import com.lexgen.lexer.Token;
import com.lexgen.parser.GrammarParser;
import com.lexgen.parser.ReservedWordsParser;
import com.lexgen.parser.SLRParser;
import com.lexgen.parser.TokenParser;
import com.lexgen.synt.SLRTable;
import com.lexgen.synt.SLRTableGenerator;
import com.lexgen.synt.SymbolTable;
import com.lexgen.utils.AutomataUtils;
import com.lexgen.utils.SyntacticUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {

    private static final Map<Integer, List<String>> expectedResults = new HashMap<>() {
        {
            put(-1, new ArrayList<>() {{
                add("Teste manual");
                add("Teste manual");
            }});

            put(0, new ArrayList<>() {{
                add("Sucesso");
                add("Indefinido");
            }});

            put(1, new ArrayList<>() {{
                add("Sucesso");
                add("Indefinido");
            }});

            put(2, new ArrayList<>() {{
                add("Sucesso");
                add("Erro sintático: Símbolo 'contador_2' inesperado");
            }});

            put(3, new ArrayList<>() {{
                add("Sucesso");
                add("Conflito reduce/reduce. Estado 10, símbolo $.");
            }});

            put(4, new ArrayList<>() {{
                add("Sucesso");
                add("Sucesso");
            }});

            put(5, new ArrayList<>() {{
                add("Erro léxico: token inválido '@' encontrado.");
                add("Erro sintático: símbolo '@' inesperado.");
            }});

            put(6, new ArrayList<>() {{
                add("Sucesso");
                add("Sucesso");
            }});

            put(7, new ArrayList<>() {{
                add("Erro léxico: token inválido '@' encontrado.");
                add("Erro léxico: token inválido '@' encontrado.");
            }});

            put(8, new ArrayList<>() {{
                add("Sucesso");
                add("Erro sintático: token ';' inesperado.");
            }});

            put(9, new ArrayList<>() {{
                add("Sucesso");
                add("Sucesso");
            }});
        }};

    private static final Map<Integer, List<String>> testResults = new HashMap<>() {{
        put(0, new ArrayList<>());
        put(1, new ArrayList<>());
        put(2, new ArrayList<>());
        put(3, new ArrayList<>());
        put(4, new ArrayList<>());
        put(5, new ArrayList<>());
        put(6, new ArrayList<>());
        put(7, new ArrayList<>());
        put(8, new ArrayList<>());
        put(9, new ArrayList<>());
        put(-1, new ArrayList<>());
    }};

    private static String getFilePath(int testIndex, String filename) {
        if (testIndex != -1) return "src/main/resources/testes_automatizados/teste" + testIndex + "/" + filename;
        else return "src/main/resources/teste_manual/" + filename;
    }

    private record LexicalAnalysisResult(Lexer lexer, List<Token> tokens) {}

    public static void main(String[] args) {

        String flag;
        if (args.length == 0) {
            System.out.println("Nenhuma flag fornecida. Padronizando para testes automáticos");
            flag = "-a";
        } else {
            flag = args[0];
        }

        switch (flag) {
            case "--auto":
            case "-a":
                System.out.println(">>> Iniciando Modo de Testes Automáticos...");
                runAutomaticTests();
                break;
            case "--manual":
            case "-m":
            case "--lexical":
            case "-l":
            case "--syntactic":
            case "-s":
                System.out.println(">>> Iniciando Modo de Teste Manual...");

                // Verifica se um arquivo foi passado como segundo argumento
                // Ex: java Main --manual meu_arquivo.txt
                String testIndex = null;
                if (args.length > 1) {
                    testIndex = args[1];
                    System.out.println("Teste a ser executado: " + testIndex);
                } else {
                    System.out.println("Nenhum número específico fornecido. Rodando teste padrão...");
                }

                runManualTests(Integer.parseInt(testIndex != null ? testIndex : "-1"), flag);
                break;

            case "--help":
            case "-h":
                printUsage();
                break;

            default:
                System.err.println("Erro: Flag desconhecida '" + flag + "'");
                printUsage();
                System.exit(1);
        }
    }

    private static void runManualTests(int testIndex, String flag) {
        String regexFileName = "src/main/resources/teste_manual/def-reg.txt";
        String testFileName = "src/main/resources/teste_manual/teste.txt";
        String grammarFileName = "src/main/resources/teste_manual/grammar.txt";
        String reservedWordsFileName = "src/main/resources/teste_manual/reserved-words.txt";
        String tokenListFileName = "src/main/resources/teste_manual/token-list.txt";

        AutomataUtils.setTestIndex(testIndex);
        SyntacticUtils.setTestIndex(testIndex);

        try {
            if (flag.equals("--lexical") || flag.equals("-l")) {

                if (testIndex != -1) runLexicalAnalyzer(testIndex);
                else runLexicalAnalyzer(regexFileName, testFileName, testIndex);

            } else if (flag.equals("--syntactic") || flag.equals("-s")) {

                if (testIndex != -1) runSyntacticAnalyzer(testIndex, null);
                else runSyntacticAnalyzer(grammarFileName, reservedWordsFileName, tokenListFileName, null, testIndex);

            } else {
                if (testIndex != -1) {
                    LexicalAnalysisResult result = runLexicalAnalyzer(testIndex);
                    runSyntacticAnalyzer(testIndex, result);
                } else {
                    LexicalAnalysisResult result = runLexicalAnalyzer(regexFileName, testFileName, testIndex);
                    runSyntacticAnalyzer(grammarFileName, reservedWordsFileName, tokenListFileName, result, testIndex);
                }
            }
        } catch (Exception e) {
            System.out.println("\n================================================================");
            System.out.println("Erro durante o teste manual " + testIndex + ": " + e.getMessage());
            System.out.println("Resultado esperado (análise léxica): " + expectedResults.get(testIndex).getFirst());
            System.out.println("Resultado esperado (análise sintática): " + expectedResults.get(testIndex).getLast());
            System.out.println("================================================================\n\n");
            testResults.get(testIndex).add(e.getMessage());
        }
    }

    private static void runAutomaticTests() {
        // Os testes 0, 1 e 2 são somente do analisador léxico
        // Os teste 3, 4, e 5 são somente do analisador sintático
        // O teste 6, 7, 8 e 9 são testes completos (léxico + sintático)
        System.out.println("====== Iniciando testes automáticos ======");
        for (int i = 0; i < 10; i++) {
            if (i == 0) System.out.println("========================= Testes do analisador léxico =========================");
            else if (i == 3) System.out.println("========================= Testes do analisador sintático =========================");
            else if (i == 6) System.out.println("========================= Teste completo " + i + " =========================");

            AutomataUtils.setTestIndex(i);
            SyntacticUtils.setTestIndex(i);
            try {
                if (i < 3) {
                    runLexicalAnalyzer(i);
                } else if (i < 6) {
                    testResults.get(i).add("N/A (Não executado)");
                    runSyntacticAnalyzer(i, null);
                }
                else {
                    LexicalAnalysisResult result = runLexicalAnalyzer(i);
                    runSyntacticAnalyzer(i, result);
                }

            } catch (Exception e) {
                System.out.println("\n================================================================");
                System.out.println("Erro durante o teste automático " + i + ": " + e.getMessage());
                System.out.println("Resultado esperado (análise léxica): " + expectedResults.get(i).getFirst());
                System.out.println("Resultado esperado (análise sintática): " + expectedResults.get(i).getLast());
                System.out.println("================================================================\n\n");
                testResults.get(i).add(e.getMessage());
                System.out.flush();
                try { Thread.sleep(100); } catch (InterruptedException ignored) {} // tempo para IDE processar
            } finally {
                System.out.flush();
            }
        }

        printTestReport();
    }

    private static LexicalAnalysisResult runLexicalAnalyzer(String regexFileName, String testFileName, int testIndex)
            throws IOException
    {
        LexerGenerator lexerGenerator = new LexerGenerator();
        Lexer lexer = lexerGenerator.generate(regexFileName);
        List<Token> tokenList = lexer.analyzeFile(testFileName);

        System.out.println("\n================================================================");
        System.out.println("Análise léxica do teste " + testIndex + " concluída com sucesso.");
        System.out.println("Resultado esperado: " + expectedResults.get(testIndex).getFirst());
        System.out.println("================================================================\n\n");

        testResults.get(testIndex).add("Sucesso");

        return new LexicalAnalysisResult(lexer, tokenList);
    }

    private static LexicalAnalysisResult runLexicalAnalyzer(int testIndex) throws IOException {
        String regexFileName = getFilePath(testIndex, "def-reg.txt");
        String testFileName = getFilePath(testIndex, "teste.txt");

        System.out.println("\n--- Iniciando Análise Léxica do Teste " + testIndex + " ---\n");
        return runLexicalAnalyzer(regexFileName, testFileName, testIndex);
    }

    private static void runSyntacticAnalyzer(String grammarFileName, String reservedWordsFileName,
                                             String tokenListFileName, LexicalAnalysisResult result,
                                             int testIndex) {
        try {
            // Carrega a lista de tokens pré-gerada do arquivo
            List<Token> tokenList;
            if (result == null) {
                tokenList = TokenParser.parseTokenFile(tokenListFileName);
            } else {
                tokenList = result.tokens();
            }

            // 1. Leitura da gramática
            Grammar grammar = GrammarParser.loadGrammar(grammarFileName);

            // 2. Interface de projeto
            List<String> reservedWords = ReservedWordsParser.loadReservedWords(reservedWordsFileName);
            SymbolTable symbolTable = new SymbolTable();
            symbolTable.initializeReservedWords(reservedWords);
            SLRTableGenerator slrTableGenerator = new SLRTableGenerator(grammar);
            SLRTable slrTable = slrTableGenerator.generate();

            // 3. Interface de execução
            SLRParser slrParser = new SLRParser(slrTable, grammar);
            slrParser.parse(tokenList);

            System.out.println("\n================================================================");
            System.out.println("Análise sintática do teste " + testIndex + " concluída com sucesso.");
            System.out.println("Resultado esperado: " + expectedResults.get(testIndex).getLast());
            System.out.println("================================================================\n\n");

            testResults.get(testIndex).add("Sucesso");

        } catch (IOException e) {
            System.err.println("Erro ao ler o arquivo: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            System.err.println("Erro de formato no arquivo: " + e.getMessage());
        }
    }

    private static void runSyntacticAnalyzer(int testIndex, LexicalAnalysisResult result) {
        String grammarFileName = getFilePath(testIndex, "grammar.txt");
        String reservedWordsFileName = getFilePath(testIndex, "reserved-words.txt");
        String tokenListFileName = getFilePath(testIndex, "token-list.txt");

        System.out.println("\n--- Iniciando Análise Sintática do Teste " + testIndex + " ---\n");
        runSyntacticAnalyzer(grammarFileName, reservedWordsFileName, tokenListFileName, result, testIndex);
    }

    private static void printUsage() {
        System.out.println("\nUso: java Main [FLAG] [ARGS]");
        System.out.println("Flags disponíveis:");
        System.out.println("  --auto, -a           Executa a bateria de testes automáticos (Gramáticas padrão).");
        System.out.println("  --manual, -m [FILE]  Executa um teste manual. Opcionalmente recebi o caminho do arquivo.");
        System.out.println("  --help, -h           Exibe esta mensagem de ajuda.");
        System.out.println("  --lexical -l         Executa apenas o analisador léxico em modo manual.");
        System.out.println("  --syntactic -s       Executa apenas o analisador sintático em modo manual.");
        System.out.println("Argumentos:");
        System.out.println("  [NUM_ARQUIVO]        Número do teste automatizado a ser executado (usado com -m).");
    }

    /**
     * Compara os resultados obtidos com os esperados e imprime um relatório detalhado.
     */
    private static void printTestReport() {
        System.out.println("\n\n");
        System.out.println("======================================================================");
        System.out.println("                      RELATÓRIO FINAL DE TESTES                       ");
        System.out.println("======================================================================");

        List<Integer> testIds = new ArrayList<>(expectedResults.keySet());
        Collections.sort(testIds);

        for (Integer id : testIds) {
            if (id == -1) continue; // Pula o template de teste manual

            List<String> expected = expectedResults.get(id);
            List<String> actual = testResults.get(id);

            String expLex = getSafe(expected, 0);
            String expSyn = getSafe(expected, 1);
            String actLex = getSafe(actual, 0);
            String actSyn = getSafe(actual, 1);

            // Cabeçalho do Teste
            System.out.printf("TESTE %02d  \n", id);
            System.out.println("----------------------------------------------------------------------");

            // Detalhes Léxicos
            printStageDetails("Léxica", expLex, actLex);

            // Detalhes Sintáticos
            printStageDetails("Sintática", expSyn, actSyn);

            System.out.println("======================================================================\n");
        }
    }

    private static String getSafe(List<String> list, int index) {
        if (list != null && index < list.size()) {
            return list.get(index);
        }
        return "N/A (Não executado)";
    }

    private static void printStageDetails(String stageName, String expected, String actual) {
        System.out.printf("  [%s]\n", stageName);
        System.out.println("   Esperado: " + expected);
        System.out.println("   Obtido:   " + actual);
        System.out.println();
    }
}