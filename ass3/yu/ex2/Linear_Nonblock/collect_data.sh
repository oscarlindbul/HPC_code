dat_files=(data_files/*)
procs=($(for file in ${dat_files[@]}; do echo $file | grep -o "[0-9]\+"; done | sort -n))
rm collected_data.txt
for proc in ${procs[@]}; do
	file="data_files/pi_seq_${proc}.txt"
	vals=$(awk 'BEGIN {sum=0;sumsq=0;n=0} NR>1 {sum+=$8;sumsq+=$8^2;n++} END {print sum/n,sqrt((sumsq - sum^2/n)/(n-1))}' $file)
	echo $proc" "${vals[0]}" "${vals[1]} >> collected_data.txt
done
