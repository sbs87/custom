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
my $max_cols=0;

my $line_number=1;
open(F,$file_name);

while(<F>){
    if(!in($line_number,@$skipped)){
    chomp;
    my @line=split($delim);
    my $length=@line;
    if($length>$max_cols){
    $max_cols=$length;
    }

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
$return_val{"max_cols"}=\$max_cols;

return %return_val;

}

sub find_ui{
my %meta_file1=%{$_[0]};
my %file1=%{$meta_file1{"file"}};
my %meta_file2=%{$_[1]};
my %file2=%{$meta_file2{"file"}};
my $max_cols_file2=${$meta_file2{"max_cols"}};

foreach my $id_file2 (keys %file2){
	foreach my $id_file1 (keys %file1){
		if($id_file1 eq $id_file2){
			print $file1{$id_file1}."\t".$file2{$id_file2}."\n";
		}
		else{
			print $file1{$id_file1}."\t"x$max_cols_file2;
			print "\n";
		}
	}
}
}

1;