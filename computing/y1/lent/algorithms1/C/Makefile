all: insertion-sort merge-sort quick-sort

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
