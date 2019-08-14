# Megabiota
Enquist et al. On the importance of megabiota to the functioning of the biosphere

To recreate the Madingley model simulations performed for this paper, please refer to https://github.com/Madingley/C-sharp-version-of-Madingley. This repository contains: 

STATE_R_SCRIPTS

•	State_Heterotrophic_Biomass: R script to calculate mean annual grid cell heterotrophic biomass from the output Madingley state file. 
•	State_Heterotrophic_Metabolism: R script to calculate mean annual grid cell heterotrophic metabolism from the output Madingley state file.
•	State_Heterotrophic_NutrientDiffusivity: R script to calculate mean annual grid cell heterotrophic nutrient diffusivity from the output Madingley state file. 


SIMULATION_OUTPUT

•	GRID_CELL_OUTPUT: For each set of simulations or world, the following grid cell output is provided. All results are calculated as a grid cell mean from the last 12 time steps of model simulations, or one year. Sim_10000, Sim_1000 and Sim_100 refer to the Pleistocene, Modern and Future worlds respectively. 

o	HeterotrophBiomass_Map_gkm2: Mean annual grid cell heterotrophic biomass (g/km2) for individual Pleistocene, Modern and Future simulations. 
o	HeterotrophBiomass_Map_gkm2_MEAN: Mean annual grid cell heterotrophic biomass (g/km2) averaged for Pleistocene, Modern and Future simulations. 
o	HeterotrophMetabolism_EndMap_kJday: Mean annual grid cell endotherm metabolism (kJ/day/km2) for individual Pleistocene, Modern and Future simulations.
o	HeterotrophMetabolism_EndMap_kJday_MEAN: Mean annual grid cell endotherm metabolism (kJ/day/km2) averaged for Pleistocene, Modern and Future simulations.
o	HeterotrophMetabolism_EctMap_kJday: Mean annual grid cell ectotherm metabolism (kJ/day/km2) for individual Pleistocene, Modern and Future simulations.
o	HeterotrophMetabolism_EctMap_kJday_MEAN: Mean annual grid cell ectotherm metabolism (kJ/day/km2) averaged for Pleistocene, Modern and Future simulations.
o	HeterotrophNutrientDiffusivity_km2day: Mean annual grid cell endotherm nutrient diffusivity (km2/day) for individual Pleistocene, Modern and Future simulations.
o	HeterotrophNutrientDiffusivity_km2day_MEAN: Mean annual grid cell endotherm nutrient diffusivity (km2/day) averaged for Pleistocene, Modern and Future simulations.

•	MASS_BIN_OUTPUT: For each set of simulations or world, the following mass bin output is provided. All results are calculated as a global mean from the last 12 time steps of model simulations, or one year. Sim_10000, Sim_1000 and Sim_100 refer to the Pleistocene, Modern and Future worlds respectively.  

o	HeterotrophicBiomass_MassBins: Mean annual global heterotrophic biomass (g) summarised into 25 logged mass bins for individual Pleistocene, Modern and Future simulations. 
o	HeterotrophicBiomass_MassBins_MEAN: Mean annual global heterotrophic biomass (g) summarised into 25 logged mass bins and averaged for Pleistocene, Modern and Future simulations. 
o	HeterotrophicMetabolism_MassBins: Mean annual global heterotrophic metabolism (kJ/day) summarised into 25 logged mass bins for individual Pleistocene, Modern and Future simulations. 
o	HeterotrophicMetabolism_MassBins_MEAN: Mean annual global heterotrophic metabolism (kJ/day) summarised into 25 logged mass bins and averaged for Pleistocene, Modern and Future simulations. 
o	HeterotrophicNutrient_MassBins: Mean annual global endotherm nutrient diffusivity (km2/day) summarised into 25 logged mass bins for individual Pleistocene, Modern and Future simulations. 
o	HeterotrophicNutrient_MassBins_MEAN: Mean annual global endotherm nutrient diffusivity (km2/day) summarised into 25 logged mass bins and averaged Pleistocene, Modern and Future simulations. 

