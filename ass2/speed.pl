#!/usr/bin/perl -w

use Getopt::Std;
$opt_n = 0;
$opt_f = 0;
getopts('nf');

sub invalid_command_error_msg{
	print "speed: command line: invalid command\n";
	exit 1;
}

# parse the address command part into start and end
sub parse_cmd {
	my ($address) = @_;
	#print "$address\n";
	if ($address ne '') {
		@address = split ",", $address;
		$start = $address[0];
		if ($#address == 1){
			$end = $address[1];
		}
		else {
			$end = $address[0];
		}
	}
	else {
		$start = 1;
		$end = '$';
	}
	# error detect
	invalid_command_error_msg if $start eq '0' or $end eq '0';
	invalid_command_error_msg if $start eq '$' and $start ne $end;
	
	return ($start, $end);
}

# parse the 's#1#zz#g' command
sub parse_substitute_cmd {
	my ($expr) = @_;
	$expr =~ /^s(.).*/;
	my $delimitor = $1;
	$delimitor = "\\$delimitor" if $delimitor =~ m/[\"\?\*\.\(\)\$\\]/;
	if ($expr =~ /^s$delimitor(.*?)$delimitor(.*?)$delimitor(g?)$/) {
		@result = ($1, $2, $3);
		return ($result[0], $result[1], $result[2]);
	}
	else {
		invalid_command_error_msg;
	}
}

# judge if the number of lines satisfys the condition or the content of the line satisfys it
sub satisfied {
	my ($condition, $count_lines, $line) = @_;
	return $count_lines == $condition if $condition =~ /^-?\d+$/;
	$regex = $1 if $condition =~ /\/(.*)\//;
	return $line =~ /$regex/ if $condition =~ /^\/(.*)\/$/;
	invalid_command_error_msg;
	return;
}

# function of quit command
sub speed_quit {
	my ($address, $line, $count_lines, $last) = @_;
	invalid_command_error_msg if $address eq '0';
	$address = 1 if $address eq '';
	$address = -1 if $address eq '$';
	if (satisfied($address, $count_lines, $line) or ($last == 1 and $address eq '-1')) {
		return 1;
	}
	else {
		return 0;
	}
}

# function of range substitution
sub range_subsititute {
	my ($start, $end, $start_satisfied, $end_satisfied, $regex, $rep_regex, $global, $line, $count_lines) = @_;
	$end = -1 if $end eq '$';
	if ($end_satisfied == 1 and satisfied($start, $count_lines, $line)) {
		$end_satisfied = 0;
		$line =~ s/$regex/$rep_regex/g if $global eq 'g';
		$line =~ s/$regex/$rep_regex/ if $global ne 'g';
	}
	elsif ($start_satisfied == 1 and $end_satisfied == 1) {
		$line = $line;
	}
	# if the start address is satisfied and the end address is firstly satified then the after lines should be changed
	elsif ($start_satisfied == 1 and satisfied($end, $count_lines, $line)) {
		$end_satisfied = 1;
		$line =~ s/$regex/$rep_regex/g if $global eq 'g';
		$line =~ s/$regex/$rep_regex/ if $global ne 'g';
	}
	# if the start address is firstly satisfied then all the lines after will be changed until the end address is satisfied
	elsif ($start_satisfied == 0 and satisfied($start, $count_lines, $line) or $start_satisfied == 1) {
		$start_satisfied = 1;
		$line =~ s/$regex/$rep_regex/g if $global eq 'g';
		$line =~ s/$regex/$rep_regex/ if $global ne 'g';
	}
	else {
		$line = $line;
	}
	return ($line, $start_satisfied, $end_satisfied);
}

# function of regular substitution
sub regular_subsititute {
	my ($address, $regex, $rep_regex, $global, $line, $count_lines, $last) = @_;
	invalid_command_error_msg if $address eq '0'; 
	$address = -1 if $address eq '$';
	if (satisfied($address, $count_lines, $line) or ($last == 1 and $address eq '-1')) {
		$line =~ s/$regex/$rep_regex/g if $global eq 'g';
		$line =~ s/$regex/$rep_regex/ if $global ne 'g';
	}
	return $line;
}

# main procedure of substitution
sub speed_substitute {
	my ($start, $end, $substitute_start, $substitute_end, $regex, $rep_regex, $global, $line, $count_lines, $last) = @_;
	
	if ($end =~ /^\d+$/ and $substitute_end == 1) {
		$line = regular_subsititute($start, $regex, $rep_regex, $global, $line, $count_lines, $last);
	}
	else {
	# range substitution
		($line, $substitute_start, $substitute_end) = range_subsititute($start, $end, $substitute_start, $substitute_end, $regex, $rep_regex, $global, $line, $count_lines) if $start ne $end;
		# regular substitution
		$line = regular_subsititute($start, $regex, $rep_regex, $global, $line, $count_lines, $last) if $start eq $end;
	}
	return ($line, $substitute_start, $substitute_end);
}

# function of range print
sub range_print {
	my ($address_start, $address_end, $start_satisfied, $end_satisfied, $line, $count_lines) = @_;
	$address_end = -1 if $address_end eq '$';
	# if the end address is satisfied then just print every line once
	if ($end_satisfied == 1 and satisfied($address_start, $count_lines, $line)) {
		$end_satisfied = 0;
		print "$line";
	}
	elsif ($end_satisfied == 1 and $start_satisfied == 1) {
		$line = $line;
	}
	# if the start address is satisfied and the the end address is firstly satified then the after lines should be printed only once
	elsif ($start_satisfied == 1 and satisfied($address_end, $count_lines, $line)) {
		$end_satisfied = 1;
		print "$line";
	}
	# if the start address is firstly satisfied then print all the lines twice until the end address is satisfied
	elsif ($start_satisfied == 0 and satisfied($address_start, $count_lines, $line) or $start_satisfied == 1) {
		$start_satisfied = 1;
		print "$line";
	}
	return ($start_satisfied, $end_satisfied);
}

# function of regular print
sub regular_print {
	my ($address, $line, $count_lines, $last) = @_;
	invalid_command_error_msg if $address eq '0'; 
	$address = -1 if $address eq '$';
	print "$line" if satisfied($address, $count_lines, $line) or ($last == 1 and $address eq '-1');
	return;
}

# function of main procedure of print command
sub speed_print {
	my ($address, $print_start, $print_end, $line, $count_lines, $last) = @_;
	my ($address_start, $address_end) = parse_cmd($address);
	
	if ($address_end =~ /^\d+$/ and $print_end == 1) {
		regular_print($address_start, $line, $count_lines, $last);
	}
	else {
		($print_start, $print_end) = range_print($address_start, $address_end, $print_start, $print_end, $line, $count_lines) if $address_start ne $address_end;
		regular_print($address_start, $line, $count_lines, $last) if $address_start eq $address_end;
	}
	return ($print_start, $print_end);
}

sub range_delete {
	my ($start, $end, $start_satisfied, $end_satisfied, $line, $count_lines) = @_;
	my $delete = 0;
	$end = -1 if $end eq '$';
	if ($end_satisfied == 1 and satisfied($start, $count_lines, $line)) {
		$end_satisfied = 0;
		$delete = 1;
	}
	elsif ($end_satisfied == 1 and $start_satisfied == 1) {
		$delete = 0;
	}
	# if the start address is satisfied and the the end address is firstly satified then the after lines shouldn't be printed
	elsif ($start_satisfied == 1 and satisfied($end, $count_lines, $line)) {
		$end_satisfied = 1;
		$delete = 1;
	}
	# if the start address is firstly satisfied then all the lines after won't be printed until the end address is satisfied
	elsif ($start_satisfied == 0 and satisfied($start, $count_lines, $line) or $start_satisfied == 1) {
		$start_satisfied = 1;
		$delete = 1;
	}
	else {
		$delete = 0;
	}
	return ($delete, $start_satisfied, $end_satisfied);
}

sub regular_delete {
	my ($address, $line, $count_lines, $last) = @_;
	invalid_command_error_msg if $address eq '0'; 
	$address = -1 if $address eq '$';
	if (satisfied($address, $count_lines, $line) or ($last == 1 and $address eq '-1')) {
		return 1;
	}
	else {
		return 0;
	}
}

# function for the sed-command which ends with a 'd'
sub speed_delete {
	my ($address, $delete_start, $delete_end, $line, $count_lines, $last) = @_;
	my ($address_start, $address_end) = parse_cmd($address);
	
	if ($address_end =~ /^\d+$/ and $delete_end == 1) {
		$delete = regular_delete($address_start, $line, $count_lines, $last);
	}
	else {
		($delete, $delete_start, $delete_end) = range_delete($address_start, $address_end, $delete_start, $delete_end, $line, $count_lines) if $address_start ne $address_end;
		$delete = regular_delete($address_start, $line, $count_lines, $last) if $address_start eq $address_end;
	}
	return ($delete, $delete_start, $delete_end);
}

sub main {
	# initial the flags and the number of lines
	my ($input, $count_lines, $substitute_start, $substitute_end, $print_start, $print_end, $delete_start, $delete_end) = @_;
	$last_line = <$input>;
	$line = $last_line;

	# do the function relied on the speed command line
	while (defined($line)) {
		if ($line = <$input>) {
			$last = 0;
		}
		else {
			$last = 1;
		}
		$count_lines++;
		$quit = 0;
		$delete = 0;
		$valid_cmd = 0;
		foreach $cmd (@cmds) {
			$cmd =~ s/\s//g;
			$cmd =~ s/#.*//g;
			if ($cmd =~ /^(.*)q$/) {
				$valid_cmd = 1;
				my $address = $1;
				$quit = speed_quit($address, $last_line, $count_lines, $last);
			}
			if ($quit == 1){
				last;
			}
			if ($cmd =~ /^(.*)d$/){
			
				my $address = $1;
				$valid_cmd = 1;
				($delete, $delete_start, $delete_end) = speed_delete($address, $delete_start, $delete_end, $last_line, $count_lines, $last);
			}
			if ($cmd !~ /^(.*)p$/ and $cmd =~ /^(.*)(s.*)/) {
				my $address = $1;
				my ($start, $end) = parse_cmd($address);
				my ($regex, $rep_regex, $global) = parse_substitute_cmd($2);
				($last_line, $substitute_start, $substitute_end) = speed_substitute($start, $end, $substitute_start, $substitute_end, $regex, $rep_regex, $global, $last_line, $count_lines, $last);
				#print "$substitute_start, $substitute_end, $last_line";
				$valid_cmd = 1;
			}
		
			if ($cmd =~ /^(.*)p$/ and $delete == 0) {
				my $address = $1;
				$valid_cmd = 1;
				($print_start, $print_end) = speed_print($address, $print_start, $print_end, $last_line, $count_lines, $last);
				#print "$address, $print_start, $print_end, $last_line";
			}
		
		}
		print "$last_line" if $delete eq 0 and $opt_n == 0;
		exit 0 if $quit eq 1 and $delete eq 0;
		invalid_command_error_msg if $valid_cmd == 0;
		$last_line = $line if defined($line);
	}
	return ($count_lines, $substitute_start, $substitute_end, $print_start, $print_end, $delete_start, $delete_end);
}

# initialize of the arguments
if (@ARGV == 0) {
	print "usage: speed [-i] [-n] [-f <script-file] [sed-command] <files>\n";
	exit 1;
}

if (@ARGV > 1) {
	my $i = 1;
	while ($i <= $#ARGV) {
		push @files, $ARGV[$i];
		$i++;
	}
}


if ($opt_f == 0) {
	@cmds = split ";", $ARGV[0];
}
else {
	$file = $ARGV[0];
	open $f, '<', $file or die "cannot open\n";
	@cmds = ();
	while ($line = <$f>) {
		chop $line;
		@temp = split ";", $line;
		foreach $cmd (@temp) {
			push @cmds, $cmd;
		}
	}
	close $f;
}
$count_lines = 0;
$substitute_start = 0;
$substitute_end = 0;
$print_start = 0;
$print_end = 0;
$delete_start = 0;
$delete_end = 0;
if (@files > 0) {
	foreach $file (@files) {
		open $f, '<', $file or die "cannot open\n";
		($count_lines, $substitute_start, $substitute_end, $print_start, $print_end, $delete_start, $delete_end) = main($f, $count_lines, $substitute_start, $substitute_end, $print_start, $print_end, $delete_start, $delete_end);
		close $f;
	}
}
else {
	$input = 'STDIN';
	($count_lines, $substitute_start, $substitute_end, $print_start, $print_end, $delete_start, $delete_end) = main($input, $count_lines, $substitute_start, $substitute_end, $print_start, $print_end, $delete_start, $delete_end);
}



























