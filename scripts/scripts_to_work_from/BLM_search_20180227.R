#download and sort CCH data
rm(list=ls())
getwd()
	# my.packages <- c('dplyr')
	my.packages <- c('readxl', 'tidyr', 'writexl', 'dplyr') #'rgdal', 'raster'
	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
#install.packages (my.packages) #Turn on to install current versions
	lapply(my.packages, require, character.only=TRUE); rm(my.packages)
#



# #
# # ######################################################################################################
# # ## This section of code bring in the element occurrence data and then saves it to an *.RData file ##
# # ######################################################################################################
# #
# # 	## This section of code to bring in the Known EOs from researchers
# # 	######################################################################################################
# # 	# d_loc <- 'data_in/BLM_data'
# #
# # 	## Let's add plot data for the UTM zones
# # 		plotsSOS <- read_excel('data_in/BLM_data/KnownOccurrences/Jess/SoS/SoS.xlsx', sheet='PlotRichSoS')
# # 			names(plotsSOS)
# # 			head(plotsSOS)
# # 		plots <- read_excel('data_in/BLM_data/KnownOccurrences/Jess/SoS/SoS.xlsx', sheet='Plots')
# # 			names(plots)
# # 			head(plots)
# # 			# lapply(plots, class)
# # 		plants <- read_excel('data_in/BLM_data/KnownOccurrences/Jess/SoS/SoS.xlsx', sheet='PLANTS_GRSGstates', col_types = 'text')
# # 			# names(plants)
# # 			# head(plants)
# # 			# lapply(plants, class)
# # 			# plants$Subvariety <- as.character(plants$Subvariety)
# # 			# class(plants$Subvariety)
# # 			# unique(plants$Subvariety)
# # 		codes <- read_excel('data_in/BLM_data/KnownOccurrences/Jess/SoS/SoS.xlsx', sheet='CodeList')
# # 			# names(codes)
# # 			# head(codes)
# # 			# unique(codes$Code)
# #
# #
# # #
# # 	## add the points through the plants data
# # 	sos <- left_join(plotsSOS, plots, by=c('PlotKey', 'PlotID'))
# # 		head(sos)
# # 		# names(sos)
# #
# # 		##clean up the zone
# # 				lessos <- sos %>% rename(CoordinateSystem=GPSCoordSys, SppCode=Code) %>%
# # 					mutate(Datum=replace(Datum, Datum=='WGS 84', 'WGS84')) %>%
# # 						mutate(Datum=replace(Datum, Datum=='NAD 83', 'NAD83')) %>%
# # 									 mutate(Zone=replace(Zone, Zone=='11s', '11S'), Zone=replace(Zone, Zone=='12s', '12S')) %>%
# # 											mutate(DataSource=paste0('GBI', sprintf("%05d", 1:nrow(sos)))) %>%
# # 											arrange(Datum, CoordinateSystem, SppCode) %>% select(DataSource, ScientificName, SppCode, CoordinateSystem, Datum, Zone, x_coord, y_coord)
# #
# # 				head(lessos)
# #
# # # ## make list of focal species
# # # 		focal.spp <- c('Achnatherum hymenoides', 'Achnatherum thurberianum', 'Elymus elymoides', 'Elymus elymoides ssp. brevifolius', 'Elymus elymoides ssp. californicus', 'Heliomeris multiflora var. nevadensis',
# # # 									 'Chaenactis douglasii', 'Chaenactis douglasii var. douglasii')
# #
# # 					rm(plots, plotsSOS, codes, plants, sos)
# # # Identifier	DataSource	Species	SppCode	CoordinateSystem	Datum	x_coord	y_coord
# # 	##combine with the other data
# # 	# gust <- read_excel('data_in/BLM_data/KnownOccurrences/Gust - Populations/Gust_Locations.xlsx')
# # 	gust <- read_excel('/Users/sstill/Box/Seed Menus Project/KnownOccurrences/Gust - Populations/Gust_Locations.xlsx')
# #
# # 		gust <- gust %>% rename(DataSource=SourceID, SppCode=Species, x_coord=POINT_X, y_coord=POINT_Y) %>% mutate(Datum='WGS84')
# # 								# mutate(DataSource=paste0('Gust', sprintf("%05d", 1:nrow(gust))), Datum='WGS84')
# # 		# 		names(gust)
# # 		# head(gust)
# # 	# irwin <- read_excel('data_in/BLM_data/KnownOccurrences/Irwin/Copy of SCNF point data.xlsx')
# # 	irwin <- read_excel('data_in/BLM_data/KnownOccurrences/Irwin_FocalSpecies.xlsx', sheet='DataSource')
# # 	# irwin <- read_excel('/Users/sstill/Box/Seed Menus Project/KnownOccurrences/Irwin_FocalSpecies.xlsx', sheet='DataSource')
# # 		# names(irwin)
# # 		# 		head(irwin)
# # 		irwin <- irwin %>% rename(SppCode=SPP, ScientificName=Species, x_coord=Longitude, y_coord=Latitude) %>% select(DataSource, SppCode, ScientificName, Datum, x_coord, y_coord) %>%
# # 								mutate(Datum=replace(Datum, Datum=='WGS 84', 'WGS84')) %>% mutate(Datum=replace(Datum, Datum=='NAD 83', 'NAD83'))# %>%
# # 								# mutate(DataSource=paste0('Irwin', sprintf("%05d", 1:nrow(irwin)))) %>%
# # 								# filter(ScientificName %in% focal.spp)
# # 				# unique(irwin$Datum)
# # 	jens <- read_excel('data_in/BLM_data/KnownOccurrences/Jensen_Points.xlsx', sheet='DataSource')
# # 	# jens <- read_excel('/Users/sstill/Box/Seed Menus Project/KnownOccurrences/Jensen_Points.xlsx', sheet='DataSource')
# # 	# jens <- read_excel('data_in/BLM_data/KnownOccurrences/Jensen_Points.xlsx', sheet='DataSource')
# # 		jens <- jens %>% rename(SppCode=`Species ID`, x_coord=`Longitude (Inc "-")`, y_coord=Latitude) %>%
# # 							select(DataSource, SppCode, Datum, x_coord, y_coord)
# # 				# names(jens)
# # 				head(jens)
# # 				# unique(jens$Datum)
# # 	# stringham <- read_excel('/Users/sstill/Box/Seed Menus Project/KnownOccurrences/Stringham/Edited_Stringham_Data.xlsx')
# # 	# # stringham <- read_excel('data_in/BLM_data/KnownOccurrences/Stringham/Edited_Stringham_Data.xlsx')
# # 	# raw.string <- read_excel('data_in/BLM_data/KnownOccurrences/Stringham/Stringham_MLRA28.xlsx')
# # 	raw.string <- read_excel('/Users/sstill/Box/Seed Menus Project/KnownOccurrences/Stringham/Stringham_MLRA28.xlsx')
# # 				# names(raw.string)
# # 	raw.string <- mutate(raw.string, DataSource=paste0('Stringham', sprintf("%04d", 1:nrow(raw.string))))
# # 	##convert from wide to long
# # 			wide.df <- select(raw.string, DataSource, ACHY:SPGR)
# # 				long.df <- gather(wide.df, SppCode, present, -DataSource) %>% filter(present == 1) %>% select(DataSource, SppCode)
# # 			raw.s <- raw.string %>% rename(x_coord=LONG_DD, y_coord=LAT_DD) %>% mutate(Datum='NAD83') %>% select(DataSource, Datum, x_coord, y_coord)
# # 										# names(raw.s)
# # 							# names(long.df)
# # 			##merge the two data drames from Stringham
# # 				stringham <- left_join(long.df, raw.s, by=c('DataSource'))
# #
# # 					write_xlsx(stringham, 'string_SppCode.xlsx')
# # 							rm(raw.string, raw.s, wide.df, long.df)
# # 		# stringham <- stringham %>% rename(SppCode=Species, DataSource=SourceID, x_coord=LONG_DD, y_coord=LAT_DD) %>% select(SppCode, DataSource, x_coord, y_coord) %>%
# # 		# 						mutate(Datum='NAD83') #%>%
# # 								# mutate(DataSource=paste0('Stringham', sprintf("%05d", 1:nrow(stringham))))
# #
# # # ########################################################################################################################################################
# # # ## merge the different datasets
# # # 		known <- full_join(lessos, gust, by=c('DataSource', 'SppCode', 'Datum', 'x_coord', 'y_coord'))
# # # 		known <- full_join(known, jens, by=c('DataSource', 'SppCode', 'Datum', 'x_coord', 'y_coord'))
# # # 		known <- full_join(known, stringham, by=c('DataSource', 'SppCode', 'Datum', 'x_coord', 'y_coord'))
# # # 		known <- full_join(known, irwin, by=c('DataSource', 'SppCode', 'ScientificName', 'Datum', 'x_coord', 'y_coord'))
# # # 				rm(gust, irwin, jens, lessos, sos, stringham)		
# # # 				
# # # known <- known %>% 
# # # 				mutate(
# # # 			    Zone = case_when(
# # # 			      CoordinateSystem == 'longlat' & !is.na(Zone) ~ NA_character_,
# # # 			      TRUE ~ as.character(Zone)
# # # 			    )
# # # 				)
# # # 
# # # 			##clean up values for zero in the x_coord or y_coord fields
# # # 			known <- filter(known, x_coord != 0 & y_coord != 0)
# # # 
# # # 			write_xlsx(known, 'KnownOccs.xlsx')
# # # 			save(known, file='BLM_data.RData')
# # # 			
# # ########################################################################################################################################################
# # ######################################################################################################
# # ## This section of code bring in the element occurrence data and then saves it to an *.RData file ##
# # ######################################################################################################
# # # cchA <- read.delim('data_in/CCH_Baldwin_Data/CA_EPSG_3310_A.csv', header=TRUE, sep = ',', as.is=TRUE)
# # # cchB <- read.delim('data_in/CCH_Baldwin_Data/CA_EPSG_3310_B.csv', header=TRUE, sep = ',', as.is=TRUE)
# # # 
# # # cch <- rbind(cchA, cchB); rm(cchA, cchB)
# # #  
# # # # unique(cch$scientificName)[1:10]
# # # cchfilter <- filter(cch, scientificName == 'Echinodorus berteroi')
# # 
# # # ##remove first column as it is unnecessary
# # # cch <- select(cch, -X)
# # # 		##just checking on the data
# # # 				names(cch)
# # # 				head(cch)
# # 				
# # #save the data to RData
# # # save(cch, file='data_in/CCH.RData')
# # 	
# # # 	cch2 <- cch %>% sample_n(10000)
# # # 
# # # save(cch2, file='data_in/CCH_random.RData')
# # # ########################################################################################################################################################
## Bring in herbarium data
				known <- read_excel('/Users/sstill/Box/Seed Menus Project/KnownOccurrences/ALL_KNOWN_RECORDS.xlsx', col_types='text', trim_ws=TRUE)
			## set Zone as NA if the record is in longlat
					known <- known %>% rename(x_coord=Easting, y_coord=Northing) %>%
								mutate(
							    Zone = case_when(
							      CoordinateSystem == 'longlat' & !is.na(Zone) ~ NA_character_,
							      TRUE ~ as.character(Zone)
							    )
								)
			known <- filter(known, x_coord != 0 & y_coord != 0)
							# unique(known$Zone)
					known <- known %>% rename(ScientificName = Species, PLANTS_symbol=Symbol) %>% filter(!is.na(ScientificName)) %>%
															mutate(x_coord=as.numeric(x_coord), y_coord=as.numeric(y_coord), Zone=Zone)
						unique(known$ScientificName)
					# unknown <- known %>% filter(is.na(ScientificName))

