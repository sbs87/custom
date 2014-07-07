#!/usr/bin/perl -w

use strict;
use Utilities;

my %params_f1;
my $file1_name=$ARGV[0];
#my $file1_name="test_file";

my %params_f2;
#my $file2_name="test_file_2";
my $file2_name=$ARGV[1];

my @indexes_file1=(0,1);
my @indexes_file2=(0,1);
my $delimiter="\t";
my @skipped=(1);

$params_f1{"fn"}=$file1_name;
$params_f1{"indx"}=\@indexes_file1;
$params_f1{"delim"}=$delimiter;
$params_f1{"skipped"}=\@skipped;

$params_f2{"fn"}=$file2_name;
$params_f2{"indx"}=\@indexes_file2;
$params_f2{"delim"}=$delimiter;
$params_f2{"skipped"}=\@skipped;

my %file_1=Utilities::read_file(\%params_f1);
my %file_2=Utilities::read_file(\%params_f2);

Utilities::find_ui(\%file_1,\%file_2);