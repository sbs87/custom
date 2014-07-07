#!/usr/bin/perl -w
## Version 2.0 
## July 7, 2104
## Steven Smith
use strict;

my $version=2.0;

my %file_map;
my $renaming_map_file_name=$ARGV[0];
my $directory=$ARGV[1]."/";
my $prefix=$ARGV[2];
my $suffix=$ARGV[3];
my $original_ls=`ls -l $directory`;

open(my $file_handle, $renaming_map_file_name);
while(<$file_handle>){
	chomp;
	my @array=split('\t');
	my $original_base_name=$array[0];
	my $new_base_name=$array[1];
	$file_map{$original_base_name}=$new_base_name;
	}
close($file_handle);

print "File name change info using batch_rename.pl, version ".$version."\n";
print "Original Base Name\tNew Base Name\tOld Full Path\tNew Full Path\n";
foreach my $num_key (keys %file_map){
	my $old_file_fullpath=$directory.$prefix.$num_key.$suffix;
	my $new_file_fullpath=$directory.$prefix.$file_map{$num_key}.$suffix;
	print $num_key."\t".$file_map{$num_key}."\t".$old_file_fullpath."\t".$new_file_fullpath."\n";
	rename $old_file_fullpath,$new_file_fullpath;
}

print "\n///////////////////////////////\nThe Original Directory Listing:\n///////////////////////////////\n\n";
print $original_ls;
print "\n///////////////////////////////\nThe New Directory Listing:\n///////////////////////////////\n\n";
print `ls -l $directory`;
print "\n\nDONE\n";

