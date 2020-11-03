########################################################################################################################

#1-1_make_output_files.R
### Authors: Shannon Still & Jiahua Guo ### Date: 11/03/2020

### DESCRIPTION:

########################################################################################################################
# Set working environment depending on your computer
########################################################################################################################

##########################################################################################
## import, clean CCH data
## from both Baldwin dataset and all CCH dataset
#########################################################################################
# rm(list=ls())
## set input, output and "EdaphicRestrictions_terms.csv" path, change if needed

# if (Sys.info()[4] == "Jiahuas-MacBook-Pro.local") { 
#   # setwd("/Users/emma/Desktop/arboretum/Copper/")
#   # inputPath <- 'Input_Files'
#   # outputPath <- 'Output_Files'
#   # outputNew <- 'OutputNew'
#   # blPath <- 'EdaphicRestrictions_terms.csv'
# 	#setwd("/Users/emma/Box/GeoEndemismR/")
# 	inputPath <- '/Users/emma/Box/GeoEndemismR/data_out/term_files/'
# 	outputPath <- '/Users/emma/Box/GeoEndemismR/data_out/Output_Files/'
# 	outputNew <- '/Users/emma/Box/GeoEndemismR/data_out/terms_step2/'
# 	binaryPath <- '/Users/emma/Box/GeoEndemismR/data_out/group_by_primaryTerm/'
# 	blPath <- '/Users/emma/Box/GeoEndemismR/data_in/terms_data/EdaphicRestrictions_terms.csv'
# 	
#   
# } else if (Sys.info()[4] == "Still-MBPro.local") { 
#   setwd("/GeoEndemismR/")
#   inputPath <- 'data_out/term_files'
#   outputPath <- 'Output_Files'
#   outputNew <- 'OutputNew'
# #  blPath <- 'data_in/terms_data/EdaphicRestrictions_terms.csv'
# } else if (Sys.info()[4] == "Still-MB-Pro-15.local") { 
# 	setwd("/GeoEndemismR/")
# 	inputPath <- 'data_out/term_files'
# 	outputPath <- 'Output_Files'
# 	outputNew <- 'OutputNew'
# 	#  blPath <- 'data_in/terms_data/EdaphicRestrictions_terms.csv'
# }
getwd()
# setwd("/GeoEndemismR/")
inputPath <- 'data_out/term_files'
outputPath <- 'Output_Files'
outputNew <- 'OutputNew'
list.files()

filesList <- list.files(inputPath) ## get all the filenames in the input folder
filesList ## print all the filenames in the input folder

wordList <- unlist(lapply(filesList, function(x) gsub('.csv', '', strsplit(x, '_')[[1]][3]))) ## get the wordlist

tFileLen <- length(filesList) ## get the filesList's length

## create empty dataframe
# theFile <- read.csv2(file = theFileName, header = TRUE, sep = ",")

#  theFileName <- file.path(inputPath, paste0('cch_geodat_',a, '.csv'))
mainWriteName <- file.path('/Users/emma/Box/GeoEndemismR/data_out/terms_step2', "emptyMain.csv")
mainDF <- read.csv2(file = mainWriteName, header = TRUE, sep = ",")
mainDF <- as.data.frame(mainDF,  stringsAsFactors = FALSE)


geovarWriteName <- file.path('/Users/emma/Box/GeoEndemismR/data_out/terms_step2', "emptyGeovar.csv")
geovarDF <- read.csv2(file = geovarWriteName, header = TRUE, sep = ",")
geovarDF <- as.data.frame(geovarDF,  stringsAsFactors = FALSE)

