#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main(int argc, char* argv[]) {
	int threads = atoi(argv[1]);
	omp_set_num_threads(threads);
	printf("Number of threads: %d vs %d\n", threads, omp_get_num_threads());
	#pragma omp parallel
	{
		printf("Hello world from %d!\n", omp_get_thread_num());
	}
}
