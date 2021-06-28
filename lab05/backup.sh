#!/bin/dash

if ! [ $# -eq 1 ]
then
	echo "Usage:$0 <filename>"
	exit 0
fi

filename="$1"
track=0
new_filename=".${filename}.$track"
while [ -e $new_filename ]
do
	track=$( expr $track + 1 )
	new_filename=".${filename}.$track"
done
cp "$filename" "$new_filename" && echo "Backup of '${filename}' saved as '${new_filename}'"
