#!/bin/dash

echo "This shell is used to test the command of print in subset1"

echo "The next lines should print 1 2 3 3:"
seq 1 3 | ./speed.pl '$p'

echo "The next lines should print 1 1 2 2 3 4 5:"
seq 1 5 | ./speed.pl '1,2p'

echo "The next lines should print 1 2 2 3 3 4 5:"
seq 1 5 | ./speed.pl '/2/,3p'

echo "The next lines should print 1 1 2 2 3 3 4 4 5 5:"
seq 1 5 | ./speed.pl '/./,2p'
