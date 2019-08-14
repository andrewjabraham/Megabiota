library(reshape2)
library(data.table)
library(aspace)
library(ncdf4)

#set working directory
setwd("F:/Paper X - Megabiota Paper/Final simulations/Sim_10000/MadingleyOutputs2018-2-9_12.34.48")

#Read in the state file
state.file<-paste('State_NI_00','.txt',sep='')
state<-read.table(state.file,header=T,sep="\t",stringsAsFactors=F,fill=TRUE)

#Remove NA values
stock.inds<-grep("S",state$FunctionalGroup)
if(length(stock.inds) > 0) state<-state[-stock.inds,]

#Calculate log individual mass
state$LogIndividualBodyMass<-log(state$IndividualBodyMass)

#Define size bins
size.bins<-seq(-8,17,1)

#Calculate the mass bin intervals to which each cohort belongs
state$Interval<-findInterval(state$LogIndividualBodyMass,size.bins)

#Convert abundance from strings to numeric
state$CohortAbundance<-as.numeric(state$CohortAbundance)

#Calculate the total biomass contained in each cohort
state$TotalBiomass<-(state$IndividualBodyMass * state$CohortAbundance) +
                    (state$ReproductiveMass * state$CohortAbundance)    

#Cast by grid cell and interval
state.int<-dcast(state,
                Latitude + Longitude ~ Interval,
                fun.aggregate = sum,
                value.var = "TotalBiomass")

#Calculate mean global biomass in mass bin
values<-data.frame(colSums(state.int)/12)

write.csv(values,"Sim_10000_logged_massbins.csv")


#CALCULATE TOTAL ENDO/ECTO BIOMASS

#Specify the filenames for the functional group definitions
filename.cohort.functional.group.defs ="CohortFunctionalGroupDefinitions.csv"

#Read in the functional group definitions for this simulation
fg.defs.cohort = read.csv(filename.cohort.functional.group.defs,stringsAsFactors=F)

#cohort.traits.to.use = c(colnames(fg.defs.cohort)[grep("DEFINITION",colnames(fg.defs.cohort),fixed = T)],"PROPERTY_Maximum.mass","PROPERTY_Minimum.mass")
end.fgs<-which(fg.defs.cohort$DEFINITION_Endo.Ectotherm == "Endotherm")-1
ect.fgs<-which(fg.defs.cohort$DEFINITION_Endo.Ectotherm == "Ectotherm")-1

#Subset by endotherm/ectotherm
state_end<-state[c("TimeStep","Latitude","Longitude","FunctionalGroup", "Interval","IndividualBodyMass","TotalBiomass")]
state_end<-subset(state_end, FunctionalGroup %in% c(end.fgs))
state_ect<-state[c("TimeStep","Latitude","Longitude","FunctionalGroup", "Interval","IndividualBodyMass","TotalBiomass")]
state_ect<-subset(state_ect, FunctionalGroup %in% c(ect.fgs))

#Calculate mean annual global biomass for endotherms and ectotherms
end.biomass<-sum(state_end[,7])/12
ect.biomass<-sum(state_ect[,7])/12

#CALCULATE TOTAL HETEROTROPH BIOMASS IN EACH GRID CELL

#Subset cohorts by biomass in each functional group
state.fg<-dcast(state,
                Latitude + Longitude ~ FunctionalGroup,
                fun.aggregate = sum,
                value.var = "TotalBiomass")

Latitude<-seq(-65,63,2)
Longitude<-seq(-180,178,2)

Latitude<-data.frame(Latitude)
Longitude<-data.frame(Longitude)

Latitude<-rep(Latitude[,1],each=180)
Longitude<-rep(Longitude[,1],times=65)

Coord<-data.frame(Latitude,Longitude)
colnames(Coord)<-c("Latitude","Longitude")

grid<-merge(state.fg, Coord, by=c("Latitude","Longitude"),all=TRUE)
grid<-data.frame(grid[,1],
                 grid[,2],
                 grid[,3]/12,
                 grid[,4]/12,
                 grid[,5]/12,
                 grid[,6]/12,
                 grid[,7]/12,
                 grid[,8]/12,
                 grid[,9]/12,
                 grid[,10]/12,
                 grid[,11]/12)

colnames(grid)<-c("Lat","Lon","10","11","12","13","14","15","16","17","18")

write.csv(grid,"HetBio_grid.csv")

#CALCULATE TOTAL HETEROTROPH BIOMASS IN EACH GRID CELL IN KM2

#Calculate the area of this grid cell
data<-"GridOutputs_SSP2_0.nc"  
data<-nc_open(data)
m<-1
CellArea<-ncvar_get(data,"Area")[m,,]
CellArea<-CellArea[1,]
Latitude<-seq(-65,63,2)
CellArea<-data.frame(Latitude,CellArea)

#Add cell area to state files
state<-merge(state,CellArea, by="Latitude", all.x=TRUE)

state$TotalBiomassKm2<-state$TotalBiomass/state$CellArea

#Subset cohorts by biomass in each functional group
state.fg<-dcast(state,
                 Latitude + Longitude ~ FunctionalGroup,
                 fun.aggregate = sum,
                 value.var = "TotalBiomassKm2")

#Merge associated long and lat to each grid cell
Latitude<-seq(-65,63,2)
Longitude<-seq(-180,178,2)

Latitude<-data.frame(Latitude)
Longitude<-data.frame(Longitude)

Latitude<-rep(Latitude[,1],each=180)
Longitude<-rep(Longitude[,1],times=65)

Coord<-data.frame(Latitude,Longitude)
colnames(Coord)<-c("Latitude","Longitude")

grid<-merge(state.fg, Coord, by=c("Latitude","Longitude"),all=TRUE)
grid<-data.frame(grid[,1],
                 grid[,2],
                 grid[,3]/12,
                 grid[,4]/12,
                 grid[,5]/12,
                 grid[,6]/12,
                 grid[,7]/12,
                 grid[,8]/12,
                 grid[,9]/12,
                 grid[,10]/12,
                 grid[,11]/12)

#Rename column headings by functional group
colnames(grid)<-c("Lat","Lon","10","11","12","13","14","15","16","17","18")

#Write Heterotrophic biomass by functional group in each grid cell/km2
write.csv(grid,"HetBio_grid_km2.csv")
