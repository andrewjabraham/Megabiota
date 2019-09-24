#Load required packages
library(ggplot2)
library(rgdal)
library(maps)
library(maptools)
#gpclibPermit()

#Load ensemble means
a<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/HB%/HeterotrophBiomass_Map_gkm2_MEAN.csv", stringsAsFactors=F)

#Remove turn 0s into NAs
a[a == "#DIV/0!"]<-NA


#Add +1 to lat and long to centre each grid cell
a<-data.frame((a[,1]+1),(a[,2]+1),a[,3:7])

#Load world boarders
wmap<-readOGR(dsn="/Users/andrewabraham/Dropbox/Madingley & Megabiota/ne_110m_land", layer="ne_110m_land")
wmap<-fortify(wmap)

tiff('Sim1000_HB_per.tiff', units="in",width=5, height=5, res=500)

#Plot Sim1000 percentage
ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=a, aes(x=a[,2], y=a[,1], fill=as.numeric(a[,6])), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  scale_fill_gradient2(low = "darkblue", mid = "yellow", high = "red",
                       na.value=NA, midpoint=100,
                       breaks=c(1,100,200),
                       limits=c(0,200),
                       labels=c("0","100","200"),
                       guide=guide_colourbar(title="% Change"))

dev.off()

tiff('Sim100_HB_per.tiff', units="in",width=5, height=5, res=500)


#Plot Sim100 percentage
ggplot() + coord_equal() + 
  scale_x_continuous(name="", breaks=c(-180,0,180),labels=c("-180","0","180"),limits=c(-180,180)) + 
  scale_y_continuous(name="", breaks=c(-90,0,90),limits=c(-90,90)) + 
  theme_bw() + theme(axis.title.x=element_blank(),axis.title.y=element_blank()) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(panel.border = element_rect(size=1)) +
  theme(legend.position="bottom",legend.direction="horizontal",legend.key.width=unit(1,"cm"),legend.key.height=unit(0.35,"cm")) +
  geom_tile(data=a, aes(x=a[,2], y=a[,1], fill=as.numeric(a[,7])), size=1) +
  geom_map(data=wmap,map=wmap,aes(map_id=id),fill=NA,colour="black",size=0.3) +
  scale_fill_gradient2(low = "darkblue", mid = "yellow", high = "red",
                       na.value=NA, midpoint=100,
                       breaks=c(1,100,200),
                       limits=c(0,200),
                       labels=c("0","100","200"),
                       guide=guide_colourbar(title="% Change"))

dev.off()







