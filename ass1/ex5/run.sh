#!/bin/bash

gcc -O3 -msse2 -ftree-vectorize -ffast-math -fopt-info-vec-optimized -fopt-info-vec-missed -o matrix_multiply.out matrix_multiply.c 2> vectorization.log

