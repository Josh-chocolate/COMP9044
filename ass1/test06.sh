#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test for branch checkout functions

if [ -d .girt ]
then
	rm -rf .girt
	girt-init
else
	girt-init
fi

touch a
girt-add a
girt-commit -m commit-0
girt-branch b1
girt-checkout b1

echo line >>a
girt-checkout master
echo "should print a line"
cat a
