#!/usr/bin/perl -w

@sorted_nums = sort { $a <=> $b } @ARGV;

$median_index = int($#sorted_nums / 2);
print "$sorted_nums[$median_index]\n";
