#!/usr/bin/perl -w

die "Usage: $0 <filename>\n" if @ARGV != 1;

$filename = $ARGV[0];

open my $f, '<', $filename or die "cannot open $filename: $!\n";


while ($line = <$f>){
	chop $line;
	$line =~ tr/A-Z/a-z/;
	$line =~ tr/ / /s;
	$line =~ / \d+ /;
	$species = $';
	$count= $&;
	$species =~ s/\s+$//;
	$species =~ s/s$//;
	$pods{$species}++;
	$individuals{$species} += $count;
}

foreach $species (sort keys %pods) {
	print "$species observations: $pods{$species} pods, $individuals{$species} individuals\n";
}

close $f;
