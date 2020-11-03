#download and sort CCH data
rm(list=ls())
getwd()
	# my.packages <- c('dplyr')
	my.packages <- c('dplyr', 'readxl', 'rgdal')
#install.packages (my.packages) #Turn on to install current versions
	lapply(my.packages, require, character.only=TRUE)

##to import and wrangle BLM data
######################################################################################################
## This section of code bring in the element occurrence data and then saves it to an *.RData file ##
######################################################################################################
blm1 <- read_excel('data_in/herbarium_data/HerbariumRecords/HerbariumRecords_wHeaders/Burke_AllSpp_wHeaders.xlsx')
blm2 <- read_excel('data_in/herbarium_data/HerbariumRecords/HerbariumRecords_wHeaders/IntermountainFlora_AllSpp_wHeaders.xlsx')
blm3 <- read_excel('data_in/herbarium_data/HerbariumRecords/HerbariumRecords_wHeaders/Smithsonian_AllSpp_wHeaders.xlsx')

head(blm1)
names(blm1)
names(blm2)
names(blm3)
blm3$`Catalog Number`

##subset dataframes and rename fields
blm1a <- blm1 %>% select(id, institutionCode, accession=Accession, scientificName, family, SppCode, Collector, CollectorNumber, country, stateORprovince, county, locality, elevation, latitude, longitude, datum, CoordinateUncertaintyMeters, GeoreferencedBy)
	head(blm1a)
blm2a <- blm2 %>% select(id, institutionCode, accession=catalogNumber, scientificName, family, SppCode, Collector, CollectorNumber, country, stateORprovince, county, locality, elevation, latitude, longitude, datum, CoordinateUncertaintyMeters, GeoreferencedBy)
	head(blm1a)
blm3a <- blm3 %>% select(id, institutionCode, accession='Catalog Number', scientificName='Taxonomic Name (Filed As : Identified By : Identification Date)' , family, SppCode, Collector, CollectorNumber, country, stateORprovince, county, locality, elevation='elevation (m)', latitude, longitude, datum, CoordinateUncertaintyMeters, GeoreferencedBy)
	head(blm1a)
	names(blm1a)
#	
blm <- full_join(blm1a, blm2a, by)

blm1a$id
blm2a$id
blm3a$accession
