#!/usr/bin/perl -w

use strict;
package Utilities;

sub in{
my ($query,@vals)=@_; 
my $return_val=0;
foreach my $val (@vals){

    if($query eq $val){
    $return_val=1;
    }
    
}
return $return_val;
}

sub read_file{
my $params=$_[0];
my $file_name=$$params{"fn"};
my $indexes=$$params{"indx"};
my $delim=$$params{"delim"};
my $skipped=$$params{"skipped"};

my %file_hash;

my %duplicate_lines;

my $line_number=1;
open(F,$file_name);

while(<F>){
    if(!in($line_number,@$skipped)){
    chomp;
    my @line=split($delim);

    my @keys;
    for my $val (@$indexes){
        push(@keys,$line[$val]);
    }
    my $cpd_keys=join("_",@keys);
    if (exists $file_hash{$cpd_keys} && !exists $duplicate_lines{$cpd_keys}){
        $duplicate_lines{$cpd_keys}=1;
    }
    elsif(exists $file_hash{$cpd_keys} && exists $duplicate_lines{$cpd_keys}){
        $duplicate_lines{$cpd_keys}++;
    }
    $file_hash{$cpd_keys}=join($delim,@line);
    }
    $line_number++;
    }
my %return_val;
$return_val{"file"}=\%file_hash;
$return_val{"duplicates"}=\%duplicate_lines;
return %return_val;
}

sub find_ui{
my $file1=$_[0];
print $$file1{"Tim_3"};

foreach my $val (sort %$file1){
print "$val\n";
}


}

1;