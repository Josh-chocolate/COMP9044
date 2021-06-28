#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test for fast-forward merge functions

if [ -d .girt ]
then
	rm -rf .girt
	girt-init
else
	girt-init
fi

echo line >a
girt-add a
girt-commit -m commit-0
girt-branch b1
girt-checkout b1
echo line >>a
girt-commit -a -m commit-1
girt-checkout master
echo "should print a line"
cat a
girt-merge b1 -m merge1
echo "should print two line"
cat a
