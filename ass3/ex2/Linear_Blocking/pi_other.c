
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <mpi.h>

#define SEED     921
#define NUM_ITER 1000000000

int main(int argc, char* argv[])
{
    int count = 0;
    double x, y, z, pi;
    int rank, num_ranks, provided;
    
    MPI_Init_thread(&argc, &argv, MPI_THREAD_SINGLE, &provided);
    
    
    double start_time, stop_time, elapsed_time;
    
    
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &num_ranks);
    
    srand(SEED * rank); // Important: Multiply SEED by "rank" when you introduce MPI!
    
    // Calculate PI following a Monte Carlo method
    for (int iter = 0; iter < NUM_ITER/num_ranks; iter++)
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
    
    // Now the post-process
    start_time = MPI_Wtime();
    int* counts;
    int global_count = 0;
    if(rank == 0){
    	counts = (int*)(malloc((num_ranks-1)*sizeof(int)));
    	for(int i=1; i<num_ranks; i++){
    		MPI_Recv(&counts[i-1], 1, MPI_INT, MPI_ANY_SOURCE, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    	}
    }else{
    	MPI_Send(&count, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
    }
    stop_time = MPI_Wtime();
    
    if(rank==0){
    	global_count += count;
    	for(int i=0; i<num_ranks-1; i++){
    		global_count += counts[i];
    	}
    	// Estimate Pi and display the result
    	pi = ((double)global_count / (double)((NUM_ITER/num_ranks)*num_ranks)) * 4.0;
    }
    
    
    
    if(rank==0){
    	elapsed_time = stop_time - start_time;
    	printf("The result is %f, and the execution: %f \n", pi, elapsed_time);
    }
    
    MPI_Finalize();
    
    return 0;
}

