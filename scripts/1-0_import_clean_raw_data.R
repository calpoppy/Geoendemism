########################################################################################################################

#1-0_import_clean_raw_data.R
### Authors: Shannon Still & Jiahua Guo ### Date: 11/03/2020

### DESCRIPTION:

########################################################################################################################
########################################################################################################################
########################################################################################################################
## import, clean, merge and sort CCH data
##		from both Baldwin dataset and all CCH dataset
########################################################################################################################
rm(list=ls())
getwd()
	# my.packages <- c('dplyr')
	my.packages <- c('tidyr', 'dplyr', 'data.table', 'readr') #'rgdal', 'raster', 'writexl'
	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
#install.packages (my.packages) #Turn on to install current versions
	lapply(my.packages, require, character.only=TRUE); rm(my.packages)
#
## bring in CCH data
cch.ge <- read.delim('data_in/EO_data/Still_CCH_out_edit.txt', sep='\t', header=TRUE, as.is=TRUE, quote='', strip.white=TRUE, skipNul=TRUE) 
# cch.ge2 <- read.delim('data_in/NoNull.txt', sep='\t', header=TRUE, as.is=TRUE, quote='', strip.white=TRUE) #

# save(cch.ge, file='data_in/EO_data/GeoEndemism_raw.RData')
########################################################################################################################
# 	my.packages <- c('tidyr', 'dplyr', 'data.table', 'readr') #'rgdal', 'raster', 'writexl'
# 	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
# #install.packages (my.packages) #Turn on to install current versions
# 	lapply(my.packages, require, character.only=TRUE); rm(my.packages)
#
# 	## load the geoendemism data
# 		load('data_in/EO_data/GeoEndemism_raw.RData')
names(cch.ge)
## rename a couple of the fields
	## Here are the default fields names
		## id	scientificName	collectors	collector_number	early_date	late_date	verbatim_date	county	elevation	locality	latitude	longitude	georeference_source	error_radius	error_radius_units	TRS	yellow_flag	habitat	associates	population biology	macromorphology	other data	notes	color	license_rights
	## These are the names of the fields that we want to concatenate for searching for edaphic conditions
			## habitat	associates	population_biology	macromorphology	other_data	notes
cch.ge <- cch.ge %>% rename(UID=id, population_biology=population.biology, other_data=other.data)
# names(cch.ge) <- c('UID', '')

## make one field with all of the possible habitat fields concatenated
		# cch.ge <- trimws(cch.ge, which='both')
cch.ge <- cch.ge %>% mutate(habitat_all = paste0('[BEGIN LOCALITY] ', locality, ' [END LOCALITY]; ', '[BEGIN HABITAT] ', habitat, ' [END HABITAT]; ', '[BEGIN ASSOCIATES] ', associates, ' [END ASSOCIATES]; ', '[BEGIN POPULATION BIOLOGY] ', population_biology, ' [END POPULATION BIOLOGY]; ', '[BEGIN MACROMORPHOLOGY] ', macromorphology, ' [END MACROMORPHOLOGY]; ', '[BEGIN OTHER DATA] ', other_data, ' [END OTHER DATA]; ', '[BEGIN NOTES] ', notes, ' [END NOTES]'))
	## strip out extra white space
		cch.ge$habitat_all <- trimws(cch.ge$habitat_all, which='both')
		cch.ge$habitat_all <- gsub('  ', '', cch.ge$habitat_all)

	## save the data to an RData object for easier retrieval
			save(cch.ge, file='data_in/EO_data/GeoEndemism_raw.RData')
	## remove all objects from the Environment
	rm(list=ls())
