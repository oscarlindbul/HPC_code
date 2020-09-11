#!/bin/sh
#SBATCH -A edu20.FDD3258
#SBATCH -J ass1_ex1
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -C Haswell

srun -n 1 memory-mountain-example/mountain.out > results.txt
