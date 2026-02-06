#include <stdio.h>
#include <stdlib.h>
struct vector {
    int* first;
    int capacity;
    int length;
};

typedef struct vector* vector;

vector vec_make() {
    vector out_ptr = malloc(sizeof(*out_ptr));
    *out_ptr = (struct vector){
        .first = malloc(1 * sizeof(int)), .capacity = 1, .length = 0};
    return out_ptr;
}

void vec_insert(vector v, int i, int n) {
    if (i > v->length) {
        printf("index out of bounds: inserting to index %d of vec length %d\n",
               i, v->length);
        exit(1);
    }

    if (v->length == v->capacity) {
        v->capacity *= 2;
        int* new_ptr = malloc(v->capacity * sizeof(*new_ptr));

        for (int j = 0; j < v->length; j++)
            new_ptr[j] = v->first[j];

        free(v->first);
        v->first = new_ptr;
    }

    for (int j = i; j < v->length; j++)
        v->first[j + 1] = v->first[j];

    v->first[i] = n;
    v->length++;
}

void vec_push(vector v, int n) {
    vec_insert(v, v->length, n);
}

int vec_get(vector v, int i) {
    if (i >= v->length) {
        printf("index out of bounds: getting index %d of vec length %d\n", i,
               v->length);
        exit(1);
    }

    return v->first[i];
}

void vec_set(vector v, int i, int n) {
    if (i > v->length) {
        printf("index out of bounds: getting index %d of vec length %d\n", i,
               v->length);
        exit(1);
    }

    if (i == v->length)
        vec_push(v, n);
    else
        v->first[i] = n;
}

int vec_length(vector v) {
    return v->length;
}

void vec_swap(vector v, int i, int j) {
    int a = vec_get(v, i);
    vec_set(v, i, vec_get(v, j));
    vec_set(v, j, a);
}

void vec_pop(vector v) {
    v->length--;
}

void vec_print(vector v) {
    printf("[");

    for (int i = 0; i < vec_length(v); i++) {
        if (i)
            printf(", ");

        printf("%d", vec_get(v, i));
    }

    printf("]\n");
}

typedef vector max_heap;

int max_is_empty(max_heap h) {
    return h->length == 0;
}

int max_peek(max_heap h) {
    if (max_is_empty(h)) {
        printf("peaking empty heap\n");
        exit(1);
    }

    return vec_get(h, 0);
}

void max_reheapify(max_heap h, int i) {
    if (vec_length(h) <= i)
        return;

    if (2 * i < vec_length(h) && vec_get(h, i) < vec_get(h, 2 * i)) {
        vec_swap(h, i, 2 * i);
        max_reheapify(h, 2 * i);
    }

    if (2 * i + 1 < vec_length(h) && vec_get(h, i) < vec_get(h, 2 * i + 1)) {
        vec_swap(h, i, 2 * i + 1);
        max_reheapify(h, 2 * i + 1);
    }
}

void max_full_heapify(max_heap h, int i) {
    for (int i = vec_length(h) / 2; i >= 0; i--) {
        max_reheapify(h, i);
    }
}

int max_extract(max_heap h) {
    int n = max_peek(h);
    vec_swap(h, 0, vec_length(h) - 1);
    vec_pop(h);
    return n;
}

void heap_sort(vector v) {
    int original = v->length;

    max_heap h = v;
    max_full_heapify(h, 0);

    while (vec_length(h)) {
        vec_swap(h, 0, vec_length(h) - 1);
        vec_pop(h);
        max_reheapify(h, 0);
    }

    v->length = original;
}

int main(void) {
    vector v = vec_make();
    vec_push(v, 5);
    vec_push(v, 2);
    vec_push(v, 6);
    vec_push(v, 1);
    vec_push(v, 9);
    vec_push(v, 8);

    heap_sort(v);

    vec_print(v);
}
