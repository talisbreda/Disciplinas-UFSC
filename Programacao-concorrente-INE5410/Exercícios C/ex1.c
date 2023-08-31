#include <stdio.h>
#include <stdlib.h>

typedef struct MinMax {
    int min;
    int max;
} MinMax;

MinMax* getMinMax(int* array, const int SIZE) {
    MinMax* minmax = (MinMax*) malloc(SIZE*sizeof(int)*2);
    minmax->min = 999999;
    minmax->max = 0;
    for (int i = 0; i < SIZE; i++) {
        int aux = array[i];
        printf("min: %d, max: %d\n", minmax->min, minmax->max);
        printf("aux: %d\n", aux);
        if (aux > minmax->max) {
            minmax->max = aux;
        }
        if (aux < minmax->min) {
            minmax->min = aux;
        }
    }

    return minmax;
}

int main() {
    int array[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, -2, 15};
    MinMax* mx = getMinMax(array, sizeof(array)/sizeof(array[0]));
    printf("min: %d, max: %d\n", mx->min, mx->max);
    return 0;
}