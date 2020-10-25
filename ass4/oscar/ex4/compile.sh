#!/bin/bash
nvcc -arch=sm_30 -o exercise_2.out exercise_2.cu
nvcc -arch=sm_30 -o exercise_2_small.out exercise_2_small.cu