uids <- select(known, SppCode, PLANTS_symbol, ScientificName) %>% unique() %>% arrange(SppCode, PLANTS_symbol, ScientificName)
	# uids[1:50,]
			write_xlsx(uids, 'these_names.xlsx')

					# look <- filter(known, SppCode=='ELEL', Symbol=='ELELB', ScientificName=='Elymus elymoides var. brevifolius')
			## ASFI	ACTH7
			## LODI	LODI	Lomatium dissectum var. multifidum
			## HEMUM	HEMUM	Heliomeris multiflora var. multiflora
			## HEMUN	HEMUN	Heliomeris multiflora var. nevadensis
			## ELEL	ELELB	Elymus elymoides var. brevifolius
			## ELEL	ELELB2	Elymus elymoides ssp. brevifolius
			## ELEL	ELELC2	Elymus elymoides ssp. californicus
			## ELEL	ELELE	Elymus elymoides ssp. elymoides
			## ELEL	ELELE	Elymus elymoides var. elymoides
			## ELEL	ELELE	Elymus elymoides var. hordeoides
			## CLLU	CLLUL	Cleome lutea var. lutea
			## CLLUL	CLLUL	Cleome lutea var. lutea
			# SPGR	SPGR	 (is this Sphaeralcea grossulariifolia or is it Spartina gracilis? Sphaeralcea grossulariifolia is SPGR2)
			## MACA	MACA2	Machaeranthera canescens
			## MACA	MACAA2	Machaeranthera canescens

		# mynames <- read_excel('my_names.xlsx')

			write_xlsx(known, 'KnownOccs.xlsx')
			save(known, file='BLM_data.RData')

########################################################################################################################################################
		## convert known to correct coordinate system

		## bring in CCH data and add to other herbarium data
load('data_in/CCH.RData')

					mynames <- read_excel('final_names.xlsx')
			uids <- filter(mynames, !PLANTS_symbol %in% c('XXXXXX'), !SppCode %in% c('AMME', 'ERSUS'))

	## rename some of the fields to match the known records
		cch.sub <- cch %>% mutate(DataSource=paste0('cch', sprintf("%05d", 1:nrow(cch))), error_radius=as.numeric(error_radius)) %>%
												rename(ScientificName = scientificName, x_coord=x_epsg_3310, y_coord=y_epsg_3310) %>%
													filter(is.na(possible_mislabel), ScientificName %in% uids$ScientificName | ScientificName %in% uids$ScientificName_original) %>%
														select(DataSource, ScientificName, x_coord, y_coord, error_radius, error_radius_units)
		## standardize the coordinate uncertainty (error_radius_units) to km, mi, m, and ft
					cch.sub <- cch.sub %>%
								mutate(
							    error_radius_units = case_when(
							      error_radius_units %in% c('feet', 'ft.') ~ 'ft',
							      error_radius_units %in% c('kilometers', 'km') ~ 'km',
							      error_radius_units %in% c('m', 'meters', 'meters radius') ~ 'm',
							      error_radius_units %in% c('mi', 'mi.', 'mi. ', 'mile', 'miles') ~ 'mi',
							      TRUE ~ as.character(error_radius_units)
							    )
								)

					# unique(cch.sub$error_radius_units) %>% sort()
		## now convert the coordinate uncertainty to meters
					cch.sub <- cch.sub %>%
								mutate(
							    error_radius = case_when(
							      error_radius_units == 'ft' ~ error_radius*0.3048,
							      error_radius_units == 'km' ~ error_radius*1000,
							      error_radius_units == 'm' ~ error_radius*1,
							      error_radius_units == 'mi' ~ error_radius*1609.34,
							      TRUE ~ as.numeric(error_radius)
							    )
								)
					# unique(cch.sub$error_radius_units) %>% sort()
					## add a new field coord_uncertainty_m
					cch.sub <- cch.sub %>% mutate(CoordinateUncertaintyMeters=as.numeric(error_radius), EPSG='3310') %>%
																	select(-error_radius, -error_radius_units)
						# names(cch.sub)
									# lapply(cch, class)
											# name.check <- cch.sub %>% select(ScientificName, current_name, current_name_binomial) %>% unique()
									# length(unique(cch$id))
									# length(unique(cch$X))
											# unique(cch$cultivated)
											# maxy <- filter(cch, !is.na(maxent_index))
											# 	maxy$maxent_index[1:10]
											# head(cch.sub)
