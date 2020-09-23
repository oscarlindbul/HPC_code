module swap PrgEnv-cray PrgEnv-gnu
gcc -O2 maxloc_serial.c -o maxloc_serial.out -lm
gcc -fopenmp -O2 maxloc_ompfor.c -o maxloc_ompfor.out -lm
gcc -fopenmp -O2 maxloc_ompfor_running.c -o maxloc_ompfor_running.out -lm
gcc -fopenmp -O2 maxloc_ompforcritical_running.c -o maxloc_ompforcritical_running.out -lm
gcc -fopenmp maxloc_ompforfast_running.c -o maxloc_ompforfast_running.out -lm
gcc -fopenmp maxloc_ompforfastpadding_running.c -o maxloc_ompforfastpadding_running.out -lm
