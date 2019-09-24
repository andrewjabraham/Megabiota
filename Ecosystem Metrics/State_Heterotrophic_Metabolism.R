library(reshape2)
library(data.table)
library(ncdf4)
library(ggplot2)

#set working directory
setwd("F:/Megabiota Paper/Final simulations/Sim_10000/MadingleyOutputs2018-2-9_12.34.48")

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

#Specify the filenames for the functional group definitions
filename.cohort.functional.group.defs ="CohortFunctionalGroupDefinitions.csv"

#Read in the functional group definitions for this simulation
fg.defs.cohort = read.csv(filename.cohort.functional.group.defs,stringsAsFactors=F)

#cohort.traits.to.use = c(colnames(fg.defs.cohort)[grep("DEFINITION",colnames(fg.defs.cohort),fixed = T)],"PROPERTY_Maximum.mass","PROPERTY_Minimum.mass")
end.fgs<-which(fg.defs.cohort$DEFINITION_Endo.Ectotherm == "Endotherm")-1
ect.fgs<-which(fg.defs.cohort$DEFINITION_Endo.Ectotherm == "Ectotherm")-1

#Subset by endotherm/ectotherm
state_end<-state[c("TimeStep","Latitude","Longitude","FunctionalGroup", "Interval","IndividualBodyMass","TotalBiomass","CohortAbundance","ProportionTimeActive")]
state_end<-subset(state_end, FunctionalGroup %in% c(end.fgs))
state_ect<-state[c("TimeStep","Latitude","Longitude","FunctionalGroup", "Interval","IndividualBodyMass","TotalBiomass","CohortAbundance","ProportionTimeActive")]
state_ect<-subset(state_ect, FunctionalGroup %in% c(ect.fgs))

#Calculate temperature in each grid cell
outputs<-"GridOutputs_NI_0.nc"  
outputs<-nc_open(outputs)

temp1188<-ncvar_get(outputs,"Temperature")[1188,,]
temp1189<-ncvar_get(outputs,"Temperature")[1189,,]
temp1190<-ncvar_get(outputs,"Temperature")[1190,,]
temp1191<-ncvar_get(outputs,"Temperature")[1191,,]
temp1192<-ncvar_get(outputs,"Temperature")[1192,,]
temp1193<-ncvar_get(outputs,"Temperature")[1193,,]
temp1194<-ncvar_get(outputs,"Temperature")[1194,,]
temp1195<-ncvar_get(outputs,"Temperature")[1195,,]
temp1196<-ncvar_get(outputs,"Temperature")[1196,,]
temp1197<-ncvar_get(outputs,"Temperature")[1197,,]
temp1198<-ncvar_get(outputs,"Temperature")[1198,,]
temp1199<-ncvar_get(outputs,"Temperature")[1199,,] 

temp1188<-melt(temp1188)
temp1189<-melt(temp1189)
temp1190<-melt(temp1190)
temp1191<-melt(temp1191)
temp1192<-melt(temp1192)
temp1193<-melt(temp1193)
temp1194<-melt(temp1194)
temp1195<-melt(temp1195)
temp1196<-melt(temp1196)
temp1197<-melt(temp1197)
temp1198<-melt(temp1198)
temp1199<-melt(temp1199)

#Convert lats to a dataframe
lats<-seq(-65,63,2)
lons<-seq(-180,178,2)
lats.df<-data.frame(lats)
lons.df<-data.frame(lons)

#Repeat sequence of lats/lons over the grid to convert from wide to long format
lats.df<-rep(lats.df[,1], each=length(lons))
lons.df<-rep(lons.df[,1], times=length(lats))

#Melt lats/lons into long format
lats.melt<-melt(lats.df)
lons.melt<-melt(lons.df)

