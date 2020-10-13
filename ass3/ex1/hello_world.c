#include <mpi.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
	
	MPI_Init(&argc, &argv);

	int rank, proc_num;
	MPI_Comm_size(MPI_COMM_WORLD, &proc_num);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	printf("Hello world from rank %d of %d processes\n", rank, proc_num);

	MPI_Finalize();
}
