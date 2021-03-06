library(ggplot2)
library(reshape)
library(grid)

a<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/HeterotrophBiomass_MassBins_MEAN.csv", stringsAsFactors=F)

tiff('HeterotrophicBiomass_MassBins_plot.tiff', units="in",width=5, height=5, res=500)

q1<-ggplot() + theme_bw() + 
  scale_y_continuous(name="Heterotroph Biomass (Pg)", breaks=c(0,2.5,5),
                     labels=c("0.0","2.5","5.0"),limits=c(0,5)) +
  scale_x_continuous(name="Individual Body Mass (g)", breaks=c(1.1,5.7,10.3,14.9,19.5,24.1),
                     labels=c("0.001","0.1","10","1000","100000","10000000"),limits=c(0,25)) +
  theme(panel.border = element_rect(size=1),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        axis.title = element_text(size=10),
        axis.text = element_text(size=9),
        aspect.ratio = 0.56) + 
  geom_path(data=a,aes(x=a[,1],y=(a[,2]/10^15),colour="Pleistocene"),size=1) +
  geom_point(data=a,aes(x=a[,1],y=(a[,2]/10^15),colour="Pleistocene"),size=1.5) +
  geom_path(data=a,aes(x=a[,1],y=(a[,3]/10^15),colour="Modern"),size=1) +
  geom_point(data=a,aes(x=a[,1],y=(a[,3]/10^15),colour="Modern"),size=1.5) +
  geom_path(data=a,aes(x=a[,1],y=(a[,4]/10^15),colour="Future"),size=1) +
  geom_point(data=a,aes(x=a[,1],y=(a[,4]/10^15),colour="Future"),size=1.5) +
  scale_colour_manual(name="",
                      values=c(Pleistocene="black", Modern="purple", Future="orange")) +
  theme(legend.position="bottom")


b<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/HeterotrophBiomass_EndEct_MEAN.csv", stringsAsFactors=F)

q2<-ggplot() + theme_bw() + xlab("") +
  scale_y_continuous(name="Global Heterotroph Biomass \n(Pg)", breaks=c(0,12.5,25),
                     labels=c("0.0","12.5","25.0"),limits=c(0,25)) + 
  scale_x_discrete(name="",labels=c("3","2","1")) +
  geom_bar(data=b,aes(x=b[,1],y=b[,3]/10^15,fill=b[,2]),stat="identity",position=position_stack(reverse=TRUE),width=0.5) +
  coord_flip() +  theme(plot.background = element_rect(fill="transparent",colour=NA),
                        panel.grid.major.y = element_blank(), 
                        panel.grid.minor.y = element_blank(),
                        panel.grid.major.x = element_blank(),
                        panel.grid.minor.x = element_blank(),
                        panel.border = element_blank(),
                        axis.line = element_line(size=0.5),
                        axis.title = element_text(size=8),
                        axis.text = element_text(size=8)) +
  scale_fill_manual(values = c("#0085D7", "#ED4337")) +
  theme(legend.position="none",
        legend.title = element_text("."))


#Insert histogram into line plot
grid.newpage()
vp_q1<-viewport(width=1,height=1,x=0.5,y=0.5)  # the larger map
vp_q2<-viewport(width=0.35,height=0.25,x=0.35,y=0.70)  # the inset in upper left
print(q1, vp = vp_q1)
print(q2, vp = vp_q2)

dev.off()
