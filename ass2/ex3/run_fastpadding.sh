threads=(1 2 4 8 16 20 24 28 32)

echo "" > Q5.txt
for t in ${threads[@]}; do
	echo "Running normal "$t
	srun -n 1 maxloc_ompforfastpadding_running.out $t >> Q5.txt
done
