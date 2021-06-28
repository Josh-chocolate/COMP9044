#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test for rm functions

if [ -d .girt ]
then
	rm -rf .girt
	girt-init
else
	girt-init
fi

touch a b
girt-add a b
girt-commit -m commit-0
echo "should see a,b same as repo"
girt-status
# should rm a successfully
girt-rm a
echo "should see a deleted, b same as repo"
girt-status

echo line >b
echo "should see b has been changed"
girt-status
echo "should see error message because b has been changed"
girt-rm b
# should rm b successfully
girt-rm --force b

echo "should see a, b deleted"
girt-status
