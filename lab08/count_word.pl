#!/usr/bin/perl -w

$word = $ARGV[0] or die;

$count = 0;

while ($line = <STDIN>) {
	while ($line =~ m/\b$word\b/i){
		$count ++;
		$line = $';
	}
}

print "$word occurred $count times\n"
