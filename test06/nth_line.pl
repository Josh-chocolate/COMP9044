#!/usr/bin/perl

die "" if @ARGV != 2;

$n = $ARGV[0];
$file = $ARGV[1];

open my $f, '<', $file or die "cannot open $file:$!\n";

$i = 1;

while ($line = <$f>) {
	if ($i == $n){
		print "$line";
		last;
	}
	$i++;
}

close $f;
