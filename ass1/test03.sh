#!/bin/dash
# WRITTEN BY ZHE ZHANG AT MAR 25th
# This shell is used to test branch init and checkout functions

if [ -d .girt ]
then
	rm -rf .girt
	girt-init
else
	girt-init
fi

# should have a commit before run branch command
girt-branch

echo line1 >a
girt-add a
girt-commit -m first

# branch name can't be just numbers
girt-branch
girt-branch 1
girt-branch b1
# should success with name b1
girt-checkout b1
girt-checkout master


