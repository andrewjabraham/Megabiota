library(ggplot2)
library(reshape)
library(grid)

a<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/Regional Biomass/US_MEAN.csv", stringsAsFactors=F)

tiff('HB_US.tiff', units="in",width=5, height=2.5, res=500)

ggplot() + theme_bw() + xlab("") +
  scale_y_continuous(name="Heterotroph Biomass Density\n(g/km2)", breaks=c(0,1.2e+9,2.4e+9),
                     labels=c("0","1.2e+09","2.4e+09"),limits=c(0,2.4e+9)) + 
  scale_x_continuous(name="Individual Body Mass (g)", breaks=c(1.1,5.7,10.3,14.9,19.5,24.1),
                     labels=c("0.001","0.1","10","1000","100000","10000000"),limits=c(0,25)) +
  geom_bar(data=a,aes(x=a[,1],y=a[,3],fill=a[,2]),stat="identity",position=position_stack(reverse=TRUE),width=0.9) +
  theme(plot.background = element_rect(fill="transparent",colour=NA),
                        panel.grid.major.y = element_blank(), 
                        panel.grid.minor.y = element_blank(),
                        panel.grid.major.x = element_blank(),
                        panel.grid.minor.x = element_blank(),
                        panel.border = element_rect(size=1),
                        axis.line = element_line(size=0),
                        axis.title = element_text(size=8),
                        axis.text = element_text(size=8)) +
  scale_fill_manual(values = c("#0085D7", "#ED4337")) +
  theme(legend.position="none",
        legend.title = element_text("."))

dev.off()
