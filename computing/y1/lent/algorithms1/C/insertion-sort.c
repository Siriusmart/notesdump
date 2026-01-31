#include "./a1-utils.h"

void insert(int* xs, int n, int x) {
    int i = n - 1;
    for (; xs[i] > x && i >= 0; i--) {
        xs[i + 1] = xs[i];
    }

    xs[i + 1] = x;
}

void insertion_sort(int* xs, int n) {
    for (int len = 0; len < n; len++) {
        insert(xs, len, xs[len]);
    }
}

int main(void) {
    int arr[10] = {5, 9, 3, 1, 3, 4, 2, 0, 8, 7};

    print_int_arr(arr, 10);
    insertion_sort(arr, 10);
    print_int_arr(arr, 10);
}
