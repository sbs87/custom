#!/usr/bin/python
import sys

#read in universe file and input file
universe_p=open(sys.argv[1],'r')
file_p=open(sys.argv[2],'r')
binary=sys.argv[3]

universe=[]
file={}

for eachline in universe_p:
	key=eachline.rstrip()
	universe.append(key)

for eachline in file_p:
	if(binary):
		key=eachline.rstrip()
		file[key]="1"
	else:
		(key, value)=eachline.rstrip().split('\t')
		file[key]=value

print "%s\t%s" % (sys.argv[2],sys.argv[2])			
for key in universe:
	if(key in file.keys()):
		print "%s\t%s" % (key, file[key])
	else:
		print "%s\t" % (key)
