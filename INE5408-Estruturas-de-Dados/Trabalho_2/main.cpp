#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <algorithm>

class TrieNode {
    public:

    char letra;
    TrieNode* filhos[26];
    int posicao;
    int comprimento;

    /* Construtor para nodos da lista */
    explicit TrieNode(char letra, int posicao) {
        this->letra = letra;
        this->posicao = posicao;
        this->comprimento = -1;
        initializeFilhos();
    }

    /* Construtor para o nodo raiz */
    TrieNode() {
        this->letra = '\0';
        this->comprimento = -1;
        initializeFilhos();
    }

    /* Destrutor recursivo */
    ~TrieNode() {
        for (auto i = 0u; i < 26; i++) {
            if (this->filhos[i] != nullptr) delete filhos[i];
        }
    }

    void initializeFilhos() {
        for (auto i = 0u; i < 26; i++) {
            this->filhos[i] = nullptr;
        }
    }

    bool contains(char value) {
        return this->filhos[value - 'a'] != nullptr;
    }

    int countPrefixes() {
        int count = 0;
        if (this->comprimento != -1) {
            count++;
        }
        for (auto i = 0u; i < 26; i++) {
            if (this->filhos[i] != nullptr) {
                count += this->filhos[i]->countPrefixes();
            }
        }
        return count;
    }

    TrieNode* get(char value) {
        return this->filhos[value - 'a'];
    }

};


std::string readFileToString(const std::string& filePath) {
    std::ifstream file(filePath);

    if (!file.is_open()) {
        std::cerr << "Error opening file: " << filePath << std::endl;
        return "";
    }

    std::stringstream buffer;
    buffer << file.rdbuf();

    std::string fileContents = buffer.str();

    file.close();

    return fileContents;
}

void readAndStoreFileContents(std::string fileContents, TrieNode *root) {
    TrieNode *currentNode = root;

    bool inWord;
    int position;
    int lineLength = 0;
    char previousLetter = '\0';
    char letter = '\0';

    for (auto i = 0u; i < fileContents.size(); i++) {
        previousLetter = letter;
        letter = fileContents[i];

        /* Se a letra atual for um '\n', ou for a última do arquivo, resetamos o comprimento da linha atual e voltamos para o nodo raiz */
        if (letter == '\n' || i == fileContents.size() - 1) {
            currentNode->comprimento = lineLength;
            lineLength = 0;
            currentNode = root;
            continue;
        } else { /* Se não, incrementamos o comprimento da linha atual */
            lineLength++;
        }
        
        /* Se estivermos na primeira letra ou tivermos um '\n' seguido de um '[', iniciamos a leitura de uma palavra */
        if (i == 0 || (letter == '[' && previousLetter == '\n')) {
            inWord = true;
            position = i;
            continue;
        }

        /* Se estivermos dentro de uma palavra, adicionamos a letra atual ao nodo atual */
        if (inWord) {
            if (letter == ']') {
                inWord = false;
            } else if (!currentNode->contains(letter)) {
                TrieNode* newnode = new TrieNode(letter, position);
                currentNode->filhos[letter - 'a'] = newnode;
                currentNode = newnode;
            } else {
                currentNode = currentNode->get(letter);
            }
            
        }
    }
}

void analyzeInputAndPrintResult(TrieNode *root) {
    while (true) {
        TrieNode* currentNode = root;
        std::string word;

        std::cin >> word;

        /* Quebra a execução caso o input seja 0 */
        if (word.compare("0") == 0) {
            break;
        }

        /* Viaja pelos nodos até chegar ao fim da palavra atual */
        bool isNotPrefix = false;
        for (auto i = 0u; i < word.size(); i++) {
            if (currentNode->contains(word[i])) {
                currentNode = currentNode->get(word[i]);
            } else {
                isNotPrefix = true;
                break;
            }
        }

        /* Conta a quantidade de prefixos que a palavra atual tem */
        int prefixCount = currentNode->countPrefixes();

        /* Imprime o resultado */
        if (isNotPrefix) {
            printf("%s is not prefix\n", word.c_str());
        } else if (currentNode->comprimento == -1) {
            printf("%s is prefix of %d words\n", word.c_str(), prefixCount);
        } else {
            printf("%s is prefix of %d words\n", word.c_str(), prefixCount);
            printf("%s is at (%d,%d)\n", word.c_str(), currentNode->posicao, currentNode->comprimento);
        }
    }
}

int main() {
    
    std::string filePath;
    std::cin >> filePath;

    std::string fileContents = readFileToString(filePath);

    TrieNode *root = new TrieNode();

    readAndStoreFileContents(fileContents, root);
    analyzeInputAndPrintResult(root);

    delete root;

    return 0;
}

