#!/usr/bin/perl -w

die "Usage: $0 <species> <filename>\n" if @ARGV != 2;

$species = $ARGV[0];
$filename = $ARGV[1];

open my $f, '<', $filename or die "Cannot open $filename: $!\n";

$nb_pods = 0;
$nb_individuals = 0;

while ($line = <$f>) {
	$line =~ / $species/ or next;
	$nb_pods ++;
	$line =~ / \d+ /;
	$nb_individuals += $&;
}

print "$species observations: $nb_pods pods, $nb_individuals individuals\n";

close $f;
