#!/bin/sh
#SBATCH -A edu20.FDD3258
#SBATCH -J ass1_ex4
#SBATCH -n 1
#SBATCH -t 00:10:00
#SBATCH -C Haswell

sizes=(64 1000)

for size in ${sizes[@]}; do 

	sed -i 's/define MSIZE [0-9]\+/define MSIZE '$size'/g' naive_multiply.c
	sed -i 's/define MSIZE [0-9]\+/define MSIZE '$size'/g' opt_multiply.c
	bash compile.sh

	naive_r=naive_results_$size.txt
	opt_r=opt_results_$size.txt
        
        echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat -o ./$naive_r -e instructions,cycles,L1-dcache-load-misses,L1-dcache-loads,LLC-load-misses,LLC-loads ./naive_multiply.out > opt_out_$size.txt
        echo 1 > /proc/sys/kernel/nmi_watchdog

	echo "" > $opt_r
        echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat -o ./$opt_r -e instructions,cycles,L1-dcache-load-misses,L1-dcache-loads,LLC-load-misses,LLC-loads ./opt_multiply.out > opt_out_$size.txt
        echo 0 > /proc/sys/kernel/nmi_watchdog
done
