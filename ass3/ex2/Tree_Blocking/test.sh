#!/bin/sh
#SBATCH -J tree_blocking
#SBATCH -n 8
#SBATCH -t 00:20:00
#SBATCH -A edu20.fdd3258

repeats=100
proc=8
dat_file="output_test.txt"
echo "" > $dat_file
for r in {1..100}; do
	srun -n $proc pi_seq.out >> $dat_file
done
