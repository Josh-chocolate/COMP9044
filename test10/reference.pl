#!/usr/bin/perl -w

@content = ();
while ($line = <STDIN>) {
	push @content, $line;
}

foreach $line (@content) {
	if ($line =~ /^#(\d+)\n$/) {
		print "$content[$1-1]";
	}
	else {
		print $line;
	}
}
