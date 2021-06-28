#!/bin/dash

most_line_file=""
largest_nb_lines=0
for file in $@
do
	nb_lines=`wc $file | cut -d' ' -f2`
	if [ $nb_lines -gt $largest_nb_lines ]
	then
		largest_nb_lines=$nb_lines
		most_line_file=$file
	fi
done
echo "$most_line_file"
