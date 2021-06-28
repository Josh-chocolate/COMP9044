#!/bin/dash
for file in "$@"
do
	if [ -f "$file" ]
	then	
		echo "$file displayed to screen" 
		gm display "$file" 2> /dev/null
		echo -n "Address to e-mail this image to?" 
		read email 
		if [ "$email" != "" ]
		then
			echo -n "Message to accompany image?" 
			read message
			subject=$(echo "$file" | sed -e 's/\(.*\)\..*/\1/')
			echo "$message" | mutt -s "$subject!" -e 'set copy=no' -a "$file" -- "$email"
			echo "$file sent to $email"
		else
			echo "No email sent"
		fi
		
	else
		echo "Error, file: $file is not exist in current directory"
		continue
	fi																					
done
