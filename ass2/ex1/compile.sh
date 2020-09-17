module swap PrgEnv-cray PrgEnv-gnu
gcc -fopenmp hello_world.c -o hello_world.o
gcc -fopenmp hello_world2.c -o hello_world2.o
gcc -fopenmp hello_world3.c -o hello_world3.o
