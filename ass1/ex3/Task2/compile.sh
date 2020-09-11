module swap PrgEnv-Cray PrgEnv-gnu
gcc -O2 clockgranularity.c -o clockgranularity.out
gcc -O2 clockRDTSC.c -o clockRDTSC.out
