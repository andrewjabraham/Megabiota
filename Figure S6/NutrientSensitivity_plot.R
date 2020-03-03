library(ggplot2)
library(grid)

a<-read.csv("~/Dropbox/Madingley & Megabiota/Megabiota-master/Figure S6/NutrientDiffusivity_Sensitivity.csv", stringsAsFactors=F)

tiff('~/Desktop/Revised_nutrient/Figure S6.tiff', units="in",width=5, height=5, res=500)

q1<-ggplot() + theme_bw() +
  scale_y_continuous(name=expression(Nutrient~Diffusivity~(10^11~km^2/day)), breaks=c(0,7,14),
                     labels=c("0","7","14"),limits=c(0,14)) +
  scale_x_continuous(name="Individual Body Mass (g)", breaks=c(1.1,5.7,10.3,14.9,19.5,24.1),
                     labels=c("0.001","0.1","10","1000","100000","10000000"),limits=c(0,25)) +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank(), 
        panel.grid.minor.x = element_blank(),
        panel.border = element_rect(size=1),
        axis.title = element_text(size=9),
        axis.text = element_text(size=9),
        aspect.ratio = 0.56) + 
  geom_ribbon(data=a,aes(x=a[,1],ymin=a[,2]/10^11,ymax=a[,4]/10^11),fill="black",alpha=0.2) +
  geom_ribbon(data=a,aes(x=a[,1],ymin=a[,5]/10^11,ymax=a[,7]/10^11),fill="purple",alpha=0.3) +
  geom_ribbon(data=a,aes(x=a[,1],ymin=a[,8]/10^11,ymax=a[,10]/10^11),fill="orange",alpha=0.4) +
  geom_path(data=a,aes(x=a[,1],y=a[,3]/10^11,colour="Sim_10000"),size=0.8) +
  geom_point(data=a,aes(x=a[,1],y=a[,3]/10^11),colour="black",size=0.8) +
  geom_path(data=a,aes(x=a[,1],y=a[,6]/10^11,colour="Sim_1000"),size=0.8) +
  geom_point(data=a,aes(x=a[,1],y=a[,6]/10^11),colour="purple",size=0.8) +
  geom_path(data=a,aes(x=a[,1],y=a[,9]/10^11,colour="Sim_100"),size=0.8) +
  geom_point(data=a,aes(x=a[,1],y=a[,9]/10^11),colour="orange",size=0.8) +
  scale_colour_manual(name="Line Color",
                      values=c(Sim_10000="black", Sim_1000="purple", Sim_100="orange")) +
  theme(legend.position = "none")

b<-read.csv("~/Dropbox/Madingley & Megabiota/Megabiota-master/Figure 5/HeterotrophNutrient_EndEct_MEAN.csv", stringsAsFactors=F)

q2<-ggplot() + theme_bw() + xlab("") +
  scale_y_continuous(name=expression(Global~Nutrient~Diffusivity~(10^11~km^2/day)), breaks=c(0,18,36),
                     labels=c("0.0","18","36"),limits=c(0,36)) +
  scale_x_discrete(name="",labels=c("3","2","1")) +
  geom_bar(data=b,aes(x=b[,1],y=b[,4]/10^11,fill="red"),stat="identity",width=0.5) +
  geom_errorbar(data=b,aes(x=b[,1],ymin=b[,3]/10^11,ymax=b[,5]/10^11),width=0.2) +
  coord_flip() +  theme(plot.background = element_rect(fill="transparent",colour=NA),
                        panel.grid.major.y = element_blank(), 
                        panel.grid.minor.y = element_blank(),
                        panel.grid.major.x = element_blank(),
                        panel.grid.minor.x = element_blank(),
                        panel.border = element_blank(),
                        panel.background = element_blank(),
                        axis.line = element_line(size=0.5),
                        axis.title = element_text(size=8)) + 
  scale_fill_manual(guide = FALSE,values = c("#ED4337"))


#Insert histogram into line plot
grid.newpage()
vp_q1<-viewport(width=1,height=1,x=0.5,y=0.5)  # the larger map
vp_q2<-viewport(width=0.45,height=0.25,x=0.4,y=0.64)  # the inset in upper left
print(q1, vp = vp_q1)
print(q2, vp = vp_q2)

dev.off()

