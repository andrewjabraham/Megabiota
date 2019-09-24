#Load required packages
library(ggplot2)
library(rgdal)
library(maps)
library(maptools)
gpclibPermit()

#Load ensemble means
a<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/HeterotrophMetabolism_EndEctCombined_Map_kJday.csv", stringsAsFactors=F)

#Remove turn 0s into NAs
a[which(a[,3] == 0),]<-NA
a[which(a[,4] == 0),]<-NA
a[which(a[,5] == 0),]<-NA

#Add +1 to lat and long to centre each grid cell
a<-data.frame((a[,1]+1),(a[,2]+1),a[,3:5])

#Load world boarders
wmap<-readOGR(dsn="/Users/andrewabraham/Dropbox/Madingley & Megabiota/ne_110m_land", layer="ne_110m_land")
wmap<-fortify(wmap)

tiff('Pleistocene_Met_map.tiff', units="in",width=5, height=5, res=500)

#Plot Plesitocene World
ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=a, aes(x=a[,2], y=a[,1], fill=a[,5]), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  scale_fill_distiller(palette ="Spectral",na.value=NA,
                       breaks=c(1,35000000,70000000),
                       limits=c(0,70000000),
                       labels=c("0e+00","3.5e+07","7e+07"),
                       guide=guide_colourbar(title="Heterotroph Metabolism \n(kJ/km2/day)"))



dev.off()

#Calculate difference
d<-data.frame(a[,4]-a[,3])
e<-data.frame(a[,5]-a[,3])

d<-data.frame(a[,1:2],d[,1])
e<-data.frame(a[,1:2],e[,1])

tiff('Sim1000_Met_map.tiff', units="in",width=5, height=5, res=500)

#Plot Sim_1000_ensemble difference
ggplot() + coord_equal() +  
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=d, aes(x=d[,2], y=d[,1], fill=d[,3]), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  scale_fill_distiller(palette ="PuOr",na.value=NA,
                       breaks=c(-4e+7,0,4e+7),
                       limits=c(-4e+7,4e+7),
                       labels=c("-4e+07","0","4e+07"),
                       guide=guide_colourbar(title="Difference (kJ/km2/day)  \n "))

dev.off()

tiff('Sim100_Met_map.tiff', units="in",width=5, height=5, res=500)

#Plot Sim_100_ensemble difference
ggplot() + coord_equal() +  
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=e, aes(x=e[,2], y=e[,1], fill=e[,3]), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  scale_fill_distiller(palette ="PuOr",na.value=NA,
                       breaks=c(-4e+7,0,4e+7),
                       limits=c(-4e+7,4e+7),
                       labels=c("-4e+07","0","4e+07"),
                       guide=guide_colourbar(title="Difference (kJ/km2/day)   \n "))

dev.off()