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
        this->filhos = std::vector<TrieNode*>();
    }

    TrieNode(char letra, int posicao) {
        this->letra = letra;
        this->posicao = posicao;
        this->comprimento = -1;
        this->filhos = std::vector<TrieNode*>();
    }

    TrieNode() {
        this->letra = '\0';
        this->comprimento = -1;
        this->filhos = std::vector<TrieNode*>();
    }

    bool contains(char value) {
        // for (auto i = 0u; i < 26; i++) {
        //     // if (filhos[i]->letra == value) {
        //     //     return true;
        //     // }
        //     std::cout << filhos[i];
        // }
        return false;
    }

    int countWords() {
        int count = 0;
        if (this->comprimento != -1) {
            count++;
        }
        for (auto i = 0u; i < 26; i++) {
            if (this->filhos[i] != nullptr) {
                count += this->filhos[i]->countWords();
            }
        }
        return count;
    }

    TrieNode* find(char value) {
        TrieNode* aux = new TrieNode(value);
        auto it = std::find(filhos.begin(), filhos.end(), aux);
        if (it != filhos.end()) {
            return *it;
        }
        return nullptr;
    }

    char letra;
    std::vector<TrieNode*> filhos;
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

void setLineLength(TrieNode *node, std::string word, int length) {
    for (auto i = 0u; i < word.size(); i++) {
        node = node->filhos[word[i] - 'a'];
    }
    node->comprimento = length;
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

    for (auto i = 0u; i < fileContents.size(); i++) {
        char aux = fileContents[i];

        if (aux == '\n') {
            setLineLength(root, word, lineLength);
            word = "";
            lineLength = 0;
            continue;
        } else {
            lineLength++;
        }
        
        if (aux == '[') {
            inWord = true;
            posicao = i;
            continue;
        }

        if (inWord) {
            if (aux == ']') {
                inWord = false;
                currentNode = root;
            } else {
                word += aux;
                if (!currentNode->contains(aux)) {
                    TrieNode* newnode = new TrieNode(aux, posicao);
                    currentNode->filhos.push_back(newnode);
                }
                currentNode = currentNode->find(aux);
            }
        }
    }
    
    while (true) {
        currentNode = root;
        std::cin >> word;
        if (word.compare("0") == 0) {
            break;
        }
        int prefixCounter = 1;

        for (auto i = 0u; i < word.size(); i++) {
            if (!currentNode->contains(word[i])) {
                std::cout << word + "is not prefix" << std::endl;
                break;
            } else {
                currentNode = currentNode->find(word[i]);
            }
        }

        int prefixCount = 1;
        if (currentNode->filhos.empty()) {
            std::cout << word + "is prefix of 1 words" << std::endl;
            break;
        } else {
            prefixCount = currentNode->countWords();
        }

        printf("%s is prefix of %d words\n", word.c_str(), prefixCount);
        printf("%s is at (%d, %d)\n", word.c_str(), currentNode->posicao, currentNode->comprimento);
    }

    return 0;
}

