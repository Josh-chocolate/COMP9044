#!/bin/dash
for file in "$@"
do
	if [ -f "$file" ]
	then
		raw_date=$(find -name "$file" -printf %Cc)
		date=$(echo "$raw_date" | cut -d' ' -f2,3,4| sed -e 's/:[^:]*$//')
		gm convert -gravity south -pointsize 36 -draw "text 0,10 '$date'" "$file" "$file" 
	else
		echo "file: $file is not exist"
	fi											
done
