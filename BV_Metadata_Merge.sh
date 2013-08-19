
#Cut and paste Teleform sheet into new empty doc
cut -f1,4,7,8,46,49 teleform > teleform_filtered

#Copy and paste 1,5,10 file and call it BV
cut -f2,5,7,10-22,58-83 BV > BV_filtered

cut -f2-7 Nugent > Nugent_filtered
