#!/bin/sh
#SBATCH -A edu20.FDD3258
#SBATCH -J ass1_ex1
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -C Haswell

echo "" > performance.info

n_vals=($(awk 'BEGIN {for (i=1;i<=4;i++) print 10^i}')) 

for n in ${n_vals[@]}; do
	srun -n 1 ./spmv.out $n >> performance.info
done
