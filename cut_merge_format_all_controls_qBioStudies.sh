rm all_control_ct_vals/cut_files_0*
for i in `find . -name *_mappedCtVals_QC`
do
NEW_NAME=`echo $i| sed 's/\.\///g' | sed 's/\//_/g'`
perl -pne 'BEGIN{$newname=$ARGV[0];$newname=~s/(.)+_(W\dD\d)_(.)+/$2/;$newname=~s/(.)+_(VM018)_(.)+/$2/; $newname=~s/(.)+_(NTC_PA052\d)_(.)+/$2/;print "$newname\t"x12;print "\n"};' $i | cut -f1,10,11 | perl -ne 'print if $. <=8' > all_control_ct_vals/cut_files_$NEW_NAME
done

paste cut_files_* > cut_files_all