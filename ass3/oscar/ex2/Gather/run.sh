procs=(8 16 32 64 128)

for proc in ${procs[@]}; do
	sed "s/processes/${proc}/g" batch_run.sh > tmp.sh
	sbatch tmp.sh
done
