#!/bin/bash


if [ $# != 2 ]
then
	echo "Usage: "$0" <year> <course-prefix>"
	exit 1
fi

expr $1 + 1 &>/dev/null
case $? in
0)
	if [ $1 -ge 2019 -a $1 -le 2021 ]
	then
		:
	else
		echo ""$0": argument 1 must be an integer between 2019 and 2021"
		exit 1
	fi
	;;
*)
	echo ""$0": argument 1 must be an integer between 2019 and 2021"
		exit 1
	;;
esac

ugurl="https://www.handbook.unsw.edu.au/api/content/render/false/query/+unsw_psubject.implementationYear:$1%20+unsw_psubject.studyLevel:undergraduate%20+unsw_psubject.educationalArea:${2:0:4}*%20+unsw_psubject.active:1%20+unsw_psubject.studyLevelValue:ugrd%20+deleted:false%20+working:true%20+live:true/orderby/unsw_psubject.code%20asc/limit/10000/offset/0"

pgurl="https://www.handbook.unsw.edu.au/api/content/render/false/query/+unsw_psubject.implementationYear:$1%20+unsw_psubject.studyLevel:postgraduate%20+unsw_psubject.educationalArea:${2:0:4}*%20+unsw_psubject.active:1%20+unsw_psubject.studyLevelValue:pgrd%20+deleted:false%20+working:true%20+live:true/orderby/unsw_psubject.code%20asc/limit/10000/offset/0"

#wget -qO- $ugurl $pgurl | sed 's/{/\n/g' | grep "$2"| head

wget -qO- $ugurl $pgurl | 2041 jq ".contentlets[] | .code, .title" | sed 'N;s/\n/ /g' | sed 's/"//g' | sort | uniq
