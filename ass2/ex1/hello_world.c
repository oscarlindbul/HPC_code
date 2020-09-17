#include <stdio.h>
#include <omp.h>

<<<<<<< HEAD
int main() {
	#pragma omp parallel
	{
		printf("Hello world from %d!\n", omp_get_thread_num());
	}
=======
int main(){
	
	omp_set_num_threads(4);
	int id;
	#pragma omp parallel private(id)
	{
		id = omp_get_thread_num();
		printf("Hello world from thread %d!\n", id);
	}
	
	return 0;
>>>>>>> ba3e2303f0a6dbea0b94251b165c7bbf7a55242b
}
