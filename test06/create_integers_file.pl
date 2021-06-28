#!/usr/bin/perl -w

die "" if @ARGV != 3;

$start = $ARGV[0];

$end = $ARGV[1];

$file = $ARGV[2];

open my $f, '>', $file;

while ($start <= $end) {
	print $f "$start\n";
	$start ++;
} 
