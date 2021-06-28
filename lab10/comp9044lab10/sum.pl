#!/usr/bin/perl -w
$result = 0;
foreach $num (@ARGV) {
	$result += $num;
}
print "$result\n";
