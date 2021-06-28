#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test for can not merge functions

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
echo line1 >a
girt-commit -a -m commit-1
girt-checkout master
echo "should print nothing"
cat a
echo line2 >a
girt-commit -a -m commit-2
echo "should print can not merge because a has been modified both branches"
girt-merge b1 -m merge-1

echo "should print line2"
cat a
