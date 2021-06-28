#!/bin/dash

if [ -e output.txt ]
then
	rm output.txt
fi

for i in `seq 1 1000`
do
	./shuffle.pl <numbers.txt | tr "\n" " " >>output.txt
	echo >>output.txt
done

len=`cat numbers.txt | wc -l`
echo "The permutation number of the input is ${len}!."

echo "The next line should print the number of the different shuffle results:"

cat output.txt | sort -n | uniq | wc -l


