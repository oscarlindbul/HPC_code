#!/bin/sh
#SBATCH -J inter_pingpong
#SBATCH -N 2
#SBATCH -t 00:20:00
#SBATCH -C Haswell
#SBATCH -A edu20.fdd3258

srun -n 2 --ntasks-per-node=1 ping_pong.out > inter_data.txt
