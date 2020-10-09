#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>
#include <time.h>

#define SEED     921
#define NUM_ITER 1000000000

int main(int argc, char* argv[])
{
    int count = 0;
    double x, y, z, pi;
    int provided, rank, procs, iter_per_proc, tree_depth;
	double t1,t2, time;

	MPI_Init_thread(&argc, &argv, MPI_THREAD_SINGLE, &provided);

	MPI_Comm_size(MPI_COMM_WORLD, &procs);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    srand(SEED*(rank+1)); // Important: Multiply SEED by "rank" when you introduce MPI!

	// timing
    t1 = MPI_Wtime();

	iter_per_proc = NUM_ITER / procs;
	tree_depth = (int)log2(procs);

    // Calculate PI following a Monte Carlo method
    for (int iter = 0; iter < iter_per_proc; iter++)
    {
        // Generate random (X,Y) points
        x = (double)random() / (double)RAND_MAX;
        y = (double)random() / (double)RAND_MAX;
        z = sqrt((x*x) + (y*y));
        
        // Check if point is in unit circle
        if (z <= 1.0)
        {
            count++;
        }
    }
   
   	// timing without Montecarlo counting
	t1 = MPI_Wtime();

	int stride = 1;
	int tmp;
	for (int level = 0; level < tree_depth; level++) {
		if (rank % (2*stride) == 0) {
			MPI_Recv(&tmp, 1, MPI_INT, rank+stride, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
			count += tmp;
		}
		else if (rank % (2*stride) == stride) {
			MPI_Send(&count, 1, MPI_INT, rank-stride, 0, MPI_COMM_WORLD);
		}
		stride *= 2;
	}
	if (rank == 0) {
    	// Estimate Pi and display the result
		pi = ((double)count / (double)NUM_ITER) * 4.0;
	}	
	t2 = MPI_Wtime();
	
	if (rank == 0) {
		time = t2-t1;

		printf("The result is %f , Execution time: %.6e\n", pi, time);
	}

	MPI_Finalize();
    return 0;
}

