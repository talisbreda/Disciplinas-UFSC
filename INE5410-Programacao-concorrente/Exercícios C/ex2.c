#include <stdio.h>
#include <stdlib.h>
#define MAX_SIZE 100

void inputArray(int* arr, int size) 
{
    for (int i = 0; i < size; i++) {
        int num;
        scanf("%d", &num);
        arr[i] = num;
    }
}

void printArray(int* arr, int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
}

int sortAscending(int* num1, int* num2) {
    return *num1 - *num2;
}

int sortDescending(int* num1, int* num2) {
    return *num2 - *num1;
}

void sort(int* arr, int size, int (*compare)(int*, int*)) {
    for (int i = 0; i < size; i++) {
        for (int j = i+1; j < size; j++) {
            if (compare(&arr[i], &arr[j]) > 0) {
                int aux = arr[i];
                arr[i] = arr[j];
                arr[j] = aux;
            }
        }

    }
}

int main(int argc, char const *argv[])
{
    int arr[MAX_SIZE];
    int size;
    /*
    * Input array size and elements.
    */
    printf("Enter array size: ");
    scanf("%d", &size);
    printf("Enter elements in array: ");
    inputArray(arr, size);
    printf("\n\nElements before sorting: ");
    printArray(arr, size);
    // Sort and print sorted array in ascending order.
    printf("\n\nArray in ascending order: ");
    sort(arr, size, sortAscending);
    printArray(arr, size);
    // Sort and print sorted array in descending order.
    printf("\nArray in descending order: ");
    sort(arr, size, sortDescending);
    printArray(arr, size);

    return 0;
}