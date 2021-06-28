#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test for rm, status functions

if [ -d .girt ]
then
	rm -rf .girt
	girt-init
else
	girt-init
fi

touch a b c d e

girt-add a b c d

echo "should print error message because a has not been committed yet"
girt-rm a
girt-rm --cached b

echo line >>c
echo "should print error message because a has not been committed yet"
girt-rm --cached c
# should remove c successfully
girt-rm --force --cached c

girt-rm --force d

echo "should print error message because e has not been added"
girt-rm e


# should see a added b c e untracked, should not see d
girt-status
