#!/usr/bin/perl -w

$file = $ARGV[0] or exit;

open $f, '<', $file or die;

@content = ();
$nb_lines = 0;
while ($line = <$f>){
	$nb_lines++;
	push @content, $line;
}

close $f;
if ($nb_lines == 0){
	exit;
}
if (int($nb_lines / 2) ==  ($nb_lines / 2)){
	print $content[int($nb_lines / 2)-1];
	print $content[int($nb_lines / 2)];
}
else{
	print $content[int($nb_lines / 2)];
}
