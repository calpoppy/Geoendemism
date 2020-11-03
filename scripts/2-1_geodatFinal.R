##########################################################################################
## import, clean CCH data
## from both Baldwin dataset and all CCH dataset
#########################################################################################
# rm(list=ls())
## set input, output and "EdaphicRestrictions_terms.csv" path, change if needed

if (Sys.info()[4] == "Jiahuas-MacBook-Pro.local") { 
  setwd("/Users/emma/Desktop/arboretum/Copper/")
  inputPath <- 'Input_Files'
  outputPath <- 'Output_Files'
  blPath <- 'EdaphicRestrictions_terms.csv'
  
} else if (Sys.info()[4] == "Still-MBPro.local") { 
  setwd("/GeoEndemismR/")
  inputPath <- 'data_out/term_files'
  outputPath <- 'Output_Files'
  blPath <- 'data_in/terms_data/EdaphicRestrictions_terms.csv'
  } else if (Sys.info()[4] == "Still-MB-Pro-15.local") {
  	setwd("/GeoEndemismR/")
  	inputPath <- 'data_out/term_files'
  	outputPath <- 'Output_Files'
  	outputNew <- 'OutputNew'
  	  # blPath <- 'data_in/terms_data/EdaphicRestrictions_terms.csv'
  }
  

filesList <- list.files(inputPath) ## get all the filenames in the input folder
filesList ## print all the filenames in the input folder

wordList <- unlist(lapply(filesList, function(x) gsub('.csv', '', strsplit(x, '_')[[1]][3]))) ## get the wordlist

tFileLen <- length(filesList) ## get the filesList's length

a <- 'chalk'

wordList
## run through all the files
for(a in wordList) {
  
  #wordList[2] ## return "chalk"
  writeFileName <- "Output.csv" 
  ## declare the output_file name
  writeFileName <- paste(a, writeFileName, sep = "_")
  writeFileName <- paste(outputPath,writeFileName, sep = "/")
  ## read the input file for specific word

  theFileName <- file.path(inputPath, paste0('cch_geodat_',a, '.csv'))
 
  theFile <-read.csv2(file = theFileName, header = TRUE, sep = ",")
  ## read "EdaphicRestrictions_terms.csv"
  blFile <- read.csv2(file = blPath, header = TRUE, sep = ",") 
  
  library(dplyr)

  ## get the black list of the key word
  tempBlack <- blFile %>%
    filter(specific_term == a) %>%
    select(vars_black_list)
  
  tempBlack <- sapply(tempBlack, as.character)
  if (grepl(",", tempBlack) == TRUE) {
    blackList <- unlist(strsplit(tempBlack, ","))
  } else
    blackList <- tempBlack
  blackList <- trimws(blackList, which = c("both"))
 
  blackList
  blackLen <- length(blackList)
  blackLen
  
  
  blackListDF <- theFile
 
  # apply loop
  for(i in 1:blackLen) {
    
    tempDF <- blackListDF %>%
      select(geovar.chalk:notes)
    #tempDF <- filter(tempDF, !grepl(blackList[i], tempDF))
    tempDF[with(tempDF, grepl(blackList[i], c(tempDF))),]
    
   # blackListDF <- filter(blackListDF, !grepl(blackList[i], tempDF))
    blackListDF <- select(blackListDF, !tempDF)
                          
  } #search through blackList
  
  write.csv(blackListDF, writeFileName)
  
  #close(theFile)
  closeAllConnections() 
} # big for loop