#Create long temperature dataframe
temp_1188<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1188[,3]))
temp_1189<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1189[,3]))
temp_1190<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1190[,3]))
temp_1191<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1191[,3]))
temp_1192<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1192[,3]))
temp_1193<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1193[,3]))
temp_1194<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1194[,3]))
temp_1195<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1195[,3]))
temp_1196<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1196[,3]))
temp_1197<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1197[,3]))
temp_1198<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1198[,3]))
temp_1199<-data.frame(lats.melt[1],lons.melt[1],as.numeric(temp1199[,3]))

colnames(temp_1188)<-c("Latitude","Longitude","Temperature")
colnames(temp_1189)<-c("Latitude","Longitude","Temperature")
colnames(temp_1190)<-c("Latitude","Longitude","Temperature")
colnames(temp_1191)<-c("Latitude","Longitude","Temperature")
colnames(temp_1192)<-c("Latitude","Longitude","Temperature")
colnames(temp_1193)<-c("Latitude","Longitude","Temperature")
colnames(temp_1194)<-c("Latitude","Longitude","Temperature")
colnames(temp_1195)<-c("Latitude","Longitude","Temperature")
colnames(temp_1196)<-c("Latitude","Longitude","Temperature")
colnames(temp_1197)<-c("Latitude","Longitude","Temperature")
colnames(temp_1198)<-c("Latitude","Longitude","Temperature")
colnames(temp_1199)<-c("Latitude","Longitude","Temperature")

temp_df<-rbind(temp_1188,temp_1189,temp_1190,temp_1191,temp_1192,temp_1193,
               temp_1194,temp_1195,temp_1196,temp_1197,temp_1198,temp_1199)

months.df<-rep(1188:1199, each=11700)
months.melt<-melt(months.df)
colnames(months.melt)<-c("TimeStep")

temp_df<-cbind(months.melt,temp_df)

#Add temperature value for each cohort
x<-merge(state_end,temp_df,by=c("TimeStep","Latitude","Longitude"),all.x=TRUE)           
y<-merge(state_ect,temp_df,by=c("TimeStep","Latitude","Longitude"),all.x=TRUE)          

#Add constants
BC<-0.00008617              #Boltzmann Constant
AE<-0.69                    #Activation Energy
End.Exp<-0.7                #Endotherm Metabolism Mass Exponent
End.Norm<-908091000000      #Endotherm Normalisation Constant
Ect.Exp<-0.88               #Ectotherm Metabolism Mass Exponent
Ect.Norm<-148984000000      #Ectotherm Normalisation Constant
Ect.Basal.Exp<-0.69         #Ectotherm Basal Metabolism Mass Exponent
Ect.Basal.Norm<-41918272883 #Ectotherm Basal Normalisation Constant

#Calculate metabolic rate for each endothermic cohort
x$IndividualMetabolicRate<-1*End.Norm*exp(-(AE/(BC*310)))*x[,6]^End.Exp
x$CohortMetabolicRate<-x[,11]*x[,8]

#Calculate metabolic rate for each ectothermic cohort
y$IndividualMetabolicRate<-(y[,9]*Ect.Norm*exp(-(AE/(BC*(y[,10]+273.15))))*y[,6]^Ect.Exp) +
  ((1-y[,9])*Ect.Basal.Norm*exp(-(AE/(BC*(y[,10]+273.15))))*y[,6]^Ect.Basal.Exp) 
y$CohortMetabolicRate<-y[,11]*y[,8]

x_1199<-x[which(x$TimeStep == 1199),]
y_1199<-y[which(y$TimeStep == 1199),]


write.csv(x,"x_1199.csv")
write.csv(y,"y_1199.csv")

end_met<-dcast(x,
               Latitude + Longitude ~ Interval,
               fun.aggregate = sum,
               value.var = "CohortMetabolicRate")

ect_met<-dcast(y,
               Latitude + Longitude ~ Interval,
               fun.aggregate = sum,
               value.var = "CohortMetabolicRate")

#Mean global biomass in mass bin
end_values<-data.frame(colSums(end_met)/12)
ect_values<-data.frame(colSums(ect_met)/12)

