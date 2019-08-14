#Load required packages
library(ggplot2)
library(rgdal)
library(maps)
library(maptools)
gpclibPermit()

#Load ensemble means
a<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/HeterotrophNutDiff_Map_kgDMkm2km2day_MEAN.csv", stringsAsFactors=F)

#Remove turn 0s into NAs
a[which(a[,3] == 0),]<-NA
a[which(a[,4] == 0),]<-NA
a[which(a[,5] == 0),]<-NA

#Add +1 to lat and long to centre each grid cell
a<-data.frame((a[,1]+1),(a[,2]+1),a[,3:5])

#Load world boarders
wmap<-readOGR(dsn="/Users/andrewabraham/Dropbox/Madingley & Megabiota/ne_110m_land", layer="ne_110m_land")
wmap<-fortify(wmap)

tiff('Pleistocene_NutDiff_map.tiff', units="in",width=5, height=5, res=500)

#Plot Plesitocene World
ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=a, aes(x=a[,2], y=a[,1], fill=a[,3]), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  scale_fill_distiller(palette ="Spectral",na.value=NA,
                       breaks=c(1,19000,38000),
                       limits=c(0,38000),
                       labels=c("0e+00","1.9e+04","3.8e+04"),
                       guide=guide_colourbar(title="Nutrient Diffusivity (km2/day)   "))

dev.off()

#Calculate difference
d<-data.frame(a[,4]-a[,3])
e<-data.frame(a[,5]-a[,3])

d<-data.frame(a[,1:2],d[,1])
e<-data.frame(a[,1:2],e[,1])

tiff('Sim1000_NutDiff_map.tiff', units="in",width=5, height=5, res=500)

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
                       breaks=c(-38000,0,38000),
                       limits=c(-38000,38000),
                       labels=c("-3.8e+04","0","3.8e+04"),
                       guide=guide_colourbar(title="Difference (km2/day)      \n "))

dev.off()

tiff('Sim100_NutDiff_map.tiff', units="in",width=5, height=5, res=500)

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
                       breaks=c(-38000,0,38000),
                       limits=c(-38000,38000),
                       labels=c("-3.8e+04","0","3.8e+04"),
                       guide=guide_colourbar(title="Difference (km2/day)      \n "))

dev.off()