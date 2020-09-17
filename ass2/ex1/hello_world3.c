#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main() {
	#pragma omp parallel num_threads(2)
	{
		printf("Hello world from %d!\n", omp_get_thread_num());
	}
}
