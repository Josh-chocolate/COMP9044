#!/usr/bin/perl -w

use File::Copy;
sub save{
	$track = 0;
	$new_dir = ".snapshot.${track}";

	while( -e $new_dir ){
		$track += 1;
		$new_dir = ".snapshot.${track}";
	}

	mkdir $new_dir;

	print "Creating snapshot $track\n";

	@files = glob('*');

	foreach(@files){
		if( "$_" ne "snapshot.pl" ){
			copy("$_", "$new_dir/") or die "cannot open $_\n";
		}
	}
}

sub load{
	($version) = @_;
	$load_dir = ".snapshot.$version";
	if( -d $load_dir ){
		save();
		@load_files = glob("$load_dir/*");
		@files = glob("*");
		foreach(@files){
			
			if( "$_" ne "snapshot.pl" ){
				unlink $_;
			}
		}
		foreach(@load_files){
			copy("$_", "./");
		}
		print "Restoring snapshot $version\n";
	}
}


if(( $#ARGV >= 0 ) and ( $#ARGV <= 1 )){ 
	$func = $ARGV[0];
	if($func eq "save"){
		save();
	}
	elsif($func eq "load"){
		load($ARGV[1]);
	}
}
	
	
	
	
	
