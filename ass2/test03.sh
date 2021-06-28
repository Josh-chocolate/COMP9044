#!/bin/dash

echo "This shell is used to test the command of delete in subset0"

echo "The next lines should print nothing:"
seq 1 3 | ./speed.pl 'd'

echo "The next lines should print one line zzz and number 2 to 5:"
seq 1 5 | ./speed.pl '1d'

echo "The next lines should print 1 2 and 4 5:"
seq 1 5 | ./speed.pl '/3/d'

echo "The next lines should print nothing:"
seq 1 5 | ./speed.pl '/./d'
