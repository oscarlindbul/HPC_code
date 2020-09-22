module swap PrgEnv-cray PrgEnv-gnu
gcc -O2 -fopenmp stream.c -o stream.out
