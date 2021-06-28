#!/bin/dash

echo "This shell is used to test the command of print with -n in subset0"

echo "The next lines should print the number from 1 to 3:"
seq 1 3 | ./speed.pl -n 'p'

echo "The next lines should print the number 1:"
seq 1 5 | ./speed.pl -n '1p'

echo "The next lines should print the number 3:"
seq 1 5 | ./speed.pl -n '/3/p'

echo "The next lines should print the number 1 to 5:"
seq 1 5 | ./speed.pl -n '/./p'
