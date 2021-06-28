#!/usr/bin/perl -w

die "" if @ARGV != 1;

$file = $ARGV[0];

open my $fin, '<', $file or die "cannot open $file:$!\n";

@content = <$fin>;

close $fin;

open my $fout, '>', $file;
foreach $line (@content){
	$line =~ s/\d/#/g;
	print $fout $line;
}
