#!/usr/bin/perl -w

$n = $ARGV[0] or die;
$count = 0;
@content = ();
while ($n > 0) {
	if ($line = <STDIN>) {
		$line = lc($line);
		$line =~ s/^\s+//;
		$line =~ s/\s+$//;
		$line =~ s/ +/ /;
		if (grep{$_ eq $line} @content) {
			$count++;
		}
		else {
			push @content, $line;
			$count++;
			$n--;
		}
	}
	else {
		last;
	}
}
if ($n == 0) {
	print "$ARGV[0] distinct lines seen after $count lines read.\n"
}
else {
	print "End of input reached after $count lines read - $ARGV[0] different lines not seen.\n";
}