cch <- cch.sub; rm(cch.sub)
write_xlsx(cch, 'CCH_BLM.xlsx')
save(cch, known, mynames, uids, file='BLM_data.RData')
########################################################################################################################################################
B_A <- read_excel('/Users/sstill/Box/Seed Menus Project/HerbariumRecords/HerbariumRecords_wHeaders/Burke_AllSpp_wHeaders.xlsx', col_types = 'text')
# latitude is y_coord, longitute is x_coord
B_A <- B_A %>% mutate(DataSource = paste0('Burke', id)) %>%
  rename(Datum = datum, ScientificName = scientificName, x_coord = longitude, y_coord = latitude, PLANTS_symbol = SYMBOL) %>%
  # CoordinateSystem, ZoneAll, PLANTS_symbol were missing in the raw data
	  mutate(CoordinateSystem=NA_character_, Zone = NA_character_, x_coord = as.numeric(x_coord), y_coord = as.numeric(y_coord), CoordinateUncertaintyMeters = as.numeric(CoordinateUncertaintyMeters)) %>%
	  select(DataSource, ScientificName, SppCode, PLANTS_symbol, CoordinateSystem, Datum, Zone, x_coord, y_coord, CoordinateUncertaintyMeters) %>%
  # filter out all the missing latitudes and longitudes
		  filter(!is.na(x_coord)) %>%
		  filter(!is.na(y_coord))
	# lapply(B_A, class)

I_A <- read_excel('/Users/sstill/Box/Seed Menus Project/HerbariumRecords/HerbariumRecords_wHeaders/IntermountainFlora_AllSpp_wHeaders.xlsx', col_types = 'text')
# I_A$DataSource = paste0('Intermountain', I_A$id)
I_A <- I_A %>% mutate(DataSource = paste0('Intermountain', id)) %>%
  rename(Datum = datum, ScientificName = scientificName, x_coord = longitude, y_coord = latitude, PLANTS_symbol = Symbol)%>%
	  mutate(CoordinateSystem=NA_character_, x_coord = as.numeric(x_coord), y_coord = as.numeric(y_coord), CoordinateUncertaintyMeters = as.numeric(CoordinateUncertaintyMeters)) %>%
	  select(DataSource, ScientificName, SppCode, PLANTS_symbol, CoordinateSystem, Datum, Zone, x_coord, y_coord, CoordinateUncertaintyMeters) %>%
	  filter(!is.na(x_coord)) %>%
	  filter(!is.na(y_coord))
# unique(I_A$Symbol)
  	# lapply(I_A, class)
	# I_A$Zone <- as.numeric(I_A$Zone)

S_A <- read_excel('/Users/sstill/Box/Seed Menus Project/HerbariumRecords/HerbariumRecords_wHeaders/Smithsonian_AllSpp_wHeaders.xlsx', col_types = 'text')
# S_A$DataSource = paste0('Smithsonian', 1:nrow(S_A))
S_A <- S_A %>%  mutate(DataSource = paste0('SMITH', 1:nrow(S_A))) %>%
  # choose the Taxonomic name as the scientific name
	  rename(Datum = datum, ScientificName = `Taxonomic Name (Filed As : Identified By : Identification Date)`, x_coord = longitude, y_coord = latitude)%>%
	  mutate(CoordinateSystem=NA_character_, PLANTS_symbol = NA_character_, Zone = NA_character_, x_coord = as.numeric(x_coord), y_coord = as.numeric(y_coord), CoordinateUncertaintyMeters = as.numeric(CoordinateUncertaintyMeters)) %>%
	  select(DataSource, ScientificName, SppCode, PLANTS_symbol, CoordinateSystem, Datum, Zone, x_coord, y_coord, CoordinateUncertaintyMeters) %>%
	  filter(!is.na(x_coord)) %>%
	  filter(!is.na(y_coord))
	# unique(S_A$Symbol)

	# S_A$Zone <- as.numeric(S_A$Zone)
names(B_A)
names(S_A)
names(I_A)

# # combine herbarium data
herbaria <-  bind_rows(B_A, I_A, S_A); rm(B_A, I_A, S_A)
# # combine known and herbarium data
# known = read_excel('C:/Users/plyu/Desktop/New folder/KnownSPDF.xlsx')
# know2 = known %>%
#   #mutate(CoordinateUncertaintyMeters = NA) %>%
#   bind_rows(known, comherbarium)
#
# library(writexl)
write_xlsx(herbaria, 'herbaria_BLM.xlsx')
herb <- herbaria; rm(herbaria)
save(cch, known, herb, uids, mynames, file='BLM_data.RData')
# ########################################################################################################################################################
## bring in the rest of the herbarium data and combine with the Jepson data
				herb <- herb %>% mutate(CoordinateUncertaintyMeters=as.numeric(CoordinateUncertaintyMeters), EPSG='undefined')

				# unique(herb$Datum)
				# unique(known$Datum)
				# unique(herb$CoordinateSystem)
				# lapply(herb, class)
			## create lists of datum to be corrected
					wgs84std <- c('WGS84', 'WSG84', 'WGS 84', 'WGS 1984', 'WGS 1984.', 'WGS 1984,', 'WGS-84', 'WGS-1984', 'WGS 83', 'wgs 84', 'WGS84  (UTM Datum: N/A)', 'World Geodetic System 1984', 'GPS', 'GST 84', '(GPS, WGS 84)', 'WGS', 'MAP', 'OTHER', 'Other')
					wgs72std <- c('WGS72', 'WGS 72')
					nad83std <- c('NAD83', 'NAD 83', 'NAD-83', 'Nad 83', 'NAd83', 'NAD 83/84', 'NADA83', 'WGS84  (UTM Datum: NAD83)', 'NAD84', 'NAD 84', 'NAD 83/WGS84', 'NAD83/84', 'GRS 83')
					nad27std <- c('NAD27', 'NAD 27', 'NAD-27', 'NAD27 CONUS', 'NAD 27 CONUS', 'North American Datum 1927')
				datum.std <- list(wgs84std, wgs72std, nad83std, nad27std)
					names(datum.std) <- c('wgs84', 'wgs72', 'nad83', 'nad27'); rm(wgs84std, wgs72std, nad83std, nad27std)
		## standardize the Datum
		# 			herb <- herb %>%
		# 						mutate(
		# 					    Datum = case_when(
		# 					      Datum %in% datum.std$wgs84 ~ 'WGS84',
		# 					      Datum %in% datum.std$wgs72 ~ 'WGS72',
		# 					      Datum %in% datum.std$nad83 ~ 'NAD83',
		# 					      Datum %in% datum.std$nad27 ~ 'NAD27',
		# 					      Datum %in% c('Other', 'OTHER', 'MAP') ~ 'undefined datum',
		# 					      TRUE ~ as.character(Datum)
		# 					    )
		# 						)
				# unique(herb$Datum)
				# unique(known$Datum)
		# 	# gst84 <- filter(herb, Datum == 'GST 84')
		# 		unique(herb$CoordinateSystem)
		# 
		# 			# names(cch)
		# 			# head(cch)
		# 			# 	names(herb)
		# 
		# ## merge the datasets
				nm.match <- names(cch)[names(cch) %in% names(herb)]
											names(cch)
											names(herb)
											names(known)
						all.eos <- full_join(herb, cch, by=nm.match) %>% select(DataSource:SppCode, PLANTS_symbol, CoordinateSystem:EPSG)
							nm.match <- names(all.eos)[names(all.eos) %in% names(known)]
							no.match <- names(known)[!names(known) %in% names(all.eos)]

							lapply(all.eos, class)
							lapply(known, class)
						all.eos <- full_join(all.eos, known, by=nm.match)
						 all.eos <- all.eos %>% mutate(UID=paste0('BLM', sprintf('%05d', 1:nrow(all.eos)))) %>% select(UID, DataSource:SppCode, PLANTS_symbol, CoordinateSystem:EPSG)
