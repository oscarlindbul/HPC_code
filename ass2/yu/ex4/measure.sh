#!/bin/bash

REPEAT=10

echo "Start Compiling ..."
./compile.sh
echo "Done"

echo "" > data.txt

echo "Start Measuring ..."
echo "" > log.txt
for i in $(seq 1 $REPEAT)
do
	echo "Measuring original ... $i"
	./DFTW_1.out >> log.txt
done
echo "Done"

echo "Analyzing original ..."
arr=()
input="log.txt"
while IFS= read -r line
do
	if [[ $line =~ DFTW[[:space:]]computation[[:space:]]in[[:space:]]([0-9\.]+)[[:space:]]seconds ]];
	then
		arr=(${arr[@]} ${BASH_REMATCH[1]})
	fi
done < "$input"
	
#Compute Mean and derivation
mean=0
derivation=0
for i in ${arr[@]}; do
 	mean=$(bc -l <<<"$mean+$i")
done
mean=$(bc -l <<<"$mean/$REPEAT")
for i in ${arr[@]}; do
 	derivation=$(bc -l <<<"($i-$mean)^2")
done
derivation=$(bc -l <<<"sqrt($derivation)")
echo "0 $mean $derivation" >> data.txt

for nt in 1 2 4 8 12 16 20 24 28 32
do
	echo "SET NUM_THREAD = $nt"
	export OMP_NUM_THREADS=$nt

	echo "Start Measuring ..."
	echo "" > log.txt
	for i in $(seq 1 $REPEAT)
	do
		echo "Measuring ... $i"
		./DFTW_1_opt.out >> log.txt
	done
	echo "Done"

	echo "Start Analyzing ..."
	arr=()
	input="log.txt"
	while IFS= read -r line
	do
		if [[ $line =~ DFTW[[:space:]]computation[[:space:]]in[[:space:]]([0-9\.]+)[[:space:]]seconds ]];
		then
			arr=(${arr[@]} ${BASH_REMATCH[1]})
		fi
	done < "$input"
	
	#Compute Mean and derivation
	mean=0
	derivation=0
	for i in ${arr[@]}; do
  	mean=$(bc -l <<<"$mean+$i")
	done
	mean=$(bc -l <<<"$mean/$REPEAT")
	for i in ${arr[@]}; do
  	derivation=$(bc -l <<<"($i-$mean)^2")
	done
	derivation=$(bc -l <<<"sqrt($derivation)")
	echo "$nt $mean $derivation" >> data.txt
	
done
