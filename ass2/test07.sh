#!/bin/dash

echo "This shell is used to test the command of substitute in subset1"

echo "The next lines should print 1 2 zzz:"
seq 1 3 | ./speed.pl '$s/\d/zzz/'

echo "The next lines should print zzz zzz 3 4 5:"
seq 1 5 | ./speed.pl '1,2s/\d/zzz/'

echo "The next lines should print 1 zzz zzz 4 5:"
seq 1 5 | ./speed.pl '/2/,3s/\d/zzz/'

echo "The next lines should print 5 lines of zzz:"
seq 1 5 | ./speed.pl '/./,2s/\d/zzz/'
