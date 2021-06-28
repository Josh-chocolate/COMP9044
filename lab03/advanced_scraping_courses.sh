#!/bin/bash

underurl='http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=COMP'
posturl='http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=COMP'

if [ $# = 2 ]
then
	year=$1
	course=$2
else
	echo "Usage: "$0" <year> <coutse-prefix>"
	exit 1
fi




wget -qO- $underurl $posturl | grep -P "${course}[0-9]{4}\.html" | sed 's/[\t<]//g' | cut -d'/' -f7 | sed 's/.html">/ /g' | sort | uniq