write_xlsx(all.eos, 'all_BLM.xlsx')
save(all.eos, cch, known, herb, mynames, uids, file='BLM_data.RData')
		# rm(cch, herb, known, mynames, no.match, nm.match)
# ########################################################################################################################################################
# 			## clean up the big dataset
load('BLM_data.RData')
all.eos
						names(all.eos)
				unique(all.eos$Datum)
				unique(all.eos$CoordinateSystem)

		all.eos$CoordinateSystem <- gsub('Decimal Degrees', 'longlat', all.eos$CoordinateSystem)

			# gst84 <- filter(herb, Datum == 'GST 84')
		## standardize the Datum
					all.eos <- all.eos %>%
								mutate(
							    Datum = case_when(
							      Datum %in% datum.std$wgs84 ~ 'WGS84',
							      Datum %in% datum.std$wgs72 ~ 'WGS72',
							      Datum %in% datum.std$nad83 ~ 'NAD83',
							      Datum %in% datum.std$nad27 ~ 'NAD27',
 							      Datum %in% c('Other', 'OTHER', 'MAP') ~ 'undefined datum',
							      TRUE ~ as.character(Datum)
							    )
								)
				unique(all.eos$Datum)
all.eos <- arrange(all.eos, SppCode, PLANTS_symbol, ScientificName, UID)
write_xlsx(all.eos, 'all_BLM.xlsx')
# uids <- select(all.eos, ScientificName, SppCode, PLANTS_symbol) %>% unique()
save(all.eos, cch, known, herb, uids, mynames, file='BLM_data.RData')

			# write_xlsx(uids, 'these_names.xlsx')

########################################################################################################################################################
# 
# ########################################################################################################################################################
# 
# ########################################################################################################################################################
# ########################################################################################################################################################
# UID  <- unique(known$ScientificName)

# UID  <- unique(known$ScientificName)
# UID2 <- unique(known$SppCode)
# uids <- select(all.eos, SppCode, ScientificName) %>% unique()
# 	# uids[1:50,]
# 			write_xlsx(uids, 'these_names.xlsx')


	# mynames <- read_excel('namesies.xlsx')
			# uids <- filter(mynames, !PLANTS_symbol %in% c('XXXXXX'), !SppCode %in% c('AMME', 'ERSUS')) %>% distinct()
				nrow(unique(mynames))
				nrow(unique(uids))

		# mynames <- read_excel('my_names.xlsx')
				# all.eos <- all.eos.s
				all.eos.s <- all.eos
		# data <- mtcars %>% mutate(mpg = replace(mpg, cyl == 4, NA))
# # 		data <- known %>%
# #         mutate(ScientificName = cyl %in% color$cyl)
# # 		data <- known %>% mutate(ScientificName = replace(ScientificName, SppCode %in% mynames$SppCodeL, mynames$ScientificName))
# # 		data <- known %>% mutate(ScientificName = replace(ScientificName, SppCode %in% mynames$SppCodeL, mynames$ScientificName))
# 		known2 <- known
# 		spp$family <- fams$family[match(spp$genus, fams$genus)]
set.SppCode <- uids %>% select(ScientificName_original, ScientificName, SppCode) %>% distinct()
set.PLTSsym <- uids %>% select(ScientificName_original, ScientificName, PLANTS_symbol) %>% distinct()
set.SciName <- uids %>% select(ScientificName, PLANTS_symbol) %>% distinct()

			unique(all.eos$SppCode); length(unique(all.eos$SppCode))
			unique(all.eos$PLANTS_symbol); length(unique(all.eos$PLANTS_symbol))
			unique(all.eos$ScientificName); length(unique(all.eos$ScientificName))

		all.eos$SppCode 				<- set.SppCode$SppCode[match(all.eos$ScientificName, set.SppCode$ScientificName_original)]
		all.eos$PLANTS_symbol 	<- set.PLTSsym$PLANTS_symbol[match(all.eos$ScientificName, set.PLTSsym$ScientificName_original)]
		all.eos$ScientificName 	<- set.SciName$ScientificName[match(all.eos$PLANTS_symbol, set.SciName$PLANTS_symbol)]

			unique(all.eos$SppCode); length(unique(all.eos$SppCode))
			unique(all.eos$PLANTS_symbol); length(unique(all.eos$PLANTS_symbol))
			unique(all.eos$ScientificName); length(unique(all.eos$ScientificName))

			all.eos <- filter(all.eos, SppCode %in% uids$SppCode, PLANTS_symbol %in% uids$PLANTS_symbol)

			write_xlsx(all.eos, 'all_BLM.xlsx')
			save(all.eos, cch, known, herb, uids, mynames, file='BLM_data.RData')

	######################################################################################################
# 	## This ends section of code bring in the Known EOs from researchers
# 	######################################################################################################
#download and sort CCH data
rm(list=ls())
getwd()
	# my.packages <- c('dplyr')
	my.packages <- c('readxl', 'tidyr', 'writexl', 'dplyr') #'rgdal', 'raster'
	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
#install.packages (my.packages) #Turn on to install current versions
	lapply(my.packages, require, character.only=TRUE); rm(my.packages)

	## add EPSG to all.eos

				load('BLM_data.RData')

			all.eos <- all.eos %>%
					mutate(
				    CoordinateSystem = case_when(
				      is.na(CoordinateSystem) & x_coord < 0 & abs(x_coord) < 180 & abs(y_coord) < 90 ~ 'longlat',
				      CoordinateSystem == 'undefined' & x_coord < 0 & abs(x_coord) < 180 & abs(y_coord) < 90 ~ 'longlat',
				      is.na(CoordinateSystem) & x_coord > 0 & abs(x_coord) > 180 & abs(y_coord) > 90 ~ 'UTM',
				      CoordinateSystem == 'undefined' & x_coord > 0 & abs(x_coord) > 180 & abs(y_coord) > 90 ~ 'UTM',
				      # CoordinateSystem == 'Decimal Degrees' ~ 'longlat',
				      TRUE ~ as.character(CoordinateSystem)
				    )
					)


