#!/usr/bin/perl -w

$file = $ARGV[0] or die;

open my $f, '<', $file or die;
while ($line = <$f>) {
	$content{$line} = length($line);
}
close $f;

my @sort_result = sort {$content{$a} <=> $content{$b}} sort keys %content;

foreach $line (@sort_result){
	print $line;
}
