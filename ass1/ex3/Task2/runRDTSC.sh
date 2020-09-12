#!/bin/sh
#SBATCH -A edu20.FDD3258
#SBATCH -J ass1_ex3
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -C Haswell

echo "" > clock_info_RDTSC.txt
srun -n 1 ./clockRDTSC.out 100 >> clock_info_RDTSC.txt

