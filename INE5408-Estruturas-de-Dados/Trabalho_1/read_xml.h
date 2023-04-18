#include <stdio.h>
#include <iostream>
#include <fstream>

using namespace std;

class XMLReader {
private:
    ifstream file;
    std::string content;
public:
    XMLReader(const std::string& path) {
        file.open(path);
        content.assign( 
            (std::istreambuf_iterator<char>(file)),
            (std::istreambuf_iterator<char>()) 
        );
    }
    ~XMLReader() {
        file.close();
    }

    void check() {
        printf("aaaaa");
        // std::cout << content;
    }
};