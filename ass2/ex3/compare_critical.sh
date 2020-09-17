threads=(1 2 4 8 16 20 24 28 32)

echo "" > Q3.txt
for t in ${threads[@]}; do
	echo "Running normal "$t
	srun -n 1 maxloc_ompfor_running.out $t >> Q3.txt
done
echo "" >> Q3.txt
for t in ${threads[@]}; do
	echo "Running critical "$t
	srun -n 1 maxloc_ompforcritical_running.out $t >> Q3.txt
done
