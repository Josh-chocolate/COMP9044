#!/bin/bash

small_size_files=""
medium_size_files=""
large_size_files=""

for name in $(ls);
do
	num=$(wc -l $name | cut -d' ' -f1)
	if [ $num -lt 10 ]
	then
		small_size_files="${small_size_files} ${name}"
	elif [ $num -lt 100 ]
	then
		medium_size_files="${medium_size_files} ${name}"
	else
		large_size_files="${large_size_files} ${name}"
	fi
done
echo "Small files:${small_size_files[@]}"
echo "Medium-sized files:${medium_size_files[@]}"
echo "Large files:${large_size_files[@]}"
