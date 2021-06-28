#!/usr/bin/perl -w
if (@ARGV != 2) {
	print "Usage: $0 <number of lines> <string>\n";
	exit 1;
}
$n = $ARGV[0];
$str = $ARGV[1];

if ($n !~ /^\d+$/) {
	print "$0: argument 1 must be a non-negative integer\n";
	exit 1;
}

while ($n >0) {
	print "$str\n";
	$n--;
}
