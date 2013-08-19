#!/usr/bin/perl -w

use strict;
use Utilities;

my %params;
my $file1_name="test_file";
my @indexes_file1=(0,1);
my @skipped=(5);

$params{"fn"}=$file1_name;
$params{"indx"}=\@indexes_file1;
$params{"delim"}="\t";
$params{"skipped"}=\@skipped;
my $params_ref=\%params;

my %file_meta_ref=Utilities::read_file(\%params);
#my %file2=Utilities::read_file($file2_name,@indexes_file2);

Utilities::find_ui(${file_meta_ref}{"file"});