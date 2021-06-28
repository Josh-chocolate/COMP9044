#!/usr/bin/perl -w

die "Usage: $0 <filename>\n" if @ARGV != 1;

$filename = $ARGV[0];
open my $f, '<', $filename or die "Cannot open $filename: $!\n";

$sum = 0;
while ($line = <$f>) {
	$line =~ / [Oo]rca/ or next;
	$line =~ / \d+ /;
	$sum += $&;
}
print "$sum Orcas reported in $filename\n";

close $f;
