#!/usr/bin/perl -w

die "Usage: $0 <min> <max> <regex>\n" if @ARGV != 3;

($min, $max, $regex) = @ARGV;

die "regex too large" if length($regex) > 80;

foreach $n ($min..$max) {
    $unary = 1 x $n;
    print "$n = $unary unary - ";
    if ($unary =~ $regex) {
        print "composite\n"
    } else {
        print "prime\n";
    }
}
