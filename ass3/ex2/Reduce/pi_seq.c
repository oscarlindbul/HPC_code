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
    int provided, rank, procs, iter_per_proc;
	double t1,t2, time;

	MPI_Init_thread(&argc, &argv, MPI_THREAD_SINGLE, &provided);

	MPI_Comm_size(MPI_COMM_WORLD, &procs);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    srand(SEED*(rank+1)); // Important: Multiply SEED by "rank" when you introduce MPI!

	// timing
    t1 = MPI_Wtime();

	iter_per_proc = NUM_ITER / procs;

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
   	int tmp;

	MPI_Reduce(&count, &tmp, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
	if (rank == 0) {
		count = tmp;	
    	// Estimate Pi and display the result
		pi = ((double)count / (double)NUM_ITER) * 4.0;
	}
	t2 = MPI_Wtime();
	double local_time = t2-t1;
	MPI_Reduce(&local_time, &time, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
	
	if (rank == 0) {
		printf("The result is %f , Execution time: %.6e\n", pi, time);
	}

	MPI_Finalize();
    return 0;
}

