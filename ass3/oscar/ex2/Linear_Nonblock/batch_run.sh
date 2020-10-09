#!/bin/sh
#SBATCH -J linear_blocking
#SBATCH -n processes
#SBATCH -t 00:20:00
#SBATCH -A edu20.fdd3258
#SBATCH -C Haswell

repeats=100
proc=processes
dat_file="data_files/pi_seq_${proc}.txt"
echo "" > $dat_file
for r in {1..100}; do
	srun -n $proc pi_seq.out >> $dat_file
done
