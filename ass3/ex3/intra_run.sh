#!/bin/sh
#SBATCH -J intra_pingpong
#SBATCH -N 1
#SBATCH -t 00:20:00
#SBATCH -A edu20.fdd3258
#SBATCH -C Haswell

srun -n 2 ping_pong.out > intra_data.txt
