# !/bin/sh


while read word
do
	echo $word | tr [0-4] '<'  | tr [6-9] '>'
done
