#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test commit and show functions

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

echo line2 >>a
girt-add a
girt-commit -m commit-1

echo line3 >>a
girt-add a
girt-commit -m commit-2

echo "should print line1"
girt-show 0:a

echo "should print line1, 2"
girt-show 1:a

echo "should print line1, 2, 3"
girt-show 2:a

echo "should print line1, 2, 3"
girt-show :a

echo "should print not found in index"
girt-show :p
