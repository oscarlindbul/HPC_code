files=(*.c)
for file in ${files[@]}; do
	cc $file -o ${file%.c}.out
done
