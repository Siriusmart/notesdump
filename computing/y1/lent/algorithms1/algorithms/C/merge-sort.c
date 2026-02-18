#include <limits.h>
#include "./a1-utils.h"

void merge(int* arr, int p, int q, int r) {
    int sub1[q - p + 1], sub2[r - q + 1];

    for (int i = p; i < q; i++)
        sub1[i - p] = arr[i];
    for (int i = q; i < r; i++)
        sub2[i - q] = arr[i];

    sub1[q - p] = INT_MAX;
    sub2[r - q] = INT_MAX;

    int i = 0, j = 0;

    for (int k = 0; k < r - p; k++)
        if (sub1[i] < sub2[j])
            arr[k] = sub1[i++];
        else
            arr[k] = sub2[j++];
}

void merge_sort(int* arr, int p, int r) {
    if (r - p < 2)
        return;

    int q = (p + r) / 2;
    merge_sort(arr, p, q);
    merge_sort(arr, q, r);
    merge(arr, p, q, r);
}

int main(void) {
    int arr[10] = {5, 9, 3, 1, 3, 4, 2, 0, 8, 7};

    print_int_arr(arr, 10);
    merge_sort(arr, 0, 10);
    print_int_arr(arr, 10);
}
