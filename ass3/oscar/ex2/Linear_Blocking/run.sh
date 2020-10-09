procs=(8 16 32 64 128)
nodes=(1 1 1 2 4)

for ind in ${!procs[@]}; do
	sed "s/processes/${procs[$ind]}/g" batch_run.sh > tmp.sh
	sed -i "s/node_num/${nodes[$ind]}/g" tmp.sh
	sbatch tmp.sh
done
