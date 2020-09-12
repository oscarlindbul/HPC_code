#include <stdio.h>

int main(int argc, char* argv[]) {
	int nnz, nrows;
	nnz = atoi(argv[1]);
	nrows = atoi(argv[2]);
	
	unsigned long size = (nnz+nrows)*(sizeof(double) + sizeof(int));
    printf("%lu\n", size);
	return 0;
}
