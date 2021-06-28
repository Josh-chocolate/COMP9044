#!/bin/dash

echo "This shell is used to test the command of print in subset0"

echo "The next lines should print the number from 1 to 3 twice:"
seq 1 3 | ./speed.pl 'p'

echo "The next lines should print the number 1 twice:"
seq 1 5 | ./speed.pl '1p'

echo "The next lines should print the number 3 twice:"
seq 1 5 | ./speed.pl '/3/p'

echo "The next lines should print all numbers twice:"
seq 1 5 | ./speed.pl '/./p'
