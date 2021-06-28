#!/bin/dash


for file in *
do
	suffix=`echo "$file"|sed 's/.*\(....\)$/\1/'`
	if [ "$suffix" = ".jpg" ]
	then
		new_file=`echo "$file" | sed 's/.jpg/.png/'`
		if [ -e "$new_file" ]
		then
			echo "${new_file} already exists"
		else
			convert "$file" "$new_file"
			rm "$file"
		fi
	fi
done