•	TROPHIC_GROUP_OUTPUT: For each set of simulations or world, the following trophic group output is provided. All results are calculated as a global mean from the last 12 time steps of model simulations, or one year. Sim_10000, Sim_1000 and Sim_100 refer to the Pleistocene, Modern and Future worlds respectively.  

o	Global_TrophicGroup_HeterotrophicBiomass: Mean annual global heterotrophic biomass (g) summarised into trophic group for individual Pleistocene, Modern and Future simulations. 
o	Global_TrophicGroup_HeterotrophicBiomass_MEAN: Mean annual global heterotrophic biomass (g) summarised into trophic group and averaged for Pleistocene, Modern and Future simulations. 
o	Global_TrophicGroup_HeterotrophicMetabolism: Mean annual global heterotrophic metabolism (kJ/day) summarised into trophic group for individual Pleistocene, Modern and Future simulations. 
o	Global_TrophicGroup_HeterotrophicMetabolism_MEAN: Mean annual global heterotrophic metabolism (kJ/day) summarised into trophic group and averaged for Pleistocene, Modern and Future simulations. 
o	Global_TrophicGroup_NutrientDiffusivity: Mean annual global endothermic nutrient diffusivity (km2/day) summarised into trophic group for individual Pleistocene, Modern and Future simulations. 
o	Global_TrophicGroup_NutrientDiffusivity_MEAN: Mean annual global endothermic nutrient diffusivity (km2/day) summarised into trophic group and averaged for Pleistocene, Modern and Future simulations. 

•	END_ECT_OUTPUT: For each set of simulations or world, the following global endothermic/ectothermic output is provided. All results are calculated as a global mean from the last 12 time steps of model simulations, or one year. Sim_10000, Sim_1000 and Sim_100 refer to the Pleistocene, Modern and Future worlds respectively.  

o	Global_TrophicGroup_HeterotrophicBiomass: Mean annual global heterotrophic biomass (g) summarised into trophic group for individual Pleistocene, Modern and Future simulations.   

o	HeterotrophBiomass_EndEct: Mean annual global heterotrophic biomass (g) summarised into endothermic and ectothermic components for individual Pleistocene, Modern and Future simulations. 
o	HeterotrophBiomass_EndEct_MEAN: Mean annual global heterotrophic biomass (g) summarised into endothermic and ectothermic components and averaged for Pleistocene, Modern and Future simulations. 
o	HeterotrophMetabolism_EndEct: Mean annual global heterotrophic metabolism (kJ/day) summarised into endothermic and ectothermic components for individual Pleistocene, Modern and Future simulations. 
o	HeterotrophMetabolism_EndEct_MEAN: Mean annual global heterotrophic metabolism (kJ/day) summarised into endothermic and ectothermic components and averaged for Pleistocene, Modern and Future simulations. 
o	HeterotrophNutrient_EndEct: Mean annual global endothermic nutrient diffusivity (km2/day) summarised into endothermic and ectothermic components for individual Pleistocene, Modern and Future simulations. 
o	HeterotrophNutrient_EndEct _MEAN: Mean annual global endothermic nutrient diffusivity (km2/day) summarised into endothermic and ectothermic components and averaged for Pleistocene, Modern and Future simulations. 

FIGURE_R_SCRIPTS

•	MANUSCRIPT_FIGURES: R scripts to generate figures used in the main manuscript. This includes:

o	HeterotrophBiomass_Maps: Creates figure 5. 
o	HeterotrophBiomass_MassBins_Fig: Creates figure 5.
o	HeterotrophMetabolism_MassBins_Fig: Creates figure 5.
o	HeterotrophNutrient_MassBins_Fig: Creates figure 5.

•	SUPPLEMENTARY_FIGURES: R scripts used to generate figures used in the supplementary document II. This includes:

o	Metabolism_graph: Creates figure S2. 
o	Regions_massbins: Creates figure S3. 
o	HeterotrophMetabolism_maps: Creates figure S4. 
o	HeterotrophNutrient_maps: Creates figure S4. 
o	AutotrophicBiomass_map: Creates figure S4. 
o	TrophicGroup_graph: Creates figure S5. 
o	Nutrient_graph: Creates figure S6. 
