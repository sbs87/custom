library(ggplot2)
rm(list=ls())
#setwd("/Users/stevensmith/IGS/sshfs_diag/cloud/stsmith/HostReponse_LacticAcid/results/cuffdiff_out/")
#setwd("/Users/stevensmith/IGS/sshfs_medusa/")
#setwd("/Users/stevensmith/IGS/")
setwd("/Users/stsmith/Projects/Host_Response_Lactic_Acid/diag_fuse/cloud/stsmith/HostReponse_LacticAcid/results/cuffdiff_out/")

#list.files()
#figure_location<-"/Users/stevensmith/IGS/sshfs_diag/cloud/stsmith/HostReponse_LacticAcid/results/stats_and_summaries/"
#figure_location<-"/Users/stevensmith/IGS/temp/"
figure_location<-"/Users/stsmith/Projects/Host_Response_Lactic_Acid/diag_fuse/cloud/stsmith/HostReponse_LacticAcid/results/stats_and_summaries/"

(comparisons<-list.files()[grep("_vs_",list.files())])
(comparisons<-comparisons[grep("txt",comparisons,invert=T)])
## there are 3 comparisons in Philippe's data that are missing diff.exp files (emptty:)
#DL4_vs_DL4CT/gene_exp.diff
#L4_vs_DL4/gene_exp.diff
#MEDCT_vs_D4CT/gene_exp.diff
# Need to manually remove. None of these match with my input, so no need to specify source
(comparisons<-comparisons[!comparisons %in% c("DL4_vs_DL4CT","L4_vs_DL4","MEDCT_vs_D4CT")])
for(comparison_name in comparisons){
  #comparison_name<-comparisons[6]
  print(comparison_name)
  file_name<-paste(comparison_name,"/gene_exp.diff",sep="")
  diff.exp<-read.table(file_name,sep="\t",header=T)
  #diff.exp[abs(diff.exp$log2.fold_change.)>1.7976e+308,]
  diff.exp$log2.fold_change.[abs(diff.exp$log2.fold_change.)>1.7976e+308]<-NA
  #head(diff.exp)
  diff.exp.filter<-diff.exp[diff.exp$q_value<.99,]
  #hist(diff.exp.filter$q_value)
  #data.frame(diff.exp$log2.fold_change.,diff.exp$q_value)

  postscript(file=paste(figure_location,comparison_name,".Pvalue_lt_0.99.pvalue_histogram.ps",sep=""))
  histogram<-ggplot(diff.exp.filter)+geom_histogram(aes(fill=significant,x=q_value))+theme_bw()+ggtitle(file_name)
  plot(histogram)
  dev.off()

  #postscript(file=paste(figure_location,comparison_name,".volcano.ps",sep=""))
  #volcano<-ggplot(diff.exp)+geom_point(aes(x=log2.fold_change.,y=-log(diff.exp$q_value,base=10)))+
  #  theme_bw()+ggtitle(paste("Volcano Plot",file_name))+xlab("Log2 Fold Change")+ylab("-log10(Adj p-value")+
  #  geom_hline(yintercept=-log(.05,base=10),color='red')+geom_vline(xintercept=c(-1.5,1.5),color='red')
  #plot(volcano)
  #dev.off()
}
