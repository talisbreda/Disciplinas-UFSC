#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <tuple>
#include <map>
#include <functional>

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

bool checkSyntax(
        char aux, 
        bool &inTag, 
        bool &inClosingTag, 
        std::string &tag, 
        std::vector<std::string> &pilha, 
        std::vector<std::string> &tagSequence) {

    if (inTag) {
        
        if (aux == '/') {
            inClosingTag = true;
            inTag = false;
            return true;
        }

        if (aux == '<') {
            printf("erro\n");
            return false;
        }
        
        if (aux != '>') {
            tag += aux;
        } else {
            if (!pilha.empty() && tag == pilha.back()) {
                printf("erro\n");
                pilha.pop_back();
                return false;
            } else {
                if (tag == tagSequence.back()) {
                    pilha.push_back(tag);
                    tagSequence.pop_back();
                } else {
                    printf("erro\n");
                    return false;
                }
            }
            tag = "";
            inTag = false;
            return true;
        }
    }

    if (inClosingTag) {
        if (aux != '>') {
            tag += aux;
        } else {
            inClosingTag = false;
            std::string top = pilha.back();
            if (top == tag) {
                tag = "";
                pilha.pop_back();
                if (tagSequence.empty()) tagSequence = {"matriz", "y", "x", "robo", "largura", "altura", "dimensoes", "nome", "cenario"};
                return true;
            } else {
                printf("erro\n");
                tag = "";
                return false;
            }
        }
    }

    if (aux == '<') {
        inTag = true;
    }

    return true;
}

bool checkIfStackIsEmpty(std::vector<std::string> &pilha) {
    if (!pilha.empty()) {
        printf("erro\n");
        for (std::vector<std::string>::iterator it = pilha.begin(); it != pilha.end(); ++it) {
            std::cout << "\n    - " << *it;
        }
        std::cout << "\n";
        return false;
    }
    return true;
}

void appendToString(std::string &s, char aux) {
    std::string auxString(&aux, 1);
    s.append(auxString);
}

int storeMatrixDataAndSkip(
        int posInicial,
        int& lineCounter,
        std::string &s_x, 
        std::string &s_y, 
        std::string &s_altura, 
        std::string &s_largura, 
        std::string &nome, 
        std::map<std::string, std::vector<int>> &map) 
    {
    int altura = std::stoi(s_altura);
    int largura = std::stoi(s_largura);
    int x = std::stoi(s_x);
    int y = std::stoi(s_y);

    std::vector<int> vetor = {posInicial, x, y, altura, largura};
    
    map[nome] = vetor;

    s_x.clear();
    s_y.clear();
    s_altura.clear();
    s_largura.clear();
    nome.clear();
    lineCounter += altura;

    return altura * (largura + 1)-1;
}

std::vector<std::vector<int>> getMatrix(std::string xml, int start, int end) {
    std::vector<std::vector<int>> matrix;
    int lineCounter = 0;
    matrix.push_back({});
    for (int i = start; i < end; i++) {
        char aux = xml[i];

        if (aux == '\n') {
            lineCounter++;
            matrix.push_back({});
            continue;
        }

        matrix[lineCounter].push_back(aux-48); // ajuste relacionado ao valor ASCII
    }

    return matrix;
}

int solveMatrix(int x, int y, int altura, int largura, std::vector<std::vector<int>> &matrix) {
    std::vector<std::tuple<int, int>> fila;
    int counter = 0;
    fila.emplace_back(x, y);
    if (matrix[x][y] == 0) return 0;
    while (!fila.empty()) {
        matrix[x][y] = 0;
        fila.erase(fila.begin());

        counter++;

        if (x < altura-1 && matrix[x+1][y]) {
            fila.emplace_back(x+1, y);
            matrix[x+1][y] = 0;
        }
        if (y < largura-1 && matrix[x][y+1]) {
            fila.emplace_back(x, y+1);
            matrix[x][y+1] = 0;
        }
        if (x > 0 && matrix[x-1][y]) {
            fila.emplace_back(x-1 ,y);
            matrix[x-1][y] = 0;
        }
        if (y > 0 && matrix[x][y-1]) {
            fila.emplace_back(x, y-1);
            matrix[x][y-1] = 0;
        }

        std::tie(x, y) = fila.front();
    }
    return counter;
}

void solveMatrices(std::map<std::string, std::vector<int>> matrixDataMap, std::string xml) {
    for (auto matrixData : matrixDataMap) {
        int start = matrixData.second[0];
        int x = matrixData.second[1];
        int y = matrixData.second[2];
        int altura = matrixData.second[3];
        int largura = matrixData.second[4];
        int end = start + (altura * (largura+1));
        char* nome = (char*)matrixData.first.c_str();

        std::vector<std::vector<int>> matrix = getMatrix(xml, start, end);

        int total = solveMatrix(x, y, altura, largura, matrix);

        printf("%s %d\n", nome, total);
    }
}

int main() {
    std::string filePath;
    std::cin >> filePath;

    std::string fileContents = readFileToString(filePath);

    std::vector<std::string> pilha;

    bool inTag = false;
    bool inClosingTag = false;
    bool xmlCorrect = true;

    int lineCounter = 1;
    std::string tag;

    std::map<std::string, std::vector<int>> matrixDataMap;
    std::string s_altura;
    std::string s_largura;
    std::string nome;
    std::string s_x;
    std::string s_y;

    std::vector<std::string> tagSequence = {"matriz", "y", "x", "robo", "largura", "altura", "dimensoes", "nome", "cenario", "cenarios"};

    for (std::string::size_type i = 0; i < fileContents.size(); ++i) {
        char aux = fileContents[i];

        if (aux == '\n') {
            lineCounter++;
        }

        xmlCorrect = checkSyntax(aux, inTag, inClosingTag, tag, pilha, tagSequence);
        if (!xmlCorrect) break;

        if (!pilha.empty()) {
            if (isdigit(aux)) {
                if (pilha.back() == "altura") {
                    appendToString(s_altura, aux);
                }
                if (pilha.back() == "largura") {
                    appendToString(s_largura, aux);
                }
                if (pilha.back() == "x") {
                    appendToString(s_x, aux);
                }
                if (pilha.back() == "y") {
                    appendToString(s_y, aux);
                }
                if (pilha.back() == "matriz") {
                    i += storeMatrixDataAndSkip(i, lineCounter, s_x, s_y, s_altura, s_largura, nome, matrixDataMap);
                }
            }
            if (pilha.back() == "nome" && aux != '<' && aux != '>' && !inClosingTag) {
                appendToString(nome, aux);
            }
        }     
        
    }
    if (xmlCorrect) {
        xmlCorrect = checkIfStackIsEmpty(pilha);
    } else {
        return 0;
    }

    if (xmlCorrect) {
        solveMatrices(matrixDataMap, fileContents);
    }

    return 0;
}