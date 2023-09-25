#include <cstdio>

int* g(int* a) {
    return a++;
}
int f(int a) {
    return *g(&a);
}

int main() {
    printf("%d\n", f(23));
}