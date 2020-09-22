threads=(1 2 4 8 12 16 20 24 28 32)
schedules=(static dynamic guided)

for t in ${threads[@]}; do
	export OMP_NUM_THREADS=$t
	for s in ${schedules[@]}; do
		export OMP_SCHEDULE=$s
		echo "" > Q3_data/Q3$s/data_$t.txt
		for i in 1 2 3 4 5; do
			srun -n 1 stream.out >> Q3_data/Q3$s/data_$t.txt
		done
	done
done