########################################################################################################################
# 	my.packages <- c('tidyr', 'dplyr', 'data.table', 'readr') #'rgdal', 'raster', 'writexl'
# 	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
# #install.packages (my.packages) #Turn on to install current versions
# 	lapply(my.packages, require, character.only=TRUE); rm(my.packages)
# 
# 	## load the Baldwin and other CCH data
# 		load('data_in/EO_data/CCH_raw.RData')
# 			names(cch.bl)
# 			#  [1] "X"                        "id"                       "institution_code"
# 			#  [4] "star"                     "flag"                     "scientificName"
# 			#  [7] "collectors"               "collectors_parsed"        "collector_number_prefix"
# 			# [10] "collector_number"         "collector_number_suffix"  "early_julian_day"
# 			# [13] "late_julian_day"          "verbatim_date"            "county"
# 			# [16] "elevation"                "locality"                 "locality_parsed"
# 			# [19] "geocoded"                 "longitude"                "latitude"
# 			# [22] "datum"                    "georeference_source"      "township_range_section"
# 			# [25] "error_radius"             "error_radius_units"       "current_name"
# 			# [28] "current_name_binomial"    "current_genus"            "current_species"
# 			# [31] "clade"                    "dataset"                  "cloned_geocode"
# 			# [34] "jepson_flag"              "flagged_record_corrected" "maxent_index"
# 			# [37] "naturalised"              "cultivated"               "possible_mislabel"
# 			# [40] "exclude_species"          "jepson_flag_october"      "new_flag"
# 			# [43] "exclude_clade"            "x_epsg_3310"              "y_epsg_3310"
# 
# 	## reload the CCH data to the Environment
# 		load('data_in/EO_data/GeoEndemism_raw.RData')
# 			names(cch.ge)
# 			#  [1] "id"                  "scientificName"      "collectors"          "collector_number"
# 			#  [5] "early_date"          "late_date"           "verbatim_date"       "county"
# 			#  [9] "elevation"           "locality"            "latitude"            "longitude"
# 			# [13] "georeference_source" "error_radius"        "error_radius_units"  "TRS"
# 			# [17] "yellow_flag"         "habitat"             "associates"          "population_biology"
# 			# [21] "macromorphology"     "other_data"          "notes"               "color"
# 			# [25] "license_rights"      "habitat_all"
# 
# 			## duplicate names between dataframes
# 			#  [1] "id"                  "scientificName"      "collectors"          "collector_number"    "verbatim_date"       "county"
# 			#  [7] "elevation"           "locality"            "longitude"           "latitude"            "georeference_source" "error_radius"
# 			# [13] "error_radius_units"
# 			## remove some of the columns from the cch.ge dataset that are duplicated
# 				length(unique(cch.bl$id))
# 				na.cch.bl <- cch.bl %>% filter(duplicated(id))
# 					# write_excel_csv(na.cch.bl, 'duplicate_missing_id.csv')
# 				na.cch.bl2 <- cch.bl %>% filter(id %in% na.cch.bl$id)
# 					write_excel_csv(na.cch.bl2, 'duplicate_missing_id.csv')
# 					## someone needs to search through the duplicated records and determine what is correct...or fix what is wrong
# 			cch.bl <- cch.bl %>% mutate(UID=id, x_coord=x_epsg_3310, y_coord=y_epsg_3310)
# 			cch.ge <- cch.ge %>% mutate(UID=id, township_range_section=TRS)
# 		# cch.ge$UID <- gsub('†', '', cch.ge$UID)
# 		cch.ge$UID <- gsub('\xa0', '', cch.ge$UID)
# 					## save the files with equal names
# 		# 				save(cch.bl, cch.ge, file='CCH_data.RData')
# 		# funny.id <- cch.ge[grepl('<a0>', cch.ge$UID),]
# 
# 			cch.bl <- cch.bl %>% select(-X) %>% filter(!id %in% na.cch.bl2$id)
# 			# length(unique(cch.ge$id))
# 
# 		## merge the two datasets
# 							nm.match <- names(cch.bl)[names(cch.bl) %in% names(cch.ge)]
# 				cch_all <- full_join(cch.bl, cch.ge, by=nm.match)
# 
# # 		## remove some fields
# #  				cch_all <- cch_all %>% select(-verbatim_date, -yellow_flag, -color, -license_rights)
# 		## remove when naturalized, when possible mislabel, cultivated
# 
# 						save(cch_all, cch.bl, cch.ge, file='CCH_data.RData')
# 							write_excel_csv(cch_all, 'all_records_out.csv')
# 						# no.cch <- cch.bl %>% filter(!UID %in% cch_all$UID)
# 						# no.cch2 <- cch.ge %>% filter(!UID %in% cch_all$UID)
# 						# no.cch2$UID
# 				# write_excel_csv(cch_all, 'all_records_out.csv')
# 								# write_excel_csv(no.cch2, 'no_records_out.csv')
# 
# # rm(cch, cch.ge)
###################
########################################################################################################################
## search for edaphic endemism terms
##		from both Baldwin dataset and all CCH dataset
########################################################################################################################
	# my.packages <- c('tidyr', 'dplyr', 'data.table', 'readr', 'readxl', 'writexl') #'rgdal', 'raster', 'writexl'
	# # my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
	# 		#install.packages (my.packages) #Turn on to install current versions
	# lapply(my.packages, require, character.only=TRUE); rm(my.packages)
	# 
	# ## load the data
