#!/usr/bin/perl -w

@output = ();

foreach $arg (@ARGV){
	if ((grep {$_ eq $arg} @output) == 0){
		push @output, $arg;
	}
}
print "@output\n";
