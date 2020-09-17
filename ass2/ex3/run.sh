#!/bin/bash

gcc -O2 -o maxloc_serial.out maxloc_serial.c
gcc -O2 -fopenmp -o maxloc_ompfor.out maxloc_ompfor.c
