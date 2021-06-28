#!/bin/dash

prefix="$1"

wget -q -O- http://www.timetable.unsw.edu.au/current/${prefix}KENS.html| egrep "${prefix}[0-9]{4}\.html\">.+?<" |
egrep -v "$1[0-9]*.*$1[0-9]*" |cut -d'"' -f4,5 | cut -d'<' -f1 | cut -d'>' -f1,2 | sed 's/.html">/ /g' | sort | uniq
