#!/usr/bin/perl -w

while ($line = <STDIN>) {
	while ($line =~ /(\d+)\.?(\d*)/) {
		$int_part = $1;
		$float_part = $2;
		#print "$int_part, $float_part\n";
		if ($float_part ne "") {
			$float_part =~ /^(.)/;
			if ($1 >= 5) {
				$int_part++;
			}
		}
		print "$`$int_part";
		$line = $';
	}
	print "$line";
}
