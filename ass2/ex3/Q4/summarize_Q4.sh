#!/bin/sh
# parallel
threads=($(awk 'NR>1 && NR<11 {print $2} ' Q4.txt))
par_times=($(awk 'NR>1 && NR<11 {print $7} ' Q4.txt))
par_errors=($(awk 'NR>1 && NR<11 {print $10} ' Q4.txt))

echo "Threads time dev" > summary.txt
for i in "${!threads[@]}"; do
    echo ${threads[$i]}" "${par_times[$i]}" "${par_errors[$i]} >> summary.txt
done
