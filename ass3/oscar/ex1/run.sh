#!/bin/sh
#SBATCH -J ass3_hello_world
#SBATCH -N 1
#SBATCH -t 00:01:00
#SBATCH -A edu20.fdd3258

# use 5 processes
srun -n 5 hello_world.out > output.txt
