#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test for advanced commit and show functions

if [ -d .girt ]
then
	rm -rf .girt
	girt-init
else
	girt-init
fi

echo line1 >a
girt-add a
girt-commit -m commit-0
echo "should print usage message"
girt-commit -a -m

echo "should print nothing to commit"
girt-commit -a -m commit-0

echo line2 >>a
girt-commit -a -m commit-1

touch b
girt-add b
girt-commit -a -m commit-2
