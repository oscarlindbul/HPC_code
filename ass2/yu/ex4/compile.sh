#!/bin/bash

gcc -O2 -fopenmp -lm -o DFTW_1.out DFTW_1.c
gcc -O2 -fopenmp -lm -o DFTW_1_opt.out DFTW_1_opt.c