# 		load('data_in/EO_data/GeoEndemism_raw.RData')
# 		# load('CCH_data.RData')
# 								# rm(cch.bl, cch.ge)
# 								# cch <- cch_all %>% filter(!is.na(habitat_all))
# 		##		bring in list of terms
# 							ge.terms <- read_excel('data_in/terms_data/EdaphicRestrictions_terms.xlsx', sheet='categories')
# 									# names(ge.terms)
# 							ge.terms <- ge.terms %>% rename(term=efloraSearch)
# 								# length(ge.terms$term)
# 							
# occs <- as.data.frame(matrix(nrow=length(cch.ge$UID), ncol=length(ge.terms$term)+1))
# 	g.terms <- ge.terms$term
# 	names(occs) <- c('UID', gsub(' ', '_', g.terms))
# 
# cch.g <- cch.ge %>% select(UID, habitat_all)
# habs <- as.character(cch.g$habitat_all)
# 	occs[, 1] <- cch.g$UID
# 
########################################################################################################################
# 	# cch.r <- sample_n(cch.g, 1000, replace=FALSE)
# 	# 	habs <- as.character(cch.r$habitat_all)
# 	# 		# tail(cch.r); tail(habs)
# # occs1 <- occs
# # occs <- occs1[,c(1, 22:83)]
# # occs <- occs1[,c(1, 22:83)]
# 
# 		# occs <- occs[,c(1, 81:length(g.terms)+1)]
# # names(occs)
# 
# find_term <- function(h, t=g.t){
# 					d <- unlist(lapply(strsplit(h, ' '), '[', ))
# 					e <- d[grepl(t, d, fixed=FALSE, ignore.case=TRUE)]
# 					return(paste(e, collapse='; '))
# }
# # j <- 21
# for (j in 21:82){
# 		g.t <- g.terms[j] ## subset to the geoendemism term list to iterate though
# 		cat('\n########################\nStarted iteration for', j, ':', g.t, '\n########################\n')
# 					occ.t <- apply(cch.g, 1, find_term, t=g.t)
# 			occs[, j+1] <- occ.t
# 			occ.j <- as.data.frame(cbind(cch.g$UID, occ.t))
# 			names(occ.j) <- c('UID', gsub(' ', '_', g.t))
# 			occ.v <- occ.j %>% filter((!!as.name(gsub(' ', '_', g.t))) != '')
# 				write_excel_csv(occ.v, paste0('data_out/term_subfolder/cch_geoend_subdata-', g.t, '.csv'))
# 		cat('\n########################\nEnded iteration for', g.t, '\n########################\n########################\n\n')
# 			rm(occ.j, occ.t, occ.v)
# 	}
# # # save(occs, 'cch_full_data.RData')
# # # write_excel_csv(occs, 'cch_geoend_data_part1.csv')
# # # write_excel_csv(occs, 'cch_geoend_data_part2.csv')
# # names(occs[,c(1, 22:83)])
# occs <- occs[,c(1, 22:83)]
# write_excel_csv(occs, 'cch_geoend_data_part3.csv')
# # # head(occs)
# # # cch.dat <- full_join(cch.ge, occs, by=UID)
# # # write_excel_csv(cch.dat, 'full_cch_data.csv')
# 
# 
########################################################################################################################
# # occs <- read_csv('cch_geoend_data_part2.csv')
# # occs1 <- occs
# # occs <- occs[,c(1, 81:length(g.terms)+1)]
# 	names(occs)
# 	head(occs)
# 
# # g.terms[81]
# # 21:81 ## the last set of values
# c.terms <- gsub(' ', '_', g.terms)
# # c.terms <- c.terms[1:21]; c.terms
# # c.terms <- c.terms[82:126]; c.terms
# c.terms <- c.terms[21:82]; c.terms
# # c <- 1
# 
# for(c in 1:length(c.terms)){
# 	c.term <- c.terms[c]
# occ.v <- occs %>% select(UID, c.term) %>% filter((!!as.name(c.term)) != '')
# 	# head(occ.v)
# names(occ.v)[2] <- paste0('geovar-', c.term)
# 	
# v.set <- left_join(occ.v, cch.ge, by='UID') %>% arrange(scientificName, UID, county) 
# v.set <- v.set %>% select(UID:scientificName, locality, habitat, associates, population_biology, macromorphology, other_data, notes, everything()) %>% select(-habitat_all)# 
# write_excel_csv(v.set, file.path('data_out/term_files', paste0('cch_geodat_', c.term, '.csv')))
# }	
# head(occs)
# 
##########################################################################################
	my.packages <- c('tidyr', 'dplyr', 'data.table', 'readr', 'readxl', 'writexl') #'rgdal', 'raster', 'writexl'
	# my.packages <- c('raster', 'readxl', 'rgdal', 'dplyr', 'writexl')
			#install.packages (my.packages) #Turn on to install current versions
	lapply(my.packages, require, character.only=TRUE); rm(my.packages)
	
		# load('geoendimism_data.RData')
							ge.terms <- read_excel('data_in/terms_data/EdaphicRestrictions_terms.xlsx', sheet='categories')
									# names(ge.terms)
							ge.terms <- ge.terms %>% rename(term=specific_term)
