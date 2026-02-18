#include <stdio.h>

void print_int_arr(int* arr, int n) {
    printf("[");

    for (int i = 0; i < n - 1; i++) {
        printf("%d, ", arr[i]);
    }

    if (n > 0)
        printf("%d", arr[n - 1]);

    printf("]\n");
}
