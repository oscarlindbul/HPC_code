#include <stdio.h>
#include <sys/time.h>
#include <cuda.h>
#include <stdlib.h>
#define TPB 256
#define ARRAY_SIZE 1000000000
#define A 3.14

__global__ void saxpy(float* x, float* y, float a) {
	const int i = blockIdx.x * blockDim.x + threadIdx.x;
	if (i < ARRAY_SIZE) {
		y[i] += a*x[i];
	}
}

void saxpy_cpu(float* x, float* y, float a) {
	for (int i = 0; i < ARRAY_SIZE; i++) {
		y[i] += x[i]*a;
	}
}

double elapsed(timeval t1, timeval t2) {
	return (1000000*(t2.tv_sec - t1.tv_sec) + t2.tv_usec - t1.tv_usec)/1000.0;
}


int main() {
	float* x, *y, *x_gpu, *y_gpu, *x_cpu, *y_cpu;
	float a = A;
	struct timeval t1, t2;

	x = (float*)malloc(sizeof(float)*ARRAY_SIZE);
	y = (float*)malloc(sizeof(float)*ARRAY_SIZE);
	x_cpu = (float*)malloc(sizeof(float)*ARRAY_SIZE);
	y_cpu = (float*)malloc(sizeof(float)*ARRAY_SIZE);

	srand(time(NULL));
	for (int i = 0; i < ARRAY_SIZE; i++) {
		x[i] = (float)rand();
		x_cpu[i] = x[i];
		y[i] = (float)rand();
		y_cpu[i] = y[i];
	}

	cudaMalloc(&x_gpu, sizeof(float)*ARRAY_SIZE);
	cudaMalloc(&y_gpu, sizeof(float)*ARRAY_SIZE);
	
	gettimeofday(&t1, NULL);
	cudaMemcpy(x_gpu, x, sizeof(float)*ARRAY_SIZE, cudaMemcpyHostToDevice);
	cudaMemcpy(y_gpu, y, sizeof(float)*ARRAY_SIZE, cudaMemcpyHostToDevice);

	saxpy<<<(ARRAY_SIZE + TPB - 1)/TPB, TPB>>>(x_gpu, y_gpu, a);	
	cudaDeviceSynchronize();
	
	cudaMemcpy(y, y_gpu, sizeof(float)*ARRAY_SIZE, cudaMemcpyDeviceToHost);
	gettimeofday(&t2, NULL);
	
	printf("GPU calculations complete! Took %f ms\n\n", elapsed(t1,t2));

	gettimeofday(&t1, NULL);
	saxpy_cpu(x_cpu, y_cpu, a);	
	gettimeofday(&t2, NULL);
	printf("CPU calculations complete! Took %f ms\n\n", elapsed(t1, t2));

	bool same = true;
	for (int i = 0; i < ARRAY_SIZE; i++) {
		if (abs(y_cpu[i] - y[i])/y[i] > 0.0001) {
			printf("Arrays differ! %f != %f\n", y_cpu[i], y[i]);
			same = false;
			break;
		}
	}
	if (same) {
		printf("Result check is complete! Arrays the same!\n");
	}

	free(x);
	free(y);
	free(x_cpu);
	free(y_cpu);
	cudaFree(x_gpu);
	cudaFree(y_gpu);

	return 0;
}
