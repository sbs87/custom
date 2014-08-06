#!/usr/bin/perl
use strict;
use warnings;
use Utilities;

my @subjects=(1,2,3);
my @indexes_file1=(0,1);
my @skipped=(0);

my %params_f1;
$params_f1{"fn"}="/Users/stevensmith/Dropbox/Working/Nugent_reformatted.txt";
$params_f1{"indx"}=\@indexes_file1;
$params_f1{"delim"}="\t";
$params_f1{"skipped"}=\@skipped;

my %meta_file1=Utilities::read_file(\%params_f1);
my %file=%{$meta_file1{"file"}};

foreach my $id (keys %file){
print $file{$id};
my $time="W3D2";
my $score="4";
#print "$time\t$score\n";
}