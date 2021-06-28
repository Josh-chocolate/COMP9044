#!/usr/bin/perl -w

use File::Copy;


if( $#ARGV != 0 ){
	die "Usage:$0 <filename>\n";
}

$filename = $ARGV[0];
$track = 0;
$new_filename = ".${filename}.${track}";

while ( -e $new_filename ){
	$track += 1;
	$new_filename = ".${filename}.${track}";
}

copy("$filename", "./$new_filename") or die "Cann't copy!\n";
print "Backup of '${filename}' saved as '${new_filename}'\n";
