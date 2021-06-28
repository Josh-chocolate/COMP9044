#!/usr/bin/perl
@file_arr = <>;
@shuffled_arr=();
$size = @file_arr;
while ($size > 0){
    $index = rand($size);
    push(@shuffled_arr, $file_arr[$index]);
    splice(@file_arr, $index, 1);
    $size -= 1;
}
    
print @shuffled_arr;