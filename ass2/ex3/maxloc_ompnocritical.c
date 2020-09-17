#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <omp.h>

double mysecond();

int main(int argc, char* argv[]){
	
	#define N 1000000
	
	// Initialize x array
	double x[N];
	srand(time(0));
	for(int i=0; i < N;i++){
		x[i] = ((double)(rand()) / RAND_MAX)*((double)(rand()) / RAND_MAX)*((double)(rand()) / RAND_MAX)*1000;
	}
	
	// Compute maxloc and maxval                                                          
	double maxval = 0.0;
	int maxloc = 0;
	
	omp_set_num_threads(32);
	double t1 = mysecond();
	#pragma omp for
  for (int i=0; i < N; i++){
			if (x[i] > maxval) {
				maxval = x[i];
				maxloc = i;
			}
		}
  double t2 = mysecond();
  
  // Print out
  printf("maxloc=%d, maxval=%lf, exec_time=%11.8f s\n", maxloc, maxval, (t2-t1));
	
	return 0;
}

// function with timer                                                             
double mysecond(){
  struct timeval tp;
  struct timezone tzp;
  int i;

  i = gettimeofday(&tp,&tzp);
  return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
}
