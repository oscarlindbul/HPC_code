module swap PrgEnv-Cray PrgEnv-gnu
gcc -O2 clockgranularity.c -o clockgranularity.out
gcc -O2 clockRDTSC_largest.c -o clockRDTSC.out
