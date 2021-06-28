#!/bin/dash


case $# in
0)
	echo "Usage:$0 <image_1> ... <image_n>"
	exit 1
	;;
*)
	for file in "$@"
	do
		if ! [ -e "$file" ] 2>/dev/null
		then
			echo "${file} doesn't exist."
			exit 1
		fi
		
		gm display "$file" 2>/dev/null
		read -p "Address to e-mail this image to? " email
		if [ "$email" = "" ]
		then
			echo "No email sent"
		else
			read -p "Message to accompany image? " message
			echo $message | mutt -s "$file" -e 'set copy=no' -a "$file" -- "$email"
			echo "${file} sent to ${email}"
		fi
	done
	;;
esac