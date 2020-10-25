#!/bin/bash

# The name of the script is myjob
#SBATCH -J HPC_gpu
#SBATCH -t 00:05:00
#SBATCH -A edu20.FDD3258
#SBATCH -n 1
#SBATCH --gres=gpu:K420:1

srun -n 1 ./bandwidthTest
