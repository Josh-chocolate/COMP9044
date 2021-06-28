#!/usr/bin/perl -w

# hash table total_words: {file: total_words}
# hash table words_freq: {file: word: nums}
# hash table prob_table: {artist: prob}

# initialization
foreach $file (glob "lyrics/*.txt") {
	$prob_table{$file} = 0;
	$total_words{$file} = 0;
	$words_freq{$file} = ();
}

foreach $file (glob "lyrics/*.txt") {
	open $f, '<', $file or die;
	while ($line = <$f>) {
		while ($line =~ /[a-zA-Z]+/){
			$word = lc($&);
			$line = $';
			if (exists($words_freq{$file}{$word})){
				$words_freq{$file}{$word}++;
				$total_words{$file} += 1;
			}
			else{
				$words_freq{$file}{$word} = 1;
				$total_words{$file} += 1;
			}
		}
	}
	close $f;
}
# compute the prob_table and the most_prob_artist of every song
foreach $song_file (@ARGV){
	%prob_table = ();
	open $f, '<', $song_file or die;
	while ($line = <$f>){
		while ($line =~ /[a-zA-Z]+/){
			$word = lc($&);
			$line = $';
			foreach $artist (keys %total_words){
				if (exists($words_freq{$artist}{$word})) {
					$count = $words_freq{$artist}{$word};
				}
				else{
					$count = 0;
				}
				$prob_table{$artist} += log(($count + 1) / $total_words{$artist});
			}
		}
	}
	close $f;
	$most_prob = -10000000000000000;
	while( my ($artist, $prob) = each %prob_table )  {
		if ($prob >= $most_prob){
			$most_prob_artist = $artist;
			$most_prob = $prob;
		}
	}
	$most_prob_artist =~ /\/(.*)\./;
	$most_prob_artist = $1;
	$most_prob_artist =~ s/_/ /g;
	printf "$song_file most resembles the work of $most_prob_artist (log-probability=%4.1f)\n", $most_prob;
}

















