#!/usr/bin/perl -w

## The following script assigns hex color codes to node names based on either species or subunit type to be used in iTol online phylogenetic tree builder. 
## iTol can uilize color definitions for each node on a tree using a tab delimied file. 
## The file format is:
## <nodename>	range/clade/label	<#hexcolor>	<name-for legend>
## I will use a 30 character cut version of the the fasta headers to generate the mapping between node label and color assignment. Colors can either be assignmed to species or subunit types.
## Input files:
## Arg 1: color mapping file in the format <hex_code>	<subunitm_mapping>	<species_mapping>
## Arg 2: Node label file, format: <30 character truncated node label (unique)>	<species-level label (non uniqe) or subunit label (non unique)
## Arg 3: either "species" or "subunit" signifgying which hash mapping to look up (species->color or subunit->color)

use strict;

my $value_type=$ARGV[2]; ## either species or subunit
open(my $color_map_file,$ARGV[0]); ## maps hex color codes to subunit and species names
my %color_map;
while(<$color_map_file>){
	chomp;
	my($hex,$subunit,$species)=split("\t"); ## 3 fields: hex code, subunit type (1-12) and species name
	$color_map{$subunit}{"subunit"}=$hex; ## Same hash, but using a double key design. This is where 3rd argument comes into play to recall the subunit or species
	$color_map{$species}{"species"}=$hex;	
}
close($color_map_file);

## Now, map the node type to the color using color map and non unique key from node file
open(my $nodes_file,$ARGV[1]);
while(<$nodes_file>){
	chomp;
	my ($node,$key)= split("\t");
	print $node."\trange\t".$color_map{$key}{$value_type}."\t".$key."\n"; ## formatted for http://itol.embl.de 
}
close($nodes_file);

## Example input files:
## Color_map.txt (no headers):
#FF3300	6	Apis_mellifera
#FF9900	1	Nasonia_vitripennis
#FF66FF	2	NA

## Node label file:
#Anopheles_gambiae_3|su6|gi|518	Anopheles_gambiae
#Anopheles_gambiae_5|su6|gi|518	Anopheles_gambiae
#Apis_mellifera_1|su6|gi|121583	Apis_mellifera

## Example code command:
#assign_colors.pl color_map.txt any_species_alpha6.fastaheaders.cut.txt species > any_species_alpha6.colorDefinition 

## Example output:
#Anopheles_gambiae_3|su6|gi|518	range	#99CCFF	Anopheles_gambiae
#Anopheles_gambiae_5|su6|gi|518	range	#99CCFF	Anopheles_gambiae
#Apis_mellifera_1|su6|gi|121583	range	#FF3300	Apis_mellifera
#Nasonia_vitripennis_2|su6|gi|2	range	#FF9900	Nasonia_vitripennis
#Nasonia_vitripennis_3|su6|gi|2	range	#FF9900	Nasonia_vitripennis
#Nasonia_vitripennis_10|su6|gi|	range	#FF9900	Nasonia_vitripennis
#Plutella_xylostella_1|su6|gi|2	range	#66FF33	Plutella_xylostella
#Plutella_xylostella_2|su6|gi|2	range	#66FF33	Plutella_xylostella

## The above file can be used alongside the phylogenetic tree file in http://itol.embl.de when choosing advaned color options