#!/bin/dash
# Written by Zhe ZHANG 18:00 Mar 15th 2021
# This file is used to test the init, add, commit function.


# girt-init should take exactly 0 argument
girt-init 123
# this should print error message

# the correct way
girt-init

girt-init
# this should print repository exists error message

touch a

girt-add a

girt-add a

# nothing to commit test

girt-commit -m commit

girt-commit -m commit

girt-commit -m commit 1 2 3