write.csv(end_values,"HetMetEnd_massbins_logged.csv")
write.csv(ect_values,"HetMetEct_massbins_logged.csv")


#Recast for ensemble maps of total metabolism in each grid cell
end_map<-dcast(x,
               Latitude + Longitude ~ FunctionalGroup,
               fun.aggregate = sum,
               value.var = "CohortMetabolicRate")

ect_map<-dcast(y,
               Latitude + Longitude ~ FunctionalGroup,
               fun.aggregate = sum,
               value.var = "CohortMetabolicRate")


#Divide by 12 months
Coord<-data.frame(lats.melt,lons.melt)
colnames(Coord)<-c("Latitude","Longitude")

end_map<-merge(end_map, Coord, by=c("Latitude","Longitude"),all=TRUE)

end_map<-data.frame(end_map[,1],
                    end_map[,2],
                    end_map[,3]/12,
                    end_map[,4]/12,
                    end_map[,5]/12)

ect_map<-merge(ect_map, Coord, by=c("Latitude","Longitude"),all=TRUE)

ect_map<-data.frame(ect_map[,1],
                    ect_map[,2],
                    ect_map[,3]/12,
                    ect_map[,4]/12,
                    ect_map[,5]/12,
                    ect_map[,6]/12,
                    ect_map[,7]/12,
                    ect_map[,8]/12)

colnames(end_map)<-c("Lat","Lon","10","11","12")
colnames(ect_map)<-c("Lat","Lon","13","14","15","16","17","18")

write.csv(end_map,"HetMetEnd_grid.csv",row.names=FALSE)
write.csv(ect_map,"HetMetEct_grid.csv",row.names=FALSE)


#Calculate metabolism in kJ/km2

#Calculate the area of this grid cell
data<-"GridOutputs_SSP2_0.nc"  
data<-nc_open(data)
m<-1
CellArea<-ncvar_get(data,"Area")[m,,]
CellArea<-CellArea[1,]
Latitude<-seq(-65,63,2)
CellArea<-data.frame(Latitude,CellArea)

#Add cell area to state files
x<-merge(x,CellArea, by="Latitude", all.x=TRUE)
y<-merge(y,CellArea, by="Latitude", all.x=TRUE)

x$CohortMetabolicRateKm2<-x$CohortMetabolicRate/x$CellArea
y$CohortMetabolicRateKm2<-y$CohortMetabolicRate/y$CellArea

#Recast for ensemble maps of total metabolism in each grid cell
end_map<-dcast(x,
               Latitude + Longitude ~ FunctionalGroup,
               fun.aggregate = sum,
               value.var = "CohortMetabolicRateKm2")

ect_map<-dcast(y,
               Latitude + Longitude ~ FunctionalGroup,
               fun.aggregate = sum,
               value.var = "CohortMetabolicRateKm2")


#Divide by 12 months
Coord<-data.frame(lats.melt,lons.melt)
colnames(Coord)<-c("Latitude","Longitude")

end_map<-merge(end_map, Coord, by=c("Latitude","Longitude"),all=TRUE)

end_map<-data.frame(end_map[,1],
                    end_map[,2],
                    end_map[,3]/12,
                    end_map[,4]/12,
                    end_map[,5]/12)

ect_map<-merge(ect_map, Coord, by=c("Latitude","Longitude"),all=TRUE)

ect_map<-data.frame(ect_map[,1],
                    ect_map[,2],
                    ect_map[,3]/12,
                    ect_map[,4]/12,
                    ect_map[,5]/12,
                    ect_map[,6]/12,
                    ect_map[,7]/12,
                    ect_map[,8]/12)

colnames(end_map)<-c("Lat","Lon","10","11","12")
colnames(ect_map)<-c("Lat","Lon","13","14","15","16","17","18")

write.csv(end_map,"HetMetEnd_grid_km2.csv",row.names=FALSE)
write.csv(ect_map,"HetMetEct_grid_km2.csv",row.names=FALSE)

