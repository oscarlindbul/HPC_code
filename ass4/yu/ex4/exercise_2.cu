#include <cuda.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define ARRAY_SIZE 10000
#define TPB 256

inline int GET_BLOCKS(const int n, const int tpb)
{
  return (n + tpb - 1) / tpb;
}

inline int GET_THREADS(const int n, const int tpb)
{
	if(n>=tpb){
		return tpb;
	}else{
		return tpb;
	}
}


__global__ void saxpy_device (int n, float* ptr_x, float* ptr_y, float a)
{
	for (int i = blockIdx.x * blockDim.x + threadIdx.x; i < (n); i += blockDim.x * gridDim.x)
	{
		ptr_y[i] += a * ptr_x[i];
	}	
}

void saxpy_host(int n, float* ptr_x, float* ptr_y, float a)
{
	for (int i=0; i<n; i++){
		ptr_y[i] += a * ptr_x[i];
	}
}

int main()
{
	float a = 2.5;

        float *x_host = (float*)malloc(ARRAY_SIZE * sizeof(float));
        float *y_host = (float*)malloc(ARRAY_SIZE * sizeof(float));
        float *y_device = (float*)malloc(ARRAY_SIZE * sizeof(float));
        float *x_gpu, *y_gpu;
	cudaMalloc((int**)(&x_gpu), ARRAY_SIZE * sizeof(float));
        cudaMalloc((int**)(&y_gpu), ARRAY_SIZE * sizeof(float));

        srand(time(NULL));
        for(int i=0; i<ARRAY_SIZE; i++)  
        {
                float x = ((float)rand()/(float)(RAND_MAX)) * 5.0;
                float y = ((float)rand()/(float)(RAND_MAX)) * 5.0;
                x_host[i] = x;
                y_host[i] = y;
                y_device[i] = y;
        }

        cudaMemcpy(x_gpu, x_host, ARRAY_SIZE*sizeof(float), cudaMemcpyHostToDevice);
        cudaMemcpy(y_gpu, y_device, ARRAY_SIZE*sizeof(float), cudaMemcpyHostToDevice);
	
	printf("Computing SAXPY on CPU ... "); 
        saxpy_host(ARRAY_SIZE, x_host, y_host, a);
	printf("Done!\n");

	printf("Computing SAXPY on GPU ... ");
        saxpy_device<<< GET_BLOCKS(ARRAY_SIZE, TPB), GET_THREADS(ARRAY_SIZE, TPB) >>>(ARRAY_SIZE, x_gpu, y_gpu, a);
        cudaMemcpy(y_device, y_gpu, ARRAY_SIZE*sizeof(float), cudaMemcpyDeviceToHost);
	printf("Done!\n");
	
	printf("Compare the output for each implementation ... ");
	bool success = true;
        for(int i=0; i<ARRAY_SIZE; i++)
        {
                if(abs(y_host[i]-y_device[i]) > 0.00001)
                {
                        printf("Error at position %d! %f != %f\n", i, y_host[i], y_device[i]);
         		success = false;
			break;
                }
        }
	if(success){
		printf("Correct!");
	}

        free(x_host);
        free(y_host);
        free(y_device);
        cudaFree(x_gpu);
        cudaFree(y_gpu);
        
        return 0;
}
