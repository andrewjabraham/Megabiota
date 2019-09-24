library(reshape2)
library(data.table)
library(aspace)
library(ncdf4)

#set working directory
setwd("F:/Megabiota Paper/Final Simulations/Sim_100/MadingleyOutputs2018-2-16_22.17.43")

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

#Calculate the area of this grid cell
data<-"GridOutputs_SSP2_0.nc"  
data<-nc_open(data)
m<-1
CellArea<-ncvar_get(data,"Area")[m,,]
CellArea<-CellArea[1,]
Latitude<-seq(-65,63,2)
CellArea<-data.frame(Latitude,CellArea)

#Add cell area to state files
state_cell<-merge(state,CellArea, by="Latitude", all.x=TRUE)

#Calculate Population Density
state_cell$PopulationDensity<-state_cell$CohortAbundance/state_cell$CellArea

#Select Endotherms
#Specify the filenames for the functional group definitions
filename.cohort.functional.group.defs ="CohortFunctionalGroupDefinitions.csv"

#Read in the functional group definitions for this simulation
fg.defs.cohort = read.csv(filename.cohort.functional.group.defs,stringsAsFactors=F)

#cohort.traits.to.use = c(colnames(fg.defs.cohort)[grep("DEFINITION",colnames(fg.defs.cohort),fixed = T)],"PROPERTY_Maximum.mass","PROPERTY_Minimum.mass")
end.fgs<-which(fg.defs.cohort$DEFINITION_Endo.Ectotherm == "Endotherm")-1
ect.fgs<-which(fg.defs.cohort$DEFINITION_Endo.Ectotherm == "Ectotherm")-1

#Subset by endotherm/ectotherm
state_end<-state_cell[c("TimeStep","Latitude","Longitude","FunctionalGroup", "Interval","IndividualBodyMass","PopulationDensity")]
state_end<-subset(state_end, FunctionalGroup %in% c(end.fgs))

#Calculate Indivdiual Diffusivity
state_end$IndividualDiffusivity<-0.000605*(state_end$IndividualBodyMass/1000)^1.735
 
#Calculate Cohort Diffusivity 
state_end$CohortDiffusivity<-state_end$IndividualDiffusivity*state_end$PopulationDensity  

#Recast within intervals
end_nut<-dcast(state_end,
               Latitude + Longitude ~ Interval,
               fun.aggregate = sum,
               value.var = "CohortDiffusivity")

#Mean global nutrient diffusivity in mass bins
end_nut_values<-data.frame(colSums(end_nut)/12)

write.csv(end_nut_values,"HetNutEnd_massbins_logged.csv")


#Calculate in total diffusivity in each grid cell

nut_map<-dcast(state_end,
               Latitude + Longitude ~ FunctionalGroup,
               fun.aggregate = sum,
               value.var = "CohortDiffusivity")

Latitude<-seq(-65,63,2)
Longitude<-seq(-180,178,2)

Latitude<-data.frame(Latitude)
Longitude<-data.frame(Longitude)

Latitude<-rep(Latitude[,1],each=180)
Longitude<-rep(Longitude[,1],times=65)

Coord<-data.frame(Latitude,Longitude)
colnames(Coord)<-c("Latitude","Longitude")

grid<-merge(nut_map, Coord, by=c("Latitude","Longitude"),all=TRUE)

grid<-data.frame(grid[,1],
                 grid[,2],
                 grid[,3]/12,
                 grid[,4]/12,
                 grid[,5]/12)

colnames(grid)<-c("Lat","Lon","10","11","12")

write.csv(grid,"HetNutEnd_grid_km2.csv")





