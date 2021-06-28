#!/usr/bin/perl -w

$largest_number = -100000000000000;
while ($line = <STDIN>) {
	@nums = $line =~ m/-?\d+\.?\d*/g;
	#print "@nums\n";
	$largest = -1000000000000000;
	foreach $num (@nums) {
		if ($num ne ""){
			if ($num >= $largest) {
				$largest = $num;
			}
		}
	}
	#print "$largest\n";
	if ($largest == $largest_number){
		push @buffer, $line;
		$largest_number = $largest;
	}
	elsif ($largest > $largest_number){
		@buffer = ();
		push @buffer, $line;
		$largest_number = $largest;
	}
	#print "$largest_number\n";
}


print @buffer;
