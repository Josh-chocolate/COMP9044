#!/usr/bin/perl -w

$count = 0;
while ($line = <>) {
	while ($line =~ /[a-zA-Z]+/){
		$count ++;
		$line = $';
	}
}
print "$count words\n";
