#include <stdlib.h>
#include "./a1-utils.h"

int max(int* arr, int n) {
    int m = -1;

    for (int i = 0; i < n; i++)
        if (arr[i] > m)
            m = arr[i];

    return m;
}

int* counting_sort(int* arr, int n, int max) {
    int c[max + 1];
    int* out = malloc(sizeof(*out) * n);

    for (int i = 0; i < max + 1; i++)
        c[i] = 0;

    for (int i = 0; i < n; i++)
        c[arr[i]] += 1;

    for (int i = 1; i < max + 1; i++)
        c[i] += c[i - 1];

    for (int i = 0; i < n; i++)
        out[--c[arr[i]]] = arr[i];

    return out;
}

int main(void) {
    int arr[10] = {5, 6, 3, 1, 5, 3, 1, 6, 5, 8};
    print_int_arr(arr, 10);
    int* out = counting_sort(arr, 10, 8);
    print_int_arr(out, 10);
}
