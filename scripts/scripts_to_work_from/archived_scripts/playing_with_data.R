
library(dplyr)

## load data set
	# load("CCH_data.RData")

## get a sample of the data
	g.samp <- sample_n(cch.ge, 100000, replace=FALSE)
## save the sample data
	save(g.samp, file="geo_sample.RData")
load("geo_sample.RData")

## Questions to answer
	## how to choose a random sample of the data
	## how many scientific names?
  head(g.samp)
  count(g.samp, scientificName)
  head(unique(g.samp$scientificName))
  head(distinct(g.samp)) # all
  sn <- length(unique(g.samp$scientificName)) 
  write(s, "sn.txt")
  sink("sn.txt")
  cat("number of taxa:", sn, "\n")
  cat("number of taxa:", sn)
  
  sink()
		## write out to a text file
	## how many families?
  length(unique(g.samp$county)) 
  names(g.samp)
  something <- g.samp %>%
  	group_by(scientificName, county) %>%
  	summarise(num_per_county = length(county)) %>%
    arrange(scientificName, county, desc(num_per_county)) %>%
    filter(num_per_county >= 2)
  head(something)
    write.csv(something, "scientifcCountySummary.csv")
  	#summarise(count = sum())
   # summarise(something = length(unique(scientificName)))
    something2 <- g.samp %>%
    	group_by(scientificName) %>%
    	summarise(occ_no = length(scientificName)) %>%
    	#arrange(-occ_no)
    	arrange(desc(occ_no)) %>%
      filter(occ_no == 1)
    write.csv(something2, "scientifcCountySummary.csv")
    head(something2)
    sample2 <- g.samp %>%
    	filter(scientificName %in% something2$scientificName)
    sample3 <- g.samp %>%
    	filter(!scientificName %in% something2$scientificName)
		## write out to a text file
	## total number of occurrences
		## write out to a text file
	## number of individuals per scientific name
		## make a .csv
	## number of individuals per family
		## make a .csv
	## get all specimens from each county in California
		## make a .csv
	
# rm(cch, cch.bl, cch.ge)
