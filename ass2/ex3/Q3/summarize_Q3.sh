#!/bin/sh
# parallel
threads=($(awk 'NR>1 && NR<11 {print $2} ' Q3.txt))
par_times=($(awk 'NR>1 && NR<11 {print $7} ' Q3.txt))
par_errors=($(awk 'NR>1 && NR<11 {print $10} ' Q3.txt))

# critical
critical_times=($(awk 'NR>11 {print $6} ' Q3.txt))
critical_errors=($(awk 'NR>11 {print $9} ' Q3.txt))

echo "Threads critical_time critical_dev parallel_time parallel_dev" > summary.txt
for i in "${!threads[@]}"; do
    echo $i
    echo ${threads[$i]}" "${critical_times[$i]}" "${critical_errors[$i]}" "${par_times[$i]}" "${par_errors[$i]} >> summary.txt
done
