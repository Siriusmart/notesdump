all: insertion-sort merge-sort quick-sort quick-select heap-sort counting-sort radix-sort

radix-sort: radix-sort.o
	gcc -o radix-sort radix-sort.o a1-utils.o

counting-sort: counting-sort.o
	gcc -o counting-sort counting-sort.o a1-utils.o

heap-sort: heap-sort.o
	gcc -o heap-sort heap-sort.o -g -O0

quick-select: quick-select.o a1-utils.o
	gcc -o quick-select quick-select.o a1-utils.o

insertion-sort: insertion-sort.o a1-utils.o
	gcc -o insertion-sort insertion-sort.o a1-utils.o

insertion-sort.o: insertion-sort.c a1-utils.h
	gcc -c insertion-sort.c

merge-sort: merge-sort.o a1-utils.o
	gcc -o merge-sort merge-sort.o a1-utils.o

merge-sort.o: merge-sort.c a1-utils.h
	gcc -c merge-sort.c

quick-sort: quick-sort.o a1-utils.o
	gcc -o quick-sort quick-sort.o a1-utils.o

quick-sort.o: quick-sort.c a1-utils.h
	gcc -c quick-sort.c

# Compile the utility file into an object file
a1-utils.o: a1-utils.c a1-utils.h
	gcc -c a1-utils.c

clean:
	rm *.o