occs1 <- read_csv('cch_geoend_data_part1.csv')
# occs2 <- read_csv('cch_geoend_data_part2.csv')
# occs3 <- read_csv('cch_geoend_data_part3.csv')
# 
# names(occs1)
# names(occs2)
# names(occs3)
# occs1 <- occs1 %>% select(-chalk)
# occs2 <- occs2 %>% select(-pyroxenite, -pyroxene)
# g.occs <- full_join(occs1,  occs3, by='UID')
# g.occs <- full_join(g.occs, occs2, by='UID') %>% select(-alluvial.1, -clay.1, -sand.1, -salt.1)
# 			names(g.occs)
# 		save(g.occs, file='geoendimism_data.RData')
# names(g.occs[,-1])

## try to extract and print unique field names/terms for each of the terms from the dataset
	## remove NAs
		uterms <- lapply(occs1[,-1], unique)
		uterms <- lapply(uterms, function(x) x[!is.na(x)])
			# lapply(list, function(x) { x[is.na(x)] <- 0; return(x) })
	## create a table of all term values
		t <- 'caliche'
		utty <- unlist(uterms)
		uterm <- uterms[19]
 for(t in uterms){
 				uterms[t]
				df <- cbind(names(t), as.data.frame(unlist(t)))
				names(df) <- c('term', 't_value')
				return(df)			
		}
				
		
		df <- as.data.frame(uterms)
		
		class(uterms[19])
		uterms$caliche
		# uterms <- 
			!is.na(uterms[19])
				!is.na(uterms)][19]
			
		uterms[20]
		uterms <- lapply(uterms)
		
# for (j in 1:length(g.terms)){
# 		g.t <- g.terms[j] ## subset to the geoendemism term list to iterate though
# 			for (i in 1:length(habs)){
# 					a <- habs[i]
# 					d <- unlist(lapply(strsplit(a, ' '), '[', ))
# 					# e <- d[grepl('sepent', d, fixed=FALSE, ignore.case=TRUE)]; e
# 					e <- d[grepl(g.t, d, fixed=FALSE, ignore.case=TRUE)]
# 					occ.t <- apply(cch.r, 1, find_term, t=g.t)
# 
# 			occs[i, j+1] <- paste(e, collapse='; ')
# 	# 	  if(length(e) == 0){
# 	# occs[i, j+1] <- 'geo-endemism not reported'
# 	# 	  } else 	occs[i, j+1] <- paste(e, collapse='; ')
# 	}
# 
# }
# system.time(	
# )	
# 	
# 	# yes.serp <- occs[, j != '']
# for (j in 1:length(g.terms)){
# 		g.t <- g.terms[j] ## subset to the 
# 	for (i in 1:length(habs)){
# 		a <- habs[i]
# 		d <- unlist(lapply(strsplit(a, ' '), '[', ))
# 		# e <- d[grepl('sepent', d, fixed=FALSE, ignore.case=TRUE)]; e
# 		e <- d[grepl(g.t, d, fixed=FALSE, ignore.case=TRUE)]
# 	ee <- paste(e, collapse='; ')
# 	}
# 	occs[, j] <- ee
# }
# 

# ## save the data out
# 						save(cch, cch.bl, cch.ge, file='CCH_data.RData')
# ## write the data to Excel
# 				write_excel_csv(cch, 'all_records_out.csv')

########################################################################################################################

				
		 # unlink('data_in/EO_data/CCH_data.RData')
# load('geoset.RData')
		