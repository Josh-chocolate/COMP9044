#!/bin/dash

OLD=$IFS
IFS=$\n
if [ $# -eq 2 ]
then
	same_files=""
	dir_1=$1
	dir_2=$2
	for file in $dir_1/*
	do
		file=`echo $file | cut -d'/' -f2`
		
		if [ -e ${dir_2}/"$file" ]
		then
			diff "${dir_2}/$file" "${dir_1}/$file" >/dev/null 2>/dev/null
			if [ $? -eq 0 ]
			then
				same_files="$file\n${same_files}"
			fi
		fi
		
	done
	
fi
IFS=$OLD
echo -n "$same_files" | sort
