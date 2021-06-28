#!/bin/dash



if [ $# -eq 2 ]
then
	sample_music="$1"
	path="$2"
	content=`wget -q -O- 'https://en.wikipedia.org/wiki/Triple_J_Hottest_100?action=raw'`
else
	echo "Usage:$0 <mp3_name> <dir_name>"
	exit 1	
fi

if ! [ -e "$path" ]
then
	mkdir "$path"
fi

text_list=`echo "$content" | egrep "style=" | egrep -o "\[(.)*\]" | sed 's/\[//g' | 
sed 's/\]//g' | egrep "\|[0-9]*$" | sed 's/ /@/g' | tr "\n" " "`


for album in $text_list
do
	track=0
	album=`echo "${album}" | tr "@" " " | cut -d'|' -f1`
	if ! [ -e "${path}/${album}" ]
	then
		mkdir "${path}/${album}"
	fi
	
	music_list=`echo "$content"|egrep "$album" -A11|egrep "^#" | sed 's/ /@/g' | tr "\n" " "`
	#echo "	${album}	$music_list"
	for music in $music_list
	do
		#echo "	${album}	$music" | tr "@" " "
		#author=`echo "$music" |  tr "@" " " | sed -e 's/.*–//g' -e 's/\"//g' -e 's/^ //g' -e 's/\[//g' -e 's/\]//g' -e 's/^.*|//g' -e sed 's?/?-?g'`
		author=`echo "$music" |  tr "@" " " | sed -e 's/.*–//g' -e 's/^[ ]*//g' -e 's/\"//g' -e 's/\[//g' -e's/\]//g'|cut -d\| -f2|sed 's/\//-/g'|sed 's/[ ]*$//g'`
		#echo "$music"| tr " " "\n" | tr "@" " " 
		#music_name=`echo "$music" | sed -e 's/–.*//g' -e 's/^# //g' | egrep "^\[\[\w*?\]\]"`
		music_name=`echo "$music"| tr " " "\n" | tr "@" " " | sed -e 's/–.*//g' -e 's/#[ ]*/#/g'|sed 's/ \[\[.*|/ /g'|sed -e 's/#\[\[.*|//g' -e 's/#//g' -e 's/[ ]*$//g' -e 's/\"//g' -e 's/\[//g' -e 's/\]//g'|sed -e 's/\//-/g' -e 's/^[ ]*//g'`
		#echo "	$music_name"
		track=$( expr $track + 1 )
		file_name="${track} - ${author} - ${music_name}.mp3"
		#echo "	${path}/${album}/${file_name}"
		cp "$sample_music" "${path}/${album}/${file_name}"
		
	done
done

