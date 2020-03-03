library(ggplot2)

a<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/Global_TrophicGroup_HeterotrophBiomass_MEAN.csv", stringsAsFactors=F)

tiff('TrophicGroup_HB.tiff', units="in",width=8, height=5, res=500)

ggplot(data=a,aes(x=as.numeric(a[,2]),y=a[,3]/10^15,fill=a[,1])) +
  geom_bar(position="dodge", stat="identity",width = 0.7) + 
  scale_y_continuous(name="Heterotroph Biomass (Pg)", breaks=c(0,7,14),
                     labels=c("0","7","14"),limits=c(0,14)) +
  scale_x_continuous(name="\nTrophic Group", breaks=c(1,2,3,4,5,6),
                     labels=c("Endothermic \nHerbivore","Endothermic \nCarnivore","Endothermic \nOmnivore",
                              "Ectothermic \nHerbivore","Ectothermic \nCarnivore","Ectothermic \nOmnivore"),
                     limits=c(0.5,6.5)) +
  theme_bw() + theme(legend.position = "none",
                     panel.grid.major.x = element_blank(),
                     panel.grid.minor.x = element_blank(),
                     panel.grid.minor.y = element_blank(),
                     axis.title = element_text(size = 13),
                     axis.text.y = element_text(size=13),
                     axis.text.x = element_text(size=13,angle = 60,hjust=0.5,vjust=0.5)) +
  scale_fill_manual(name="",
                      values=c(Pleistocene ="black", 
                               Modern ="purple", 
                               Future ="orange")) 

 dev.off() 

b<-read.csv("/Users/andrewabraham/Dropbox/Madingley & Megabiota/Manuscript_Scripts/Global_TrophicGroup_HeterotrophMetabolism_MEAN.csv", stringsAsFactors=F)

tiff('TrophicGroup_Metabolism.tiff', units="in",width=8, height=5, res=500)

ggplot(data=b,aes(x=as.numeric(b[,2]),y=b[,3]*1000/10^18,fill=b[,1])) +
 geom_bar(position="dodge", stat="identity",width = 0.7) + 
 scale_y_continuous(name="Metabolism (EJ/day)", breaks=c(0,1.3,2.6),
                    labels=c("0","1.3","2.6"),limits=c(0,2.6)) +
 scale_x_continuous(name="\nTrophic Group", breaks=c(1,2,3,4,5,6),
                    labels=c("Endothermic \nHerbivore","Endothermic \nCarnivore","Endothermic \nOmnivore",
                             "Ectothermic \nHerbivore","Ectothermic \nCarnivore","Ectothermic \nOmnivore"),
                    limits=c(0.5,6.5)) +
 theme_bw() + theme(legend.position = "none",
                    panel.grid.major.x = element_blank(),
                    panel.grid.minor.x = element_blank(),
                    panel.grid.minor.y = element_blank(),
                    axis.title = element_text(size = 13),
                    axis.text.y = element_text(size=13),
                    axis.text.x = element_text(size=13,angle = 60,hjust=0.5,vjust=0.5)) +
 scale_fill_manual(name="",
                   values=c(Pleistocene ="black", 
                            Modern ="purple", 
                            Future ="orange")) 

dev.off() 



c<-read.csv("~/Dropbox/Madingley & Megabiota/Megabiota-master/Figure S5/Global_TrophicGroup_NutrientDiffusivity_MEAN.csv", stringsAsFactors=F)

tiff('~/Desktop/Revised_nutrient/TrophicGroup_NutDiff.tiff', units="in",width=8, height=5, res=500)

ggplot(data=c,aes(x=as.numeric(c[,2]),y=c[,3]/10^11,fill=c[,1])) +
  geom_bar(position="dodge", stat="identity",width = 0.7) + 
  scale_y_continuous(name=expression(Nutrient~Diffusivity~(10^11~km^2/day)), breaks=c(0,6,12),
                     labels=c("0","6","12"),limits=c(0,12)) +
  scale_x_continuous(name="\nTrophic Group", breaks=c(1,2,3,4,5,6),
                     labels=c("Endothermic \nHerbivore","Endothermic \nCarnivore","Endothermic \nOmnivore",
                              "Ectothermic \nHerbivore","Ectothermic \nCarnivore","Ectothermic \nOmnivore"),
                     limits=c(0.5,6.5)) +
  theme_bw() + theme(legend.position = "none",
                     panel.grid.major.x = element_blank(),
                     panel.grid.minor.x = element_blank(),
                     panel.grid.minor.y = element_blank(),
                     axis.title = element_text(size = 13),
                     axis.text.y = element_text(size=13),
                     axis.text.x = element_text(size=13,angle = 60,hjust=0.5,vjust=0.5)) +
  scale_fill_manual(name="",
                    values=c(Pleistocene ="black", 
                             Modern ="purple", 
                             Future ="orange")) 

dev.off() 
