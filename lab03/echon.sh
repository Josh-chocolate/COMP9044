#!/bin/bash

if (($# != 2))
then
	echo "Usage: ./echon.sh <number of lines> <string>"
	exit
fi



if [[ $1 =~ ^[0-9]+$ ]]
then
	for i in $(seq 1 $1);
	do
		echo "$2"
	done

else
	echo "./echon.sh: argument 1 must be a non-negative integer"
	exit
fi


