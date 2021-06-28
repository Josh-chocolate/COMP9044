#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test for normal merge functions

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
girt-branch b1
girt-checkout b1
echo line >a
girt-commit -a -m commit-1
girt-checkout master
echo "should print nothing"
cat a
echo line >b
girt-commit -a -m commit-2
girt-merge b1 -m merge-1
echo "should print line"
cat b
echo "should print line"
cat a
