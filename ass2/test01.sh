#!/bin/dash

echo "This shell is used to test the command of quit in subset0"

echo "The next lines should print 1:"
seq 1 3 | ./speed.pl 'q'

echo "The next lines should print 1:"
seq 1 5 | ./speed.pl '1q'

echo "The next lines should print 1 to 3:"
seq 1 5 | ./speed.pl '/3/q'

echo "The next lines should print 1:"
seq 1 5 | ./speed.pl '/./q'