unique(all.eos$CoordinateSystem)
unique(all.eos$Datum)
unique(all.eos$EPSG)
# unique(sub.eos$EPSG)
# unique(sub.eos$EPSG)
all.eos <- filter(all.eos, !is.na(x_coord), !is.na(y_coord))
sub.eos <- filter(all.eos, is.na(Zone) & CoordinateSystem == 'UTM' & EPSG == 'undefined' | is.na(EPSG))
no.utm.sys <- filter(all.eos, is.na(Zone) & CoordinateSystem == 'UTM')
no.sys <- filter(all.eos, is.na(CoordinateSystem) | EPSG != 'undefined', EPSG != '3310')
	write_xlsx(no.sys, 'cleaning_sheets/no_CoordinateSystem.xlsx')

 				all.eos <- all.eos %>% 
 					mutate(
 				    EPSG = case_when(
 				      EPSG == 'undefined' & Datum == 'WGS84' & CoordinateSystem == 'longlat' ~ '4326',
 				      EPSG == 'undefined' & Datum == 'WGS84' & CoordinateSystem == 'UTM' & Zone %in% c('10', '10N') ~ '32610',
 					      EPSG == 'undefined' & Datum == 'WGS84' & CoordinateSystem == 'UTM' & Zone %in% c('11', '11S', '11s', '11N', '11T') ~ '32611',
 					      EPSG == 'undefined' & Datum == 'WGS84' & CoordinateSystem == 'UTM' & Zone %in% c('12', '12s', '12S') ~ '32612',
 					      EPSG == 'undefined' & Datum == 'WGS84' & CoordinateSystem == 'UTM' & Zone %in% c('13', '13S', '13T', '13N') ~ '32613',
 				      EPSG == 'undefined' & Datum == 'NAD83' & CoordinateSystem == 'longlat' ~ '4269',
 				      EPSG == 'undefined' & Datum == 'NAD83' & CoordinateSystem == 'UTM' & Zone %in% c('10', '10N') ~ '26910',
 					      EPSG == 'undefined' & Datum == 'NAD83' & CoordinateSystem == 'UTM' & Zone %in% c('11', '11S', '11s', '11N', '11T') ~ '26911',
 					      EPSG == 'undefined' & Datum == 'NAD83' & CoordinateSystem == 'UTM' & Zone %in% c('12', '12s', '12S') ~ '26912',
 					      EPSG == 'undefined' & Datum == 'NAD83' & CoordinateSystem == 'UTM' & Zone %in% c('13', '13S', '13T', '13N') ~ '26913',
 				      EPSG == 'undefined' & Datum == 'WGS72' & CoordinateSystem == 'longlat' ~ '4322',
 				      EPSG == 'undefined' & Datum == 'WGS72' & CoordinateSystem == 'UTM' & Zone %in% c('10', '10N') ~ '32210',
 					      EPSG == 'undefined' & Datum == 'WGS72' & CoordinateSystem == 'UTM' & Zone %in% c('11', '11S', '11s', '11N', '11T') ~ '32211',
 					      EPSG == 'undefined' & Datum == 'WGS72' & CoordinateSystem == 'UTM' & Zone %in% c('12', '12s', '12S') ~ '32212',
 					      EPSG == 'undefined' & Datum == 'WGS72' & CoordinateSystem == 'UTM' & Zone %in% c('13', '13S', '13T', '13N') ~ '32213',
 				      EPSG == 'undefined' & Datum == 'NAD27' & CoordinateSystem == 'longlat' ~ '4267',
 				      EPSG == 'undefined' & Datum == 'NAD27' & CoordinateSystem == 'UTM' & Zone %in% c('10', '10N') ~ '26710',
 					      EPSG == 'undefined' & Datum == 'NAD27' & CoordinateSystem == 'UTM' & Zone %in% c('11', '11S', '11s', '11N', '11T') ~ '26711',
 					      EPSG == 'undefined' & Datum == 'NAD27' & CoordinateSystem == 'UTM' & Zone %in% c('12', '12s', '12S') ~ '26712',
 					      EPSG == 'undefined' & Datum == 'NAD27' & CoordinateSystem == 'UTM' & Zone %in% c('13', '13S', '13T', '13N') ~ '26713',
 				      TRUE ~ as.character(EPSG)
 				    )
 					)
 all.eos$EPSG
unique(all.eos$CoordinateSystem); 
	all.eos$CoordinateSystem[grep('Terra', all.eos$DataSource)]
unique(all.eos$Datum)
unique(all.eos$EPSG)

 save(all.eos, cch, herb, known, no.sys, no.utm.sys, sub.eos, uids, mynames, file='BLM_data.RData')
########################################################################################################################################################
			rm(list=ls())
	my.packages <- c('dplyr') #'rgdal', 'raster'
	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
#install.packages (my.packages) #Turn on to install current versions
	lapply(my.packages, require, character.only=TRUE); rm(my.packages)

projxns <- rbind(c('WGS84', 'longlat', 4326, NA, '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'), c('WGS72', 'longlat', 4322, NA, '+proj=longlat +ellps=WGS72 +towgs84=0,0,4.5,0,0,0.554,0.2263 +no_defs'))
projxns <- rbind(projxns, c('NAD27', 'longlat', 4267, NA, '+proj=longlat +ellps=clrk66 +datum=NAD27 +no_defs'))
projxns <- rbind(projxns, c('NAD83', 'longlat', 4269, NA, '+proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs'))
projxns <- rbind(projxns, c('WGS72', 'UTM', 32210, 10, '+proj=utm +zone=10 +ellps=WGS72 +units=m +no_defs'))
projxns <- rbind(projxns, c('WGS72', 'UTM', 32211, 11, '+proj=utm +zone=11 +ellps=WGS72 +units=m +no_defs'))
projxns <- rbind(projxns, c('WGS72', 'UTM', 32212, 12, '+proj=utm +zone=12 +ellps=WGS72 +units=m +no_defs'))
projxns <- rbind(projxns, c('WGS72', 'UTM', 32213, 13, '+proj=utm +zone=13 +ellps=WGS72 +units=m +no_defs'))
projxns <- rbind(projxns, c('WGS84', 'UTM', 32610, 10, '+proj=utm +zone=10 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'))
projxns <- rbind(projxns, c('WGS84', 'UTM', 32611, 11, '+proj=utm +zone=11 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'))
projxns <- rbind(projxns, c('WGS84', 'UTM', 32612, 12, '+proj=utm +zone=12 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'))
projxns <- rbind(projxns, c('WGS84', 'UTM', 32613, 13, '+proj=utm +zone=13 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'))
projxns <- rbind(projxns, c('NAD83', 'UTM', 26910, 10, '+proj=utm +zone=10 +ellps=GRS80 +datum=NAD83 +units=m +no_defs'))
projxns <- rbind(projxns, c('NAD83', 'UTM', 26911, 11, '+proj=utm +zone=11 +ellps=GRS80 +datum=NAD83 +units=m +no_defs'))
projxns <- rbind(projxns, c('NAD83', 'UTM', 26912, 12, '+proj=utm +zone=12 +ellps=GRS80 +datum=NAD83 +units=m +no_defs'))
projxns <- rbind(projxns, c('NAD83', 'UTM', 26913, 13, '+proj=utm +zone=13 +ellps=GRS80 +datum=NAD83 +units=m +no_defs'))
projxns <- rbind(projxns, c('NAD27', 'UTM', 26710, 10, '+proj=utm +zone=10 +ellps=clrk66 +datum=NAD27 +units=m +no_defs'))
projxns <- rbind(projxns, c('NAD27', 'UTM', 26711, 11, '+proj=utm +zone=11 +ellps=clrk66 +datum=NAD27 +units=m +no_defs'))
projxns <- rbind(projxns, c('NAD27', 'UTM', 26712, 12, '+proj=utm +zone=12 +ellps=clrk66 +datum=NAD27 +units=m +no_defs'))
projxns <- rbind(projxns, c('NAD27', 'UTM', 26713, 13, '+proj=utm +zone=13 +ellps=clrk66 +datum=NAD27 +units=m +no_defs'))
projxns <- rbind(projxns, c('CA-Albers', 'UTM', 3310, NA, '+proj=aea +lat_1=34 +lat_2=40.5 +lat_0=0 +lon_0=-120 +x_0=0 +y_0=-4000000 +ellps=GRS80 +datum=NAD83 +units=m +no_defs'))
# projxns <- rbind(projxns, c('NAD83', 'UTM', 3310, NA, '+proj=aea +lat_1=34 +lat_2=40.5 +lat_0=0 +lon_0=-120 +x_0=0 +y_0=-4000000 +ellps=GRS80 +datum=NAD83 +units=m +no_defs'))
projxns <- as.data.frame(projxns)
names(projxns) <- c('Datum', 'CoordinateSystem', 'EPSG', 'Zone', 'proj4string')
projxns <- select(projxns, Datum, CoordinateSystem, Zone, proj4string, EPSG)

	load('BLM_data.RData')

# write_xlsx(as.data.frame(projxns), 'projections_table.xlsx')
save(all.eos, cch, herb, known, no.sys, no.utm.sys, sub.eos, uids, mynames, projxns, file='BLM_data.RData')
#######################################################################################################################################################
			rm(list=ls())
	my.packages <- c('rgdal', 'raster', 'dplyr') #'rgdal', 'raster'
	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
#install.packages (my.packages) #Turn on to install current versions
	lapply(my.packages, require, character.only=TRUE); rm(my.packages)

## bring in the files to create and convert the spatial polygons
	load('BLM_data.RData')
	# known <- read_excel('KnownOccs.xlsx')
				names(all.eos)
				head(all.eos)

	r.1 <- raster('data_in/BLM_data/KnownOccurrences/ASCII/cumlaet.asc')

		plot(r.1)
		proj4string(r.1)

		proj4string2use <- proj4string(r.1)
			# rm(r.1)
########################################################################################################################################################
					## WGS72   EPSG:4322   +proj=longlat +ellps=WGS72 +towgs84=0,0,4.5,0,0,0.554,0.2263 +no_defs
					## WGS84   EPSG:4326   +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0
					## NAD27   EPSG:4267   +proj=longlat +ellps=clrk66 +datum=NAD27 +no_defs
					## NAD83   EPSG:4269   +proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs
