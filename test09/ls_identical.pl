#!/usr/bin/perl -w

$directory1 = $ARGV[0] or die;
$directory2 = $ARGV[1] or die;
@result = ();
foreach $file (glob "$directory1/*") {
	$file =~ /\/(.*)/;
	$filename = $1;
	if ( -e "$directory2/$filename" ) {
		$same = 1;
		open $f1, '<', $file or die;
		open $f2, '<', "$directory2/$filename" or die;
		while (my $line1 = <$f1>) {
			if (defined(my $line2 = <$f2>)) {
				if ($line1 ne $line2) {
					$same = 0;
					last;
				}
			}
			else {
				$same = 0;
				last;
			}
		}
		while (my $line2 = <$f2>) {
			if (defined(my $line1 = <$f1>)) {
				if ($line1 ne $line2) {
					$same = 0;
					last;
				}
			}
			else {
				$same = 0;
				last;
			}
		}
		if ($same == 1) {
			push @result, $filename;
		}
		close $f1;
		close $f2;
	}
}
foreach $file (@result) {
	print "$file\n";
}
