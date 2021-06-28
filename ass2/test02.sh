#!/bin/dash

echo "This shell is used to test the command of substitute in subset0"

echo "The next lines should print zzz three times:"
seq 1 3 | ./speed.pl 's/\d/zzz/'

echo "The next lines should print one line zzz and number 2 to 5:"
seq 1 5 | ./speed.pl '1s/\d/zzz/'

echo "The next lines should print 1 2 and one line zzz and 4 5:"
seq 1 5 | ./speed.pl '/3/s/\d/zzz/'

echo "The next lines should print zzz five times:"
seq 1 5 | ./speed.pl '/./s/\d/zzz/'