as.data.frame(all.eos %>% dplyr::select(Datum, CoordinateSystem, EPSG, Zone) %>% unique())
# 		filter()
deg.alber <- all.eos %>% filter(EPSG == 3310)
all.others <- all.eos %>% filter(!DataSource %in% deg.alber$DataSource) 		
deg.wgs84 <- all.others %>% filter(CoordinateSystem == 'longlat' & Datum == 'WGS84' | 
																												 is.na(CoordinateSystem) & Datum == 'WGS84' & x_coord < 0 & abs(x_coord) < 180 | 
																												 	is.na(CoordinateSystem) & is.na(Datum) & x_coord < 0 & abs(x_coord) < 180) %>% filter(abs(y_coord) < 90)
deg.nad83 <- all.others %>% filter(CoordinateSystem == 'longlat' & Datum == 'NAD83' | 
																												 	is.na(CoordinateSystem) & Datum == 'NAD83' & x_coord < 0 & abs(x_coord) < 180) %>% filter(abs(y_coord) < 90)
# deg.nad83 <- all.others %>% filter(EPSG != 3310) %>% filter(CoordinateSystem == 'longlat' & Datum == 'NAD83' | 
# 																												 	is.na(CoordinateSystem) & Datum == 'NAD83' & x_coord < 0 & abs(x_coord) < 180)
utm.wgs84 <- all.others %>% filter(CoordinateSystem == 'UTM' & Datum == 'WGS84')
utm.nad83 <- all.others %>% filter(CoordinateSystem == 'UTM' & Datum == 'NAD83')
deg.wgs72 <- all.others %>% filter(CoordinateSystem == 'longlat' & Datum == 'WGS72' | is.na(CoordinateSystem) & Datum == 'WGS72' & abs(x_coord) < 180 | is.na(CoordinateSystem) & is.na(Datum) & abs(x_coord) < 180) %>% filter(abs(y_coord) < 90)
deg.nad27 <- all.others %>% filter(CoordinateSystem == 'longlat' & Datum == 'NAD27' | is.na(CoordinateSystem) & Datum == 'NAD27' & abs(x_coord) < 180) %>% filter(abs(y_coord) < 90)
utm.nad27 <- all.others %>% filter(CoordinateSystem == 'UTM' & Datum == 'NAD27')
# utm.wgs72 <- all.eos %>% filter(EPSG != 3310) %>% filter(CoordinateSystem == 'UTM' & Datum == 'WGS72')
# deg.wgs84 <- known %>% filter(CoordinateSystem == 'longlat' & Datum == 'WGS84' | is.na(CoordinateSystem) & Datum == 'WGS84' & abs(x_coord) < 180 | is.na(CoordinateSystem) & is.na(Datum) & abs(x_coord) < 180)
# deg.nad83 <- known %>% filter(CoordinateSystem == 'longlat' & Datum == 'NAD83' | is.na(CoordinateSystem) & Datum == 'NAD83' & abs(x_coord) < 180)
# utm.wgs84 <- known %>% filter(CoordinateSystem == 'UTM' & Datum == 'WGS84')
# utm.nad83 <- known %>% filter(CoordinateSystem == 'UTM' & Datum == 'NAD83')
# deg.wgs84 <- filter(deg.wgs84, abs(y_coord) < 90)
# deg.nad83 <- filter(deg.nad83, abs(y_coord) < 90)
# deg.wgs72 <- filter(deg.wgs72, abs(y_coord) < 90)
# deg.nad27 <- filter(deg.nad27, abs(y_coord) < 90)
		# nrow(deg.wgs84) + nrow(deg.nad83) + nrow(utm.wgs84) + nrow(utm.nad83)
		# nrow(known)
		# nrow(known) == nrow(deg.wgs84) + nrow(deg.nad83) + nrow(utm.wgs84) + nrow(utm.nad83)
		# 	unique(known$CoordinateSystem)
		# 	unique(known$CoordinateSystem)

		## create the SPDF for WGS84 lon/lat
		coords <- cbind(deg.wgs84$x_coord, deg.wgs84$y_coord)
			deg.wgs84.spdf <- SpatialPointsDataFrame(coords, deg.wgs84)
			deg.wgs84.spdf@proj4string <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") #EPSG: 4326
				deg.wgs84.spdf@proj4string
				# plot(deg.wgs84.spdf)
				# plot(r.1)
				# points(deg.wgs84.spdf)

			## transform the projection for WGS84 lon/lat
				new.deg.wgs84 <- spTransform(deg.wgs84.spdf, CRS(proj4string2use))
		  		points(new.deg.wgs84)

				new.deg.wgs84@data
				new.deg.wgs84@coords
					new.deg.wgs84@proj4string
			new.deg.wgs84@data$x_coord <- coordinates(new.deg.wgs84)[,1]
					new.deg.wgs84@data$y_coord <- coordinates(new.deg.wgs84)[,2]
					# new.deg.wgs84@data$CoordinateSystem <- 'UTM'
					# new.deg.wgs84@data$Zone <- '11'
					# new.deg.wgs84@data$Datum <- 'NAD83'

		## create the SPDF for WGS72 lon/lat
		coords <- cbind(deg.wgs72$x_coord, deg.wgs72$y_coord)
			deg.wgs72.spdf <- SpatialPointsDataFrame(coords, deg.wgs72)
			deg.wgs72.spdf@proj4string <- CRS("+proj=longlat +ellps=WGS72 +towgs84=0,0,4.5,0,0,0.554,0.2263 +no_defs") #EPSG: 4326
				deg.wgs72.spdf@proj4string
				# plot(deg.wgs84.spdf)
				# plot(r.1)
				# points(deg.wgs84.spdf)
				# points(new.deg.wgs72)

			## transform the projection for WGS84 lon/lat
				new.deg.wgs72 <- spTransform(deg.wgs72.spdf, CRS(proj4string2use))

				new.deg.wgs72@data
				new.deg.wgs72@coords
					new.deg.wgs72@proj4string
			new.deg.wgs72@data$x_coord <- coordinates(new.deg.wgs72)[,1]
					new.deg.wgs72@data$y_coord <- coordinates(new.deg.wgs72)[,2]
					# new.deg.wgs72@data$CoordinateSystem <- 'UTM'
					# new.deg.wgs72@data$Zone <- '11'
					# new.deg.wgs72@data$Datum <- 'NAD83'

