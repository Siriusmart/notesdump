#include <limits.h>
#include <stdio.h>
#include "./a1-utils.h"

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int* arr, int p, int r) {
    int x = arr[r - 1];

    int i = p - 1;

    for (int j = p; j < r - 1; j++)
        if (arr[j] <= x)
            swap(arr + j, arr + ++i);

    swap(arr + r - 1, arr + i + 1);
    return i + 1;
}

int quick_select(int* arr, int p, int r, int i) {
    if (r - p == 1)
        return arr[p];

    int k = partition(arr, p, r);

    if (k == i)
        return arr[k];
    else if (k > i)
        return quick_select(arr, p, k, i);
    else
        return quick_select(arr, k + 1, r, i - k);
}

int main(void) {
    int arr[10] = {5, 9, 3, 1, 3, 4, 2, 0, 8, 7};

    print_int_arr(arr, 10);
    for (int i = 0; i < 10; i++) {
        int selected = quick_select(arr, 0, 10, i);
        printf("%d\n", selected);
    }
}
