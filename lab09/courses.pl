#!/usr/bin/perl -w

use LWP::Simple;
$prefix = $ARGV[0] or die;
$url = "http://www.timetable.unsw.edu.au/current/${prefix}KENS.html";
$web_page = get($url) or die "Unable to get $url";
#nt $web_page;

@content = split("\n", $web_page);
@result = ();
foreach $line (@content) {
	if ($line !~ /$prefix[0-9]{4}.*?$prefix[0-9]{4}/) {
		if ($line =~ /($prefix[0-9]{4})\.html">(.*?)</) {
			if (not grep{$_ eq "$1 $2\n"} @result) {
				push(@result, "$1 $2\n");
			}
		}
	}
}
@result = sort @result;
foreach $line (@result) {
	print $line;
}
