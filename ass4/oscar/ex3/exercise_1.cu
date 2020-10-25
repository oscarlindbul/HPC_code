#include <stdio.h>
#define N 256
#define TPB 256

__global__ void print()
{
  int t_ind = blockIdx.x*blockDim.x + threadIdx.x;
  printf("Hello World! My threadId is %d from block %d\n", t_ind, blockIdx.x);
}

int main()
{
  print<<<N/TPB, TPB>>>();
  cudaDeviceSynchronize();
  return 0;
}
