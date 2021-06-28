#!/usr/bin/perl -w

foreach $word (@ARGV){
	if ($word =~ /[aeiou]{3}/i){
		print "$word ";
	}
}
print "\n";
