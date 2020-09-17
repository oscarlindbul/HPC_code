#include <stdio.h>
#include <omp.h>

int main() {
	#pragma omp parallel
	{
		printf("Hello world from %d!\n", omp_get_thread_num());
	}
}
