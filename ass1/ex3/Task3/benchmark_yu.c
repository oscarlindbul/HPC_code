#define N 5000
#include <stdio.h>
#include <sys/time.h>

#define REPEAT 10000

double mysecond();

int main(){
  int i, j;
  double t1, t2; // timers                                                         
  double a[N], b[N], c[N]; // arrays  
                                             
  // init arrays                                                                   
  for (i = 0; i < N; i++){
    a[i] = 47.0;
    b[i] = 3.1415;
  }

  for(i = 0; i < N; i++)
    c[i] = a[i]*b[i];

  // measure performance                                                           
   	t1 = mysecond();
  for(i = 0; i < REPEAT; i++){
  	for(j = 0; j< N; j++)
    	c[j] = a[j]*b[j];
  }
t2 = mysecond();

  double sum;
  for(i = 0; i < N; i++)
    sum = c[i] + sum;
    
  printf("sum=%f\n", sum);
    
  printf("Execution time: %11.8f s\n", (t2 - t1)/REPEAT);
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