wordList
## run through all the files
for(a in wordList) {
  
  #wordList[2] ## return "chalk"
  AddOnName <- "Output.csv" 
  ## declare the output_file name
  writeFileName1 <- paste(a, AddOnName, sep = "_")
  writeFileName1 <- paste(outputPath, writeFileName1, sep = "/")
  
  writeFileName2 <- paste(a, AddOnName, sep = "_")
  writeFileName2 <- paste('/Users/emma/Box/GeoEndemismR/data_out/terms_step2', writeFileName2, sep = "/")
  

  
  ## read the input file for specific word

  theFileName <- file.path(inputPath, paste0('cch_geodat_',a, '.csv'))
 
  theFile <-read.csv2(file = theFileName, header = TRUE, sep = ",")
  ## read "EdaphicRestrictions_terms.csv"
  blFile <- read.csv2(file = blPath, header = TRUE, sep = ",") 
  blFile <- read.csv2(file = '/Users/emma/Box/GeoEndemismR/data_in/terms_data/EdaphicRestrictions_terms.csv', header = TRUE, sep = ",") 
  
  
  library(dplyr)
  library(stringr)

  library(data.table)
  ## get the black list of the key word

  tempBlack <- blFile %>%
  	filter(secondary_term == a) %>%
  	select(vars_black_list)
  
  tempBlack <- sapply(tempBlack, as.character)
  
  if (grepl(",", tempBlack) == TRUE) {
    blackList <- unlist(strsplit(tempBlack, ","))
  } else
    blackList <- tempBlack
 
  blackList <- trimws(blackList, which = c("both"))
  blackLen <- length(blackList)

  
  blackListDF <- theFile
 
  blackListDF <- sapply(blackListDF, as.character)
  blackListDF <- as.data.frame(blackListDF)
  
  ## check if 'a' has a primary term
  primaryTerm <- blFile %>%
    filter(secondary_term == a) %>%
    select(primary_term)
  
  if (grepl(",", primaryTerm) == TRUE) {
    primaryList <- unlist(strsplit(primaryTerm, ","))
  } else {
    primaryList <- primaryTerm
  }
  
  #HEREif (is.empty()
  
#  i <- 1
  # apply loop
  tempDF <- blackListDF
  
  for(i in 1:blackLen) {
    names(tempDF)[2] <- 'geovar'
    # tempDF <- blackListDF %>%
    #   select(geovar.chalk:notes)
    tempDF <- lapply(tempDF, function(x) gsub(blackList[i],"", x))
    tempDF <- sapply(tempDF, as.character)
    tempDF <- as.data.frame(tempDF)
    tempDF$geovar <- gsub("[,.-;\"]", " ", tempDF$geovar)
    tempDF$geovar <- gsub("  ", "; ", tempDF$geovar)
   
    ## maybe cleanup white space later
      # tempDF$geovar[which(tempDF$geovar == ' ')] <- NA
      # tempDF$geovar <- trimws(tempDF$geovar, which = c("both"))
    
    CleanDF <- subset(tempDF, grepl(a, geovar, ignore.case = TRUE))
    TempUID <- CleanDF$UID
    CleanDF <- subset(CleanDF, UID %in% blackListDF$UID)

    CleanDF$geovar <- gsub("[(),.-;\"]", " ", CleanDF$geovar)
    CleanDF$geovar <- gsub("  ", "; ", CleanDF$geovar)
    
    CleanDF$secondary_term <- a
    #geovec <- rep(a, nrow(df))

    
  } #search through blackList
  
  ##group_by primary_term
  if (length(primaryList) > 0) {
    priTempDF <- rbind(CleanDF, mainDF, row.names = FALSE)
    priTempDF <- as.data.frame(priTempDF,  stringsAsFactors = FALSE)
    
    for (b in primaryList) {
    
      pri_AddOnName <- "Output.csv" 
      ## declare the output_file name
      pri_writeFileName2 <- paste(b, pri_AddOnName, sep = "_")
      pri_writeFileName3 <- paste('/Users/emma/Box/GeoEndemismR/data_out/group_by_primaryTerm', pri_writeFileName2, sep = "/")
    
      if(file.exists(pri_writeFileName3)) {
        write.table(priTempDF, pri_writeFileName3, sep = ",", col.names = T, append = T)
      } else {
        write.table(priTempDF, pri_writeFileName3, sep = ",", row.names = FALSE)
      }
      CleanDF$primary_term <- b
    } #for loop
  } # if


  termDF <- CleanDF %>% select(UID, geovar, secondary_term)
 
  geovarDFtmp <- rbind(termDF, geovarDF, row.names = FALSE)
  geovarDF <- geovarDFtmp
  mainDFtmp <- rbind(CleanDF, mainDF, row.names = FALSE)
  mainDF <- mainDFtmp
  
  write.csv(tempDF, writeFileName1, row.names = FALSE)
  write.csv(CleanDF, writeFileName2, row.names = FALSE)
  
  #close(theFile)
  closeAllConnections() 
} # big for loop

#temp3 <- unique(temp3[,list(V1, V2)])

write.csv(geovarDF, '/Users/emma/Box/GeoEndemismR/data_out/geovarDF.csv', row.names = FALSE)
write.csv(mainDF, '/Users/emma/Box/GeoEndemismR/data_out/mainDF.csv', row.names = FALSE)


# MERGE

## summarize the term_n
summary1 <- mainDF %>%
	group_by(scientificName, secondary_term) %>%
	dplyr::summarize(term_n = n()) 

## summarize the n_total
geoset <- get(load("/Users/emma/Box/GeoEndemismR/geoset.RData"))
geosetSum1 <- geoset %>%
	group_by(scientificName) %>%
	dplyr::summarize(n_all = n())

geosetSum1 <- as.data.frame(geosetSum,  stringsAsFactors = FALSE)

summary1 <- merge(summary1, geosetSum, all.x = TRUE)
summary1 <- transform(summary1, all_percent = term_n / n_all * 100)
summary1 <- summary1 %>%
	arrange(scientificName)

#mainDF <- mainDF 
#	arrange(scientificName)
write.csv(summary1, '/Users/emma/Box/GeoEndemismR/data_out/terms_step2/secondary_term_summary_#9.20.csv', row.names = FALSE)
 
summary2 <- mainDF %>%
  group_by(scientificName, primary_term) %>%
  dplyr::summarize(term_n = n()) 

geosetSum2 <- geoset %>%
  group_by(scientificName) %>%
  dplyr::summarize(n_all = n())

geosetSum2 <- as.data.frame(geosetSum,  stringsAsFactors = FALSE)

summary2 <- merge(summary2, geosetSum, all.x = TRUE)
summary2 <- transform(summary2, all_percent = term_n / n_all * 100)
summary2 <- summary2 %>%
  arrange(primary_term)

#mainDF <- mainDF 
#	arrange(scientificName)
write.csv(summary2, '/Users/emma/Box/GeoEndemismR/data_out/terms_step2/primary_term_summary_#9.20.csv', row.names = FALSE)






  
  
  
  
  
