library(ggplot2)

#Read in end/ect metabolism data
MM_end<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/x_1199_new.csv",header=T,stringsAsFactors=F)
MM_ect<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/y_1199_new.csv",header=T,stringsAsFactors=F)

N_end<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Metabolism Data/Individual Metabolic Rate/Nagy_end.csv",header=T,stringsAsFactors=F)
N_ect<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Metabolism Data/Individual Metabolic Rate/Nagy_ect.csv",header=T,stringsAsFactors=F)

tiff('Metabolism_Nagy.tiff', units="in",width=5, height=5, res=500)

ggplot() + theme_bw() +
  xlab("Body Mass (g)") + ylab("Metabolic Rate (kJ/day)") +
  geom_point(data=MM_end,aes(x=MM_end[,2],y=MM_end[,3],colour='MM_end'),alpha=0.05) +
  geom_point(data=MM_ect,aes(x=MM_ect[,2],y=MM_ect[,3],colour='MM_ect'),alpha=0.05) +
  geom_point(data=N_end,aes(x=as.numeric(N_end[,1]),y=as.numeric(N_end[,2]),colour="N_end")) +
  geom_point(data=N_ect,aes(x=as.numeric(N_ect[,1]),y=as.numeric(N_ect[,2]),colour="N_ect")) +
  scale_y_log10(limits=c(0.0001,100000000),breaks=c(0.0001,0.01,1,100,10000,1000000,100000000),labels=c('1e-04','1e-02','1e+00','1e+02','1e+04','1e+06','1e+08')) + 
  scale_x_log10(limits=c(0.0001,100000000),breaks=c(0.0001,0.01,1,100,10000,1000000,100000000),labels=c('1e-04','1e-02','1e+00','1e+02','1e+04','1e+06','1e+08')) +
  scale_colour_manual(guide=guide_legend(),name="",values=c(MM_end="#FA8072",N_end="#FF0000",MM_ect="#87CEFA",N_ect="#0000FF"),
                      labels=c("Madingley Ectotherms","Madingley Endotherms", "Nagy et al. (1999) Ectotherms","Nagy et al. (1999) Endotherms")) +
  theme(panel.border=(element_rect(colour="black",fill=NA,size=0.5)),
        axis.title=element_text(size=12),
        axis.text=element_text(size=10),
        aspect.ratio=1,
        legend.position="none")

dev.off()




















