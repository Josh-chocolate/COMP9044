#!/bin/dash

echo "This shell is used to test the command of delete in subset1"

echo "The next lines should print 1 2:"
seq 1 3 | ./speed.pl '$d'

echo "The next lines should print 3 4 5:"
seq 1 5 | ./speed.pl '1,2d'

echo "The next lines should print 1 4 5:"
seq 1 5 | ./speed.pl '/2/,3d'

echo "The next lines should print nothing:"
seq 1 5 | ./speed.pl '/./,2d'
