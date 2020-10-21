#include <stdio.h>
#define N 256
#define TPB 128

__global__ void print()
{
  const int i = blockIdx.x*blockDim.x + threadIdx.x;
  printf("Hello World! My threadId is %d\n", i);
}

int main()
{
  print<<<N/TPB, TPB>>>();
  cudaDeviceSynchronize();
  return 0;
}
