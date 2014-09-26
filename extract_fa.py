from Bio import SeqIO                                                               
import sys                                                                          

## This script extarcts fasta records using a "wanted" file of fasta headers. Requires Bio module, which isn't on the grid. 
                                                                                    
wanted = [line.strip() for line in open(sys.argv[2])]                               
seqiter = SeqIO.parse(open(sys.argv[1]), 'fasta')                                    
SeqIO.write((seq for seq in seqiter if seq.id in wanted), sys.stdout, "fasta")
#for seq in seqiter:
#	print seq.id
#print(wanted)
