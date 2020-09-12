#define N 5000
#include <stdio.h>
#include <sys/time.h>

double mysecond();

int main(int argc, char **argv){
  int i, j;
  double t1, t2; // timers                                                         
  double a[N], b[N], c[N]; // arrays
  int N_iter = atoi(argv[1]);
                                             
  // init arrays                                                                   
  for (i = 0; i < N; i++){
    a[i] = 47.0;
    b[i] = 3.1415;
  }

  // measure performance

  for (i = 0; i< N; i++) {
  	c[i] = a[i]*b[i]; // avoid cold-start
  }
  t1 = mysecond();
  for (j = 0; j < N_iter; j++) { // average over several outer loops
	  for(i = 0; i < N; i++)
		c[i] = a[i]*b[i];
  }
  t2 = mysecond();

  double sum = 0;
  for (i = 0; i < N; i++) {
	sum += c[i];
  }

  if (sum < 10) { // use result
  	printf("Error, value too small");
	return 1;
  }

  printf("Total execution time: %11.8f s\nAverage execution time %11.8f\n", (t2 - t1), (t2-t1)/(double)N_iter);
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
