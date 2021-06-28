#!/bin/dash

echo "This shell is used to test the command of print with -n in subset1"

echo "The next lines should print 3:"
seq 1 3 | ./speed.pl -n '$p'

echo "The next lines should print 1 2"
seq 1 5 | ./speed.pl -n '1,2p'

echo "The next lines should print 2 3:"
seq 1 5 | ./speed.pl -n '/2/,3p'

echo "The next lines should print 1 2 3 4 5:"
seq 1 5 | ./speed.pl -n '/./,2p'
