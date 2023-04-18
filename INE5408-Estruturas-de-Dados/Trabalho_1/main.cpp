#include <iostream>
#include "read_xml.h"

using namespace std;

int main() {
    std::string path = "./cenarios1.xml";
    XMLReader reader = XMLReader(path);
    reader.check();
    return 0;
}
