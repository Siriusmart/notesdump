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

void quick_sort(int* arr, int p, int r) {
    if (r - p < 2)
        return;

    int q = partition(arr, p, r);
    quick_sort(arr, p, q);
    quick_sort(arr, q + 1, r);
}

int main(void) {
    int arr[10] = {5, 9, 3, 1, 3, 4, 2, 0, 8, 7};

    print_int_arr(arr, 10);
    quick_sort(arr, 0, 10);
    print_int_arr(arr, 10);
}
