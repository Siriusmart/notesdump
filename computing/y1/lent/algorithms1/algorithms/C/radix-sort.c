#include "./a1-utils.h"

void bitwise_insort(int* arr, int n, int j) {
    int comparer = 1 << j;

    for (int i = 1; i < n; i++) {
        if (arr[i] & comparer)
            continue;

        int temp = arr[i];
        int cursor = i;

        for (; cursor > 0 && (comparer & arr[cursor - 1]); cursor--)
            arr[cursor] = arr[cursor - 1];

        arr[cursor] = temp;
    }
}

void radix_sort(int* arr, int n) {
    for (int i = 0; i < sizeof(int) * 8 - 1; i++)
        bitwise_insort(arr, n, i);
}

int main(void) {
    int arr[10] = {12, 35, 14, 65, 13, 75, 3, 56, 13, 40};
    print_int_arr(arr, 10);
    radix_sort(arr, 10);
    print_int_arr(arr, 10);
}
