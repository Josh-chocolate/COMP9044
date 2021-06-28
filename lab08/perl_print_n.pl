#!/usr/bin/perl -w

$n = $ARGV[0] or die;

$str = $ARGV[1] or die;
while ( $n >= 1 ) {
	$str =~ s/\'/\\\'/g;
	$str = "print '$str\n'";
	$n--;
}
print "$str\n";
