#!/bin/dash

track=0
new_dir=".snapshot.${track}"
while [ -e ${new_dir} ]
do
	track=$( expr $track + 1 )
	new_dir=".snapshot.${track}"
done
	
mkdir $new_dir && echo "Creating snapshot $track"

for file in *
do
	if [ "$file" = "snapshot-save.sh" ]
	then
		continue
	fi
	
	if [ "$file" = "snapshot-load.sh" ]
	then
		continue
	fi
	cp $file "$new_dir/"
done
