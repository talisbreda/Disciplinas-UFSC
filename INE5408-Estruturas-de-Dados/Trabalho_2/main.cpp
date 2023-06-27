#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <algorithm>

class TrieNode {
    public:
    explicit TrieNode(char letra) {
        this->letra = letra;
        this->comprimento = -1;
        initializeFilhos();
    }

    TrieNode(char letra, int posicao) {
        this->letra = letra;
        this->posicao = posicao;
        this->comprimento = -1;
        initializeFilhos();
    }

    TrieNode() {
        this->letra = '\0';
        this->comprimento = -1;
        initializeFilhos();
    }

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

    bool filhosEmpty() {
        for (auto i = 0u; i < 26; i++) {
            if (this->filhos[i] != nullptr) {
                return false;
            }
        }
        return true;
    }

    TrieNode* find(char value) {
        return this->filhos[value - 'a'];
    }

    char letra;
    TrieNode* filhos[26];
    int posicao;
    int comprimento;

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

int main() {
    
    std::string filePath;
    std::cin >> filePath;

    std::string fileContents = readFileToString(filePath);

    TrieNode *root = new TrieNode();

    bool inWord;
    std::string word = "";

    TrieNode *currentNode = root;

    int posicao;
    int lineLength = 0;
    int lineCounter = 1;
    char prev = '\0';
    char aux = '\0';

    for (auto i = 0u; i < fileContents.size(); i++) {
        prev = aux;
        aux = fileContents[i];

        if (i == fileContents.size() - 1) {
            currentNode->comprimento = lineLength;
            break;
        }

        if (aux == '\n') {
            // setLineLength(root, word, lineLength);
            currentNode->comprimento = lineLength;
            word = "";
            lineLength = 0;
            lineCounter++;
            currentNode = root;
            continue;
        } else {
            lineLength++;
        }
        
        if (i == 0 || (aux == '[' && prev == '\n')) {
            inWord = true;
            posicao = i;
            continue;
        }

        if (inWord) {
            if (aux == ']') {
                inWord = false;
            } else {
                word += aux;
                if (!currentNode->contains(aux)) {
                    TrieNode* newnode = new TrieNode(aux, posicao);
                    currentNode->filhos[aux - 'a'] = newnode;
                    currentNode = newnode;
                } else {
                    currentNode = currentNode->find(aux);
                    if (currentNode == nullptr) {
                        printf("aaaaaaaa");
                        break;
                    }
                }
            }
        }
    }
    
    while (true) {
        currentNode = root;
        std::cin >> word;
        if (word.compare("0") == 0) {
            break;
        }

        int pos = -1;
        for (auto i = 0u; i < word.size(); i++) {
            if (!currentNode->contains(word[i])) {
                pos = i;
                break;
            } else {
                currentNode = currentNode->find(word[i]);
            }
        }
        int prefixCount = 1;
        if (currentNode != nullptr) {
            prefixCount = currentNode->countPrefixes();
        }

        if (pos != -1 && !currentNode->contains(word[pos])) {
            printf("%s is not prefix\n", word.c_str());
        } else if (currentNode->comprimento == -1) {
            printf("%s is prefix of %d words\n", word.c_str(), prefixCount);
        } else {
            printf("%s is prefix of %d words\n", word.c_str(), prefixCount);
            printf("%s is at (%d,%d)\n", word.c_str(), currentNode->posicao, currentNode->comprimento);
        }
    }

    delete root;

    return 0;
}

