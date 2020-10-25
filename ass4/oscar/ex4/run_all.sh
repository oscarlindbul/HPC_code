#!/bin/bash

# The name of the script is myjob
#SBATCH -A edu20.fdd3258
#SBATCH -J HPC_gpu
#SBATCH -t 00:10:00
#SBATCH -N 1
#SBATCH --gres=gpu:K420:1

threads=(100 1000 10000 100000 1000000 10000000 100000000 1000000000)
rm data_files/*
for i in "${threads[@]}"; do
	sed -i "s/ARRAY_SIZE [0-9]\+/ARRAY_SIZE ${i}/g" exercise_2.cu
	bash compile.sh
	srun -n 1 ./exercise_2.out > data_files/t_$i.txt
done
