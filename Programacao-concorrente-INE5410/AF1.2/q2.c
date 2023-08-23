#include <cstdio>

int bissexto(int x) {
    if (x % 4 == 0) {
        if (x % 100 == 0) return 0;
        else if (!(x % 400)) return 1;
        return 1;
    }

}


int main() {
    printf("%d\n", bissexto(2000));
    printf("%d\n", bissexto(2020));
    printf("%d\n", bissexto(2200));
    // printf("%d\n", bissexto(2021));
    // printf("%d\n", bissexto(2024));
    return 0;
}