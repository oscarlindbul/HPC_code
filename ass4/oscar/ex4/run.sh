#!/bin/bash

# The name of the script is myjob
#SBATCH -A edu20.fdd3258
#SBATCH -J HPC_gpu
#SBATCH -t 00:01:00
#SBATCH -N 1
#SBATCH --gres=gpu:K420:1

srun -n 1 ./exercise_2.out
