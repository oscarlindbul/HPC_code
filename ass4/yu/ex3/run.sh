#!/bin/bash

# The name of the script is myjob
#SBATCH -J myjob
# Only 1 hour wall-clock time will be given to this job
#SBATCH -t 00:10:00
#SBATCH -A edu20.FDD3258
# Number of nodes
#SBATCH --nodes=1
#SBATCH -e error_file.e
#SBATCH --gres=gpu:K420:1

# Run the executable file 
# and write the output into my_output_file
srun -n 1 ./exercise_1.out
