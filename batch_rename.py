#!/usr/bin/python
## Version 2.0 : Ported to Python
## August 5, 2014
## Steven Smith
# use strict

## Name mapping file and all files to be renamed should reside in same directory
## Must provide full paths
## All renamed files should have the same format, and should only differ in i.e., numbering. Example:
##	rename files File_1.txt, File_2.txt, File_3.txt to File_A.txt, FIle_B.txt and FIle_C.txt. 

## Does not handle incorrect input in command line or non existent files. D

##Inputs:
##	Argument
##	1:	Mapping File
##	2:	Full firectory where files reside
##	3:	PRefix in all file names
##	4:	Suffic in all file names
##	5:	1 for headers in mapping file

import sys
import os
import csv
version="2.0"

## Define variables and command line inputs. Note all five argyments mussed be passed. 
file_map={} ## Dictionary to map original base file name to new name
renaming_map_file_name=sys.argv[1] ## file that conains two columns: the orginal base name and new name. Gets read into file_map
directory=sys.argv[2]+"/" ## The directory containing the to-be renamed files
prefix=sys.argv[3] ## The file-wide prefix existing on all named files (before and after) i.e., file_
suffix=sys.argv[4] ## The file-wide suffic existing on all named files (before and after) i.e., .txt
headers=sys.argv[5] ## Whether or not the mapping file contains headers. Anything but a 1 is considered false

## Read in mapping file

with open(renaming_map_file_name,'r') as f:
    #Skip first line if headers exist
    if int(headers) is 1:
    	next(f)
    #Define a csv reader object to parse the tab delimited file
    reader=csv.reader(f,delimiter='\t')
    #read in columns 1 and 2, define col 1 as original base file name, col 2 as the new base name, map it
    for original_base_name,new_base_name in reader:
        file_map[original_base_name]=new_base_name

## Begin to output ressults 

print("""-----------------------------------------------
-----------------------------------------------
File name change info using batch_rename.py, version """+version+"""
-----------------------------------------------
-----------------------------------------------

///////////////////////////////
  Original directory listing   
///////////////////////////////""")

os.system("ls -l "+directory)

print("""
////////////////

Original Base Name\tNew Base Name\tOld Full Path\tNew Full Path""")

## Rename files based on the dictionary file read in above and the full directory path. Also display old -> new file names
for num_key in file_map.keys():
	old_file_fullpath=directory+prefix+num_key+suffix
	new_file_fullpath=directory+prefix+file_map[num_key]+suffix
	print(num_key+"\t"+file_map[num_key]+"\t"+old_file_fullpath+"\t"+new_file_fullpath)
	os.rename(old_file_fullpath,new_file_fullpath)

print("""

///////////////////////////////
  New directory listing   
///////////////////////////////
""")
os.system("ls -l "+directory)

print("""
/////////////////
////  DONE /////
/////////////////""")

