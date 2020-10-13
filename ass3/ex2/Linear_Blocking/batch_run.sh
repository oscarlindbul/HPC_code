#!/bin/sh
#SBATCH -J linear_blocking
#SBATCH -n processes
#SBATCH -N node_num
#SBATCH --ntasks-per-node=32
#SBATCH --exclusive
#SBATCH -t 00:20:00
#SBATCH -A edu20.fdd3258
#SBATCH -C Haswell

repeats=100
proc=processes
dat_file="data_files/pi_seq_${proc}.txt"
echo "" > $dat_file
for r in {1..100}; do
	srun -n $proc --ntasks-per-node=32 pi_other.out >> $dat_file
done
