#Load required packages
library(ggplot2)
library(rgdal)
library(maps)
library(maptools)
#gpclibPermit()

#Load ensemble means
a<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/HB%/Pleistocene_abd.csv", stringsAsFactors=F)

#Add +1 to lat and long to centre each grid cell
a[,1]<-a[,1]+1
a[,2]<-a[,2]+1


#Load world boarders
wmap<-readOGR(dsn="/Users/andrewabraham/Dropbox/Madingley & Megabiota/ne_110m_land", layer="ne_110m_land")
wmap<-fortify(wmap)

tiff('Pleistocene_end_abd', units="in",width=5, height=5, res=500)

#Plot Sim1000 endotherm abd
ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=a, aes(x=a[,3], y=a[,2], fill=log(as.numeric(a[,13]))), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  scale_fill_distiller(palette ="Spectral",na.value=NA,
                       breaks=c(0.1,13,26),
                       limits=c(0,26),
                       labels=c("0","13","26"),
                       guide=guide_colourbar(title="Log Endotherm Abundance \nPer Grid Cell"))

dev.off()




tiff('Pleistocene_ect_abd.tiff', units="in",width=5, height=5, res=500)

#Plot Sim1000 endotherm abd
ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=a, aes(x=a[,3], y=a[,2], fill=log(as.numeric(a[,14]))), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  scale_fill_distiller(palette ="Spectral",na.value=NA,
                       breaks=c(0.1,18,36),
                       limits=c(0,36),
                       labels=c("0","18","36"),
                       guide=guide_colourbar(title="Log Ectotherm Abundance \nPer Grid Cell"))

dev.off()