# create the SPDF for NAD83 lon/lat
			coords <- cbind(deg.nad83$x_coord, deg.nad83$y_coord)
					deg.nad83.spdf <- SpatialPointsDataFrame(coords, deg.nad83)
					deg.nad83.spdf@proj4string <- CRS("+proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs") #EPSG: 4269
						deg.nad83.spdf@proj4string
			## transform the projection for NAD83 lon/lat
				new.deg.nad83 <- spTransform(deg.nad83.spdf, CRS(proj4string2use))
					new.deg.nad83@proj4string
			new.deg.nad83@data$x_coord <- coordinates(new.deg.nad83)[,1]
					new.deg.nad83@data$y_coord <- coordinates(new.deg.nad83)[,2]
					# new.deg.nad83@data$CoordinateSystem <- 'UTM'
					# new.deg.nad83@data$Zone <- '11'
					# new.deg.nad83@data$Datum <- 'NAD83'

		## create the SPDF for NAD27 lon/lat
			coords <- cbind(deg.nad27$x_coord, deg.nad27$y_coord)
					deg.nad27.spdf <- SpatialPointsDataFrame(coords, deg.nad27)
					deg.nad27.spdf@proj4string <- CRS("+proj=longlat +ellps=clrk66 +datum=NAD27 +no_defs") #EPSG: 4269
						deg.nad27.spdf@proj4string
			## transform the projection for NAD27 lon/lat
				new.deg.nad27 <- spTransform(deg.nad27.spdf, CRS(proj4string2use))
					new.deg.nad27@proj4string
			new.deg.nad27@data$x_coord <- coordinates(new.deg.nad27)[,1]
					new.deg.nad27@data$y_coord <- coordinates(new.deg.nad27)[,2]
					# new.deg.nad27@data$CoordinateSystem <- 'UTM'
					# new.deg.nad27@data$Zone <- '11'
					# new.deg.nad27@data$Datum <- 'NAD83'

		## create the SPDF for California ALbers lon/lat
			coords <- cbind(deg.alber$x_coord, deg.alber$y_coord)
					deg.alber.spdf <- SpatialPointsDataFrame(coords, deg.alber)
					deg.alber.spdf@proj4string <- CRS("+proj=aea +lat_1=34 +lat_2=40.5 +lat_0=0 +lon_0=-120 +x_0=0 +y_0=-4000000 +ellps=GRS80 +datum=NAD83 +units=m +no_defs") #EPSG: 4269
						deg.alber.spdf@proj4string
			## transform the projection for NAD83 lon/lat
				new.deg.alber <- spTransform(deg.alber.spdf, CRS(proj4string2use))
					new.deg.alber@proj4string
			new.deg.alber@data$x_coord <- coordinates(new.deg.alber)[,1]
					new.deg.alber@data$y_coord <- coordinates(new.deg.alber)[,2]
					# new.deg.alber@data$CoordinateSystem <- 'UTM'
					# new.deg.alber@data$Zone <- '11'
					# new.deg.alber@data$Datum <- 'NAD83'


		## create the SPDF for WGS84 UTM
					# utm10.wgs84 <- filter(utm.wgs84, Zone=='10')
						unique(utm.wgs84$Zone)
						unique(utm.nad83$Zone)
					# utm11.wgs84 <- filter(utm.wgs84, Zone %in% c('11', '11s', '11S', '11N', '11T'))
					utm12.wgs84 <- filter(utm.wgs84, Zone %in% c('12', '12S', '12s', '12N'))
		# coords10 <- cbind(utm10.wgs84$x_coord, utm.wgs84$y_coord)
		# coords11 <- cbind(utm11.wgs84$x_coord, utm11.wgs84$y_coord)
		coords12 <- cbind(utm12.wgs84$x_coord, utm12.wgs84$y_coord)
			# utm.wgs84.spdf <- SpatialPointsDataFrame(coords12, utm12.wgs84)

			# utm10.wgs84.spdf <- SpatialPointsDataFrame(coords, utm10.wgs84)
			# utm11.wgs84.spdf <- SpatialPointsDataFrame(coords11, utm11.wgs84)
			utm12.wgs84.spdf <- SpatialPointsDataFrame(coords12, utm12.wgs84)

			# utm10.wgs84.spdf@proj4string <- CRS("+proj=utm +zone=10 +datum=WGS84") #zone 10
			# utm11.wgs84.spdf@proj4string <- CRS("+proj=utm +zone=11 +datum=WGS84") #zone 11
			utm12.wgs84.spdf@proj4string <- CRS("+proj=utm +zone=12 +datum=WGS84") #zone 12
			# proj4string(x) <-CRS("+proj=utm +zone=10 +datum=WGS84")
				utm12.wgs84.spdf@proj4string
				plot(utm12.wgs84.spdf)

			## transform the projection for WGS84 UTM
				new.utm12.wgs84 <- spTransform(utm12.wgs84.spdf, CRS(proj4string2use))
					new.utm12.wgs84@proj4string
						new.utm12.wgs84@data$x_coord <- coordinates(new.utm12.wgs84)[,1]
								new.utm12.wgs84@data$y_coord <- coordinates(new.utm12.wgs84)[,2]
								# new.utm12.wgs84@data$CoordinateSystem <- 'UTM'
								# new.utm12.wgs84@data$Zone <- '11'
								# new.utm12.wgs84@data$Datum <- 'NAD83'
			# 	new.utm11.wgs84 <- spTransform(utm11.wgs84.spdf, CRS(proj4string2use))
			# 		new.utm11.wgs84@proj4string
			# new.utm11.wgs84@data$x_coord <- coordinates(new.utm11.wgs84)[,1]
			# 		new.utm11.wgs84@data$y_coord <- coordinates(new.utm11.wgs84)[,2]
			# 		new.utm11.wgs84@data$CoordinateSystem <- 'UTM'
			# 		new.utm11.wgs84@data$Zone <- '11'
			# 		new.utm11.wgs84@data$Datum <- 'NAD83'

		## create the SPDF for NAD83 UTM
		# utm11.nad83 <- filter(utm.nad83, Zone=='11')
					utm11.nad83 <- filter(utm.nad83, Zone %in% c('11', '11S', '11N', '11T'))
		# utm12.nad83 <- filter(utm.nad83, Zone=='12')
					utm12.nad83 <- filter(utm.nad83, Zone %in% c('12', '12S', '12N'))
		# utm13.nad83 <- filter(utm.nad83, Zone=='12')
					utm13.nad83 <- filter(utm.nad83, Zone %in% c('13S', '13'))

			# coords <- cbind(utm.nad83$x_coord, utm.nad83$y_coord)
			# coords10 <- cbind(utm10.wgs84$x_coord, utm.wgs84$y_coord)
			coords11 <- cbind(utm11.nad83$x_coord, utm11.nad83$y_coord)
			coords12 <- cbind(utm12.nad83$x_coord, utm12.nad83$y_coord)
			coords13 <- cbind(utm13.nad83$x_coord, utm13.nad83$y_coord)
					utm11.nad83.spdf <- SpatialPointsDataFrame(coords11, utm11.nad83)
					utm12.nad83.spdf <- SpatialPointsDataFrame(coords12, utm12.nad83)
					utm13.nad83.spdf <- SpatialPointsDataFrame(coords13, utm13.nad83)
					utm11.nad83.spdf@proj4string <- CRS("+proj=utm +zone=11 +datum=NAD83")
					utm12.nad83.spdf@proj4string <- CRS("+proj=utm +zone=12 +datum=NAD83")
					utm13.nad83.spdf@proj4string <- CRS("+proj=utm +zone=13 +datum=NAD83")
						utm11.nad83.spdf@proj4string

				# UTM, Zone 10 (EPSG: 32610)

			## transform the projection for NAD83 UTM
				new.utm11.nad83 <- spTransform(utm11.nad83.spdf, CRS(proj4string2use))
				new.utm12.nad83 <- spTransform(utm12.nad83.spdf, CRS(proj4string2use))
				new.utm13.nad83 <- spTransform(utm13.nad83.spdf, CRS(proj4string2use))
					new.utm11.nad83@proj4string
			new.utm11.nad83@data$x_coord <- coordinates(new.utm11.nad83)[,1]
					new.utm11.nad83@data$y_coord <- coordinates(new.utm11.nad83)[,2]
					# new.utm11.nad83@data$CoordinateSystem <- 'UTM'
					# new.utm11.nad83@data$Zone <- '11'
					# new.utm11.nad83@data$Datum <- 'NAD83'
			new.utm12.nad83@data$x_coord <- coordinates(new.utm12.nad83)[,1]
					new.utm12.nad83@data$y_coord <- coordinates(new.utm12.nad83)[,2]
					# new.utm12.nad83@data$CoordinateSystem <- 'UTM'
					# new.utm12.nad83@data$Zone <- '11'
					# new.utm12.nad83@data$Datum <- 'NAD83'
			new.utm13.nad83@data$x_coord <- coordinates(new.utm13.nad83)[,1]
					new.utm13.nad83@data$y_coord <- coordinates(new.utm13.nad83)[,2]
					# new.utm13.nad83@data$CoordinateSystem <- 'UTM'
					# new.utm13.nad83@data$Zone <- '11'
					# new.utm13.nad83@data$Datum <- 'NAD83'

		## create the SPDF for NAD27 UTM
		# utm10.nad27 <- filter(utm.nad27, Zone=='11')
					utm10.nad27 <- filter(utm.nad27, Zone %in% c('10N', '10', '10S', '10T'))
		# utm11.nad27 <- filter(utm.nad27, Zone=='11')
					utm11.nad27 <- filter(utm.nad27, Zone %in% c('11', '11S', '11N', '11T'))
		# utm12.nad27 <- filter(utm.nad27, Zone=='12')
					utm12.nad27 <- filter(utm.nad27, Zone %in% c('12', '12S', '12N'))

			# coords <- cbind(utm.nad83$x_coord, utm.nad83$y_coord)
			# coords10 <- cbind(utm10.wgs84$x_coord, utm.wgs84$y_coord)
			coords10 <- cbind(utm10.nad27$x_coord, utm10.nad27$y_coord)
			coords11 <- cbind(utm11.nad27$x_coord, utm11.nad27$y_coord)
			coords12 <- cbind(utm12.nad27$x_coord, utm12.nad27$y_coord)
					utm10.nad27.spdf <- SpatialPointsDataFrame(coords10, utm10.nad27)
					utm11.nad27.spdf <- SpatialPointsDataFrame(coords11, utm11.nad27)
					utm12.nad27.spdf <- SpatialPointsDataFrame(coords12, utm12.nad27)
					utm10.nad27.spdf@proj4string <- CRS("+proj=utm +zone=10 +ellps=clrk66 +datum=NAD27 +units=m +no_defs")
					utm11.nad27.spdf@proj4string <- CRS("+proj=utm +zone=11 +ellps=clrk66 +datum=NAD27 +units=m +no_defs")
					utm12.nad27.spdf@proj4string <- CRS("+proj=utm +zone=12 +ellps=clrk66 +datum=NAD27 +units=m +no_defs")
						utm11.nad27.spdf@proj4string

				# UTM, Zone 10 (EPSG: 32610)

			## transform the projection for NAD27 UTM
				new.utm10.nad27 <- spTransform(utm10.nad27.spdf, CRS(proj4string2use))
				new.utm11.nad27 <- spTransform(utm11.nad27.spdf, CRS(proj4string2use))
				new.utm12.nad27 <- spTransform(utm12.nad27.spdf, CRS(proj4string2use))
					new.utm11.nad83@proj4string
			new.utm10.nad27@data$x_coord <- coordinates(new.utm10.nad27)[,1]
					new.utm10.nad27@data$y_coord <- coordinates(new.utm10.nad27)[,2]
					# new.utm10.nad27@data$CoordinateSystem <- 'UTM'
					# new.utm10.nad27@data$Zone <- '11'
					# new.utm10.nad27@data$Datum <- 'NAD83'
			new.utm11.nad27@data$x_coord <- coordinates(new.utm11.nad27)[,1]
					new.utm11.nad27@data$y_coord <- coordinates(new.utm11.nad27)[,2]
					# new.utm11.nad27@data$CoordinateSystem <- 'UTM'
					# new.utm11.nad27@data$Zone <- '11'
					# new.utm11.nad27@data$Datum <- 'NAD83'
			new.utm12.nad27@data$x_coord <- coordinates(new.utm12.nad27)[,1]
					new.utm12.nad27@data$y_coord <- coordinates(new.utm12.nad27)[,2]
					# new.utm12.nad27@data$CoordinateSystem <- 'UTM'
					# new.utm12.nad27@data$Zone <- '11'
					# new.utm12.nad27@data$Datum <- 'NAD83'


		known.df <- full_join(new.deg.alber@data, new.deg.nad27@data, by=names(new.deg.alber@data))
		known.df <- full_join(known.df, new.deg.nad83@data,   by=names(known.df))
		known.df <- full_join(known.df, new.deg.wgs72@data,   by=names(known.df))
		known.df <- full_join(known.df, new.deg.wgs84@data,   by=names(known.df))
		known.df <- full_join(known.df, new.utm10.nad27@data, by=names(known.df))
		known.df <- full_join(known.df, new.utm11.nad27@data, by=names(known.df))
		known.df <- full_join(known.df, new.utm12.nad27@data, by=names(known.df))
		known.df <- full_join(known.df, new.utm11.nad83@data, by=names(known.df))
		known.df <- full_join(known.df, new.utm12.nad83@data, by=names(known.df))
		known.df <- full_join(known.df, new.utm13.nad83@data, by=names(known.df))
		known.df <- full_join(known.df, new.utm12.wgs84@data, by=names(known.df))
					known.df$CoordinateSystem <- 'UTM'
					known.df$Zone <- '11'
					known.df$Datum <- 'NAD83'
					known.df$EPSG <- '3718' #NAD83(NSRS2007) / UTM zone 11N

			
		known.df <- known.df %>% filter(!ScientificName %in% c('Pinus monticola', 'Coleogyne ramosissima', 'Ephedra nevadensis'), !SppCode %in% c('CRIN4', 'ERSUC', 'ERSUS'))
			coords <- cbind(known.df$x_coord, known.df$y_coord)
				all_blm.spdf <- SpatialPointsDataFrame(coords, known.df)
					all_blm.spdf@proj4string <- CRS(proj4string2use)

						# plot(all_blm.spdf)
						plot(r.1)
							points(all_blm.spdf)
						library('writexl')
										write_xlsx(all_blm.spdf@data, 'All_BLM.xlsx')
						proj4string(all_blm.spdf)
						# coordinates()
						
