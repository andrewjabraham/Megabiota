library(readr)
library(ggplot2)
library(rgdal)

a<-read_csv("~/Dropbox/Madingley & Megabiota/HeterotrophMetabolism_EndMap_kJday.csv")

b<-data.frame(a[,1],a[,2],(a[,17]-a[,9]))

c<-data.frame(a[,1],a[,2],(a[,25]-a[,9]))

#Load world boarders
wmap<-readOGR(dsn="/Users/andrewabraham/Dropbox/Madingley & Megabiota/ne_110m_land", layer="ne_110m_land")
wmap<-fortify(wmap)

#Plot Plesitocene World
ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=a, aes(x=a[,2], y=a[,1], fill=a[,9]), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  geom_hline(yintercept=23.5) + geom_hline(yintercept=-23.5) +
  scale_fill_distiller(palette ="Spectral",na.value=NA,
                       breaks=c(1,35000000,70000000),
                       limits=c(0,70000000),
                       labels=c("0e+00","3.5e+07","7e+07"),
                       guide=guide_colourbar(title="End Met \n(kmJ/km2/day)        "))


ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=b, aes(x=b[,2], y=b[,1], fill=b[,3]), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  geom_hline(yintercept=23.5) + geom_hline(yintercept=-23.5) +
  scale_fill_distiller(palette ="PuOr",na.value=NA,
                       breaks=c(-25000000,0,25000000),
                       limits=c(-25000000,25000000),
                       labels=c("-2.5e+07","0e+00","2.5e+07"),
                       guide=guide_colourbar(title="End Met \n(kmJ/km2/day)         "))


ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=c, aes(x=c[,2], y=c[,1], fill=c[,3]), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  geom_hline(yintercept=23.5) + geom_hline(yintercept=-23.5) +
  scale_fill_distiller(palette ="PuOr",na.value=NA,
                       breaks=c(-25000000,0,25000000),
                       limits=c(-25000000,25000000),
                       labels=c("-2.5e+07","0e+00","2.5e+07"),
                       guide=guide_colourbar(title="End Met \n(kmJ/km2/day)         "))

d<-a[which(a[,1] < 24),]
d<-a[which(a[,1] > -24),]
d<-data.frame(d[,1],d[,2],d[,9])
d[d == 0] <- NA
d_mean<-mean(d[,3],na.rm=T)

e<-a[which(a[,1] < 24),]
e<-a[which(a[,1] > -24),]
e<-data.frame(e[,1],e[,2],e[,17])
e[e == 0] <- NA
e_mean<-mean(e[,3],na.rm=T)

f<-a[which(a[,1] < 24),]
f<-a[which(a[,1] > -24),]
f<-data.frame(f[,1],f[,2],f[,25])
f[f == 0] <- NA
f_mean<-mean(f[,3],na.rm=T)

x<-data.frame(1,d_mean)
y<-data.frame(2,e_mean)
z<-data.frame(3,f_mean)

colnames(x)<-c("No","Met")
colnames(y)<-c("No","Met")
colnames(z)<-c("No","Met")

data<-rbind(x,y,z)

ggplot(data=data,aes(x=data[,1],y=data[,2])) + geom_bar(stat="identity",size=0.5) +
  coord_flip() + theme_classic() + xlab("") + ylab("\nMean Tropics End Metabolism \n(kJ/km2/yr)") +
  scale_x_continuous(breaks=c(1,2,3),labels = c("Pleistocene","Current","Future"))

