#!/usr/bin/perl -w

$word = $ARGV[0] or die;
foreach $file (glob "lyrics/*.txt") {
	$word_count = 0;
	$total_word = 0;
	open $f, '<', $file or die;
	while ($line = <$f>) {
		while ($line =~ /[a-zA-Z]+/){
			$total_word++;
			$match = $&;
			$line = $';
			if ($match =~ m/\b$word\b/i){
				$word_count++;
			}
		}
	}
	$file =~ /\/(.*)\./;
	$artist = $1;
	$artist =~ s/_/ /g;
	$result = log(($word_count+1) / $total_word);
	printf "log((%d+1)/%6d) = %8.4f %s\n", $word_count, $total_word, $result, $artist;
}
