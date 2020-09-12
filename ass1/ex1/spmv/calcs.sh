clock_freq=2.3e9
clock_delay=$(echo $clock_freq | awk '{printf "%.10e\n", (1 / $1)}')
nrows=(100 10000 1000000 100000000)
nnz=($(echo ${nrows[*]} | awk '{ for (i=1; i<=NF; i++) {printf "%.10e\n", 5*$i}}'))

# 1 & 2
model_times=($(echo ${nnz[*]} | awk -v c=$clock_freq '{ for (i=1;i<=NF;i++) { printf "%.10e\n", 2*$i/c } }'))
echo "Execution times (modeled vs real):"
exec_times=($(awk -F, 'NR > 1 { split($4,arr,"="); printf "%.10e\n", arr[2] }' performance.info ))
for i in ${!model_times[@]}; do
	echo ${model_times[$i]}" s vs "${exec_times[$i]}" s"
done
echo ""

# 2
echo "Floating-points per second:"
for i in ${!nrows[@]}; do
	awk -v t=${exec_times[$i]} -v nnz=${nnz[$i]} 'BEGIN {printf "%.4e\n", 2*nnz/t}'
done
echo ""

# 3
echo "We do not account for chache-misses and other memory operations into account"
echo ""

# 4
mem=()
for i in ${!nnz[@]}; do
	mem[$i]=$(./size.out ${nnz[$i]} ${nrows[$i]})
done
echo ${mem[@]}
echo "Measured Bandwidths"
for i in ${!nnz[@]}; do
	awk -v t=${exec_times[$i]} -v mem=${mem[$i]} ' BEGIN { printf "%d, %.4e, %.4e b per s\n", mem, t, mem/(t*1028) } '
done
