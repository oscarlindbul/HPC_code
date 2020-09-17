#!/bin/sh
#SBATCH -A edu20.fdd3258 
#SBATCH -J parallel_helloworld
#SBATCH -t 00:10:00

export OMP_NUM_THREADS=4
srun -n 1 hello_world.o > output.txt
srun -n 1 hello_world2.o 3 > output2.txt
srun -n 1 hello_wordl3.o > output3.txt
