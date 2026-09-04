Como executar:

É necessário ter Java 21 instalado na máquina e devidamente configurado.

O repositório já inclui o executável lexgen.jar. Para executar o programa, utilize o seguinte comando no terminal:

```java -jar lexger.jar [FLAGS] [ARGS]```

As flags são:
- `--auto` ou `-a`: Roda os testes automatizados
- `--manual` ou `-m`: Roda o programa em modo manual
- `--help` ou `-h`: Mostra a ajuda do programa
- `--lexical` ou `-l`: Roda em modo manual, somente a análise léxica
- `--syntactic` ou `-s`: Roda em modo manual, somente a análise sintática

O argumento é o número do teste que deseja executar. Caso não haja número, será executado o teste no diretório
src/main/resources/teste_manual.

Caso se deseje testar um caso diferente, é recomendado alterar somente os arquivos dentro de teste_manual, para não 
interferir no funcionamento dos testes automáticos.