#!/usr/bin/perl -w

if(@ARGV != 1){
	die "Usage:$0 <message>\n";
}

$ARGV[0]=~s/\'/\\\'/g;

print "-e print '${ARGV[0]}\n'";