########################################################################################################################################################
		## check for records that weren't yet in final dataset
			not.yet <- all.eos %>% filter(!DataSource %in% all_blm.spdf@data$DataSource) %>% filter(EPSG != 3310)
										write_xlsx(not.yet, 'not_yet.xlsx')

########################################################################################################################################################
## let's summarize the data to see what we know
			rm(list=ls())
										load('BLM_data.Rdata')
	my.packages <- c('dplyr', 'readxl', 'writexl') #'rgdal', 'raster'
	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
#install.packages (my.packages) #Turn on to install current versions
	lapply(my.packages, require, character.only=TRUE); rm(my.packages)
					all_blm <- read_excel('All_BLM.xlsx')
					uids <- read_excel('final_names.xlsx', sheet='final_list') %>% filter(toModel == 'yes')
		# uids <- uids %>% filter(!ScientificName %in% c('Pinus monticola', 'Coleogyne ramosissima', 'Ephedra nevadensis'), !SppCode %in% c('CRIN4', 'ERSUC', 'ERSUS', 'PEPA'))
						## first, add the broad scientific name
						# known.summ <- known.spdf@data %>% group_by(ScientificName) %>% summarize(occ_no=n())
						blm.summ <- all_blm %>% group_by(SppCode) %>% summarize(occ_no=n())
							unique(blm.summ$SppCode)
						u.nms <- uids %>% select(SppCode, ScientificName) %>% unique()

						blm.summ$ScientificName <- u.nms$ScientificName[match(blm.summ$SppCode, u.nms$SppCode)]
							unique(blm.summ$ScientificName)
							blm.summ[9,]
						blm.summ <- filter(blm.summ, SppCode %in% unique(uids$SppCode)) %>% select(SppCode, ScientificName, occ_no) %>%
																arrange(ScientificName)
								unique(blm.summ$ScientificName)
								write_xlsx(blm.summ, 'blm_by_species.xlsx')
			save(known.df, known.spdf, uids, mynames, all.eos, projxns, file='BLM_data.RData')

########################################################################################################################################################
rm(list=ls())
load('BLM_data.RData')

	my.packages <- c('readxl', 'tidyr', 'writexl', 'dplyr') #'rgdal', 'raster'
	lapply(my.packages, require, character.only=TRUE); rm(my.packages)

## next, remove those points outside the area

	
	
	
	
	########### trial area
# 	
# 	deg.nad83 <- all.eos %>% filter(CoordinateSystem == 'longlat' & Datum == 'NAD83' | 
# 																												 	is.na(CoordinateSystem) & Datum == 'NAD83' & x_coord < 0 & abs(x_coord) < 180)
# deg.nad83$DataSource
# other.not <- deg.nad83 %>% filter(DataSource %in% not.yet$DataSource)
epsg <- make_EPSG()
write_xlsx(epsg, 'EPSG_list.xlsx')
