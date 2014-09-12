#!/usr/bin/perl -w
use strict;
open(my $map_file,$ARGV[0]);
while(<$map_file>){
	chomp;
	my ($old_file_fullpath,$new_file_fullpath) = split("\t");
	if(rename $old_file_fullpath,$new_file_fullpath){
		print "Renamed\t".$old_file_fullpath."\tto\t".$new_file_fullpath."\ton\t".localtime()."\n"
	}
	else{
		print "**ERROR COULD NOT RENAME\t".$old_file_fullpath."\tto\t".$new_file_fullpath."\t!!!\n"
	};

}