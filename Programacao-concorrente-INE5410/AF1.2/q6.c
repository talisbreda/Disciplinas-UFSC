#include <cstdio>

int f(int a) {
    if (a % 2 != 0 && a < 20) {
        return a;
    } else if (&a) {
        if (a < 0) return 2*a;
    } else {
        return 27;
    }
    return 31;
}

int main() {
    printf("%d\n", f(2));
}