#!/usr/bin/perl -w

while ( $line = <STDIN> ) {
	chop $line;
	push @content, $line;
}

$len = @content;
@num = ();
while (@num != $len) {
	$value = int(rand($len));
	push @num, $value if !(grep {$_ eq $value} @num);
}
$i = 0;
foreach $index (@num){
	$output[$i] = $content[$index];
	$i++;
}
print join("\n", @output), "\n";
