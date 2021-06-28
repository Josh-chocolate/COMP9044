#!/bin/dash

if [ $# -eq 2 ]
then
	n=$1
	name=$2
	while [ $n -gt 0 ]
	do
		filename="hello$n.txt"
		echo "hello $name" >$filename
		n=`expr $n - 1`
	done
fi
