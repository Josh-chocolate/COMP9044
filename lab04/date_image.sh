#!/bin/dash

if [ $# eq 0 ]
then
	echo "Usage:$0 <image_1> ... <image_n>"
	exit 1
else
	for file in $@
	do
		if [ -e $file ]
		then
			time=`ls -l ${file} | sed 's/  / /g' | cut -d' ' -f6-8`
			convert -gravity south -pointsize 36 -draw "text 0,10 '$time'" "$file" "$file"
		fi
	done
fi
