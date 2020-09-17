threads=(1 2 4 8 16 20 24 28 32)

echo "" > Q4.txt
for t in ${threads[@]}; do
	echo "Running normal "$t
	srun -n 1 maxloc_ompforfast_running.out $t >> Q4.txt
done
