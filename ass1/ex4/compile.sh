if pwd | grep -q "cfs"; then module swap PrgEnv-cray PrgEnv-gnu; fi
cc -g -O2 naive_multiply.c -o naive_multiply.out
cc -g -O2 opt_multiply.c -o opt_multiply.out
