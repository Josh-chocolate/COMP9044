#!/usr/bin/perl -w

die "" if @ARGV != 1;
$n = $ARGV[0];

%data = ();
while ($line = <STDIN>) {
	$data{$line}++;
	if ($data{$line} == $n){
		print "Snap: $line";
		last;
	}
}

