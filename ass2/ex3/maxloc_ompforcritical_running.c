#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <omp.h>
#include <math.h>

#define REPEAT 100

double mysecond();

int main(int argc, char* argv[]){
	
	#define N 1000000
	int threads = 32;
	if (argc > 1)
		threads = atoi(argv[1]);
	
	// Initialize x array
	double x[N];
	srand(time(0));
	for(int i=0; i < N;i++){
		x[i] = ((double)(rand()) / RAND_MAX)*((double)(rand()) / RAND_MAX)*((double)(rand()) / RAND_MAX)*1000;
	}
	
	// Compute maxloc and maxval                                                          
	double maxval = 0.0;
	int maxloc = 0;
	
	omp_set_num_threads(threads);
	double t1,t2,sum,sumsq;
	t1 = mysecond();
	for (int l = 0; l < REPEAT; l++) {
		t1 = mysecond();
		#pragma omp parallel for
	  	for (int i=0; i < N; i++){
			#pragma omp critical
			{
				if (x[i] > maxval) {
					maxval = x[i];
					maxloc = i;
				}
			}
	  	}	
	  	t2 = mysecond();
		sum += (t2-t1);
		sumsq += (t2-t1)*(t2-t1);
  	}
  	
	double average,std;
	average = sum / REPEAT;
	std = sqrt((sumsq/(double)REPEAT - average*average) * REPEAT/(double)(REPEAT - 1));

  	// Print out
  	printf("threads: %d, maxloc=%d, maxval=%lf, exec_time: %11.8f +- (%11.8f) s\n", threads, maxloc, maxval, average, std);
	
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
