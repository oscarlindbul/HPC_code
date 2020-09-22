#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <omp.h>
#include <math.h>

#define REPEAT 100

double mysecond();

struct max_data { double maxval; int maxloc; char padding[128]; }; 

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
	struct max_data data_t[32];
	double maxval;
	int maxloc;

	omp_set_num_threads(threads);
	double t1,t2,t3,t4,sum,sumsq;
	t3 = mysecond();
	for (int l = 0; l < REPEAT; l++) {
            t1 = mysecond();
            #pragma omp parallel
            {
                int t = omp_get_thread_num();
                data_t[t].maxval = -1e30;
                #pragma omp for
                for (int i=0; i < N; i++){
                    if (x[i] > data_t[t].maxval) {
                        data_t[t].maxval = x[i];
                        data_t[t].maxloc = i;
                    }
                }
            }	
            
            maxval = data_t[0].maxval;
            maxloc = data_t[0].maxloc;
            for (int i = 1; i < threads; i++) {
                if (x[data_t[i].maxloc] > maxval)
                {
                    maxval = data_t[i].maxval;
                    maxloc = data_t[i].maxloc;
                }
            }
            t2 = mysecond();
            sum += (t2-t1) / (double)REPEAT;
            sumsq += (t2-t1)*(t2-t1) / (double)REPEAT;
  	}
	t4 = mysecond() - t3;
  	
	double average,std;
	average = sum;
	std = sqrt((sumsq - average*average) * REPEAT/(double)(REPEAT - 1));

  	// Print out
  	printf("threads: %d, maxloc=%d, maxval=%lf, exec_time: %11.8f +- (%11.8f) s, total time: %11.8f\n", threads, maxloc, maxval, average, std, t4);
	
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
