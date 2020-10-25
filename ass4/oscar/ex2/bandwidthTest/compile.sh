#!/bin/bash
nvcc -arch=sm_30 -I/pdc/vol/cuda/cuda-10.0/samples/common/inc bandwidthTest.cu -o bandwidthTest
