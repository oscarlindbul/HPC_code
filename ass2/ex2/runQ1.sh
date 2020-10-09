threads=(1 2 4 8 12 16 20 24 28 32)

sed -i 's/schedule([a-z]\+)/schedule(guided)/g' stream.c
bash compile.sh

for t in ${threads[@]}; do
	export OMP_NUM_THREADS=$t
	echo "" > Q1_data/data_$t.txt
	for i in 1 2 3 4 5; do
		srun -n 1 stream.out >> Q1_data/data_$t.txt
	done
done
