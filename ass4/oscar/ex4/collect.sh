files=(data_files/*)
threads=${files[@]}
rm data.txt
for i in ${!files[@]}; do
	threads[i]=$(echo ${files[i]} | grep -o "[0-9]\+")
	cpu_time=$(awk '$1 == "CPU" {print $5}' ${files[i]})
	gpu_time=$(awk '$1 == "GPU" {print $5}' ${files[i]})
	echo ${threads[i]} $cpu_time $gpu_time >> data.txt
done
