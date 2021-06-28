#!/bin/dash

if ! [ $# -eq 1 ]
then
	echo "Usage:$0 <n>"
	exit 0
fi

n=$1

./snapshot-save.sh

if [ -d ".snapshot.${n}" ]
then
	echo "Restoring snapshot ${n}"
	for file in *
	do
		rm $file
	done

	for file in .snapshot.${n}/*
	do
		cp "${file}" ./
	done
fi
