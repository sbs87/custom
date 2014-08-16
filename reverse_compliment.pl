#!/usr/bin/perl -w
use strict;
use Getopt::Long;

use Pod::Usage;
my $man = 0;
my $help = 0;

## Finds the reverse compliment of a string input

my $rev_comp_out   = "rc";
my $dna_rna="IUPAC"; ## Defines what translated sequence output format should be. 
my $input_type="iupac"; ## Can be changed to explicitly define input sequence as strictly RNA, DNA or IUPAC (no discrimination of RNA vs DNA in IUPAC)

## Get flags, male appropaiate controls
GetOptions ("rc=s" => \$rev_comp_out,    # string
              "o=s"  => \$dna_rna, # string
              "i=s" => \$input_type, # string
              'help|?' => \$help, 
              man => \$man)   
or die("Error in command line arguments\n");
pod2usage(-exitval => 0, -verbose => 2) if ($man | $help);

#Standardize the inputs
$rev_comp_out=lc($rev_comp_out);
$dna_rna=uc($dna_rna);
$input_type=lc($input_type);

die ("Error in flag: Reverse Complement (rc) flag must be one of either 'r', 'c', or 'rc'\n") unless ($rev_comp_out eq "rc" | $rev_comp_out eq "r" | $rev_comp_out eq "c");
die ("Error in flag: DNA/RNA (na) flag must be either 'DNA' or 'RNA\n") unless ($dna_rna eq "DNA" | $dna_rna eq "RNA" | $dna_rna eq "IUPAC" );
die ("Error in flag: Sequence input type (i) flag must be one of either 'DNA' or 'RNA' or 'both'\n") unless ($input_type eq "dna" | $input_type eq "rna" | $input_type eq "either" | $input_type eq "iupac");


## Accepted alphabet
my $nucleic_acid_alphabet="ATGCU"; ## DNA and RNA accepted letters. Future releases should inlcude IUPAC
my $iupac_alphabet=$nucleic_acid_alphabet."YRSWMKVHDBN";
my $DNA_alphabet="ATCG";
my $RNA_alphabet="AUCG";

#Input sequence
my $input_seqeunce=$ARGV[0];

#Clean input sequence
$input_seqeunce=uc($input_seqeunce);
die ("ERROR: Your input sequence contains at least one non-nucleic acid or IUPAC character.\n") unless (!($input_seqeunce=~/[^($iupac_alphabet)]/));

if($input_type eq "dna"){
	die ("ERROR: Your DNA sequence contains at least one of an RNA or IUPAC character (to allow RNA or IUPAC characters, change input (i) flag).\n") unless (!($input_seqeunce=~/[^($DNA_alphabet)]/));
}elsif($input_type eq "rna"){
	die ("ERROR: Your RNA sequence contains at least one of an DNA or IUPAC character (to allow DNA or IUPAC characters, change input (i) flag).\n") unless (!($input_seqeunce=~/[^($RNA_alphabet)]/));
}elsif($input_type eq "mixed" | $dna_rna eq "DNA" | $dna_rna eq "RNA"){
	die ("ERROR: Your input sequence contains an IUPAC character (to allow IUPAC characters, change input (i) flag and/or the output (o) flag.\n") unless (!($input_seqeunce=~/[^($RNA_alphabet.$DNA_alphabet)]/));
}

my $comp_seq=$input_seqeunce; # Store for later

#reverse string
my $rev_seq=reverse $input_seqeunce;
my $rev_comp_seq=$rev_seq; # Store for later

#take complment (transliterate)
if($dna_rna eq "DNA"){
	$rev_comp_seq=~tr/ATCGU/TAGCA/; # Take compliment of the reversed sequence
	$comp_seq=~tr/ATCG/TAGC/; # only take compliment of original sequence, no reverse
}
elsif($dna_rna eq "RNA"){
	$rev_comp_seq=~tr/ATCGU/UAGCA/; # Take compliment of the reversed sequence
	$comp_seq=~tr/ATCGU/UAGCA/; # only take compliment of original sequence, no reverse
}
elsif($dna_rna eq "IUPAC"){
	$rev_comp_seq=~tr/ATCGURYSWKMBDHVN/UAGCAYRSWMKVHDBN/; # Take compliment of the reversed sequence
	$comp_seq=~tr/ATCGURYSWKMBDHVN/UAGCAYRSWMKVHDBN/; # only take compliment of original sequence, no reverse
}
else{
	print "Error in reverse compliment. Output may be garbage.\n";
}

if($rev_comp_out eq "rc"){
print $rev_comp_seq;
}
elsif($rev_comp_out eq "c"){
	print $comp_seq;
}
elsif($rev_comp_out eq "r"){
	print $rev_seq;
}else{
	print "Error in transliteration. Output may be garbage.\n";
}
print "\n";


## The following is for the man/help page, if the flag is sent
__END__
=head1 NAME
reverse_compliment sequence [options]
Options:
-help           help message & documentation
-man             same as help
-rc 		reverse compliment. Default is rc (reverse & compleimnt); can be c (compliment only) or r (reverse only)
-o 		output type - DNA, RNA or IUPAC characters. Defualt is RNA IUPAC.
-i input type-  DNA, RNA or IUPAC characters. Defualt is IUPAC.
OPTIONS
=head1 DESCRIPTION
Take a sequence of DNA or RNA and returns reverse compliment. Optional reverse and compliment only options as well as strict DNA, RNA IUPAC input and output. 
=cut