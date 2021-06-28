#!/bin/dash

#set -x
for directory in "$@"
do
	if [ -d "${directory%/*}" ]
	then
		directory=`echo $directory | sed 's:/$::g'`
		for file in "$directory"/*
		do
			suffix=`echo "$file" | sed 's/.*\(....\)$/\1/'`
			if [ "$suffix" = ".mp3" ]
			then
				#echo "$file"
				title=`echo "$file" | cut -d'/' -f3 | cut -d'-' -f2 | sed 's/^ //g' | sed 's/ $//g'`
				artist=`echo "$file" | cut -d'/' -f3 | cut -d'-' -f3 | sed 's/^ //g' | sed 's/.mp3$//g'`
				track=`echo "$file" | cut -d'/' -f3 | cut -d'-' -f1 | sed 's/ $//g'`
				album=`echo "$file" | cut -d'/' -f2`
				year=`echo "$file" | cut -d'/' -f2 | cut -d',' -f2 | sed 's/^ //g'`
			
				id3 "$file" -t "$title" >/dev/null
				id3 "$file" -a "$artist" >/dev/null
				id3 "$file" -T "$track" >/dev/null
				id3 "$file" -A "$album" >/dev/null
				id3 "$file" -y "$year" >/dev/null
				#id3 -l "$file"
			fi
		done
	fi
done
