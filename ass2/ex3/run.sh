#!/bin/bash

gcc -O2 -o maxloc_serial.out maxloc_serial.c
gcc -O2 -fopenmp -lm -o maxloc_ompfor.out maxloc_ompfor.c
gcc -O2 -fopenmp -lm -o maxloc_ompcritical.out maxloc_ompcritical.c
