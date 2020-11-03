########################################################################################################################

#3-1_check_for_repeats.R
### Authors: Shannon Still & Jiahua Guo ### Date: 11/03/2020

### DESCRIPTION:

########################################################################################################################
# look for repeated vouchers by species and collector and collecting numbers, using fuzzy search terms.
########################################################################################################################

if (Sys.info()[4] == "Jiahuas-MacBook-Pro.local") { 
  inputPath <- '/Users/emma/Box/GeoEndemismR/data_out/terms_checkifRepeat'

} else if (Sys.info()[4] == "Still-MBPro.local") { 
  ##########
  ##### path needed
}

filesList <- list.files(inputPath) ## get all the filenames in the input folder
for (a in filesList) {
  
  theFile <- file.path(inputPath, paste0(a))
  theReadFile <- read.csv2(file = theFile, header = TRUE, sep = ",") 

  fileDF <- theReadFile
  fileDF <- sapply(fileDF, as.character)
  fileDF <- as.data.frame(fileDF)

  #library(dplyr)
  fileDF <- fileDF[with(fileDF, order(scientificName, collectors, collector_number, early_date, latitude)), ] 
  
  fileDF$checkRepeat <- 'U'
  
  for (row in 1:(nrow(fileDF)-1)) {
    
    if (fileDF[row, "scientificName"] == fileDF[row + 1, "scientificName"]) {
      temp <- fileDF[row, "collectors"]
      substr(temp, 1, 4)
      temp2 <- fileDF[row + 1, "collectors"]
      if (grepl(temp, temp2, ignore.case = TRUE)) {
        if (fileDF[row, "collector_number"] == fileDF[row + 1, "collector_number"]) {
          if (fileDF[row, "early_date"] == fileDF[row + 1, "early_date"]) {
            fileDF[row + 1, "checkRepeat"] <- 'D'
            if (fileDF[row, "checkRepeat"] != 'D') {
              fileDF[row, "checkRepeat"] <- 'O'
            }  ## change flag
          } 
            
        } ## check collector_number
      } ## check collectors
    } ## check scientificName
  }
    
  write.csv(fileDF, theFile, row.names = FALSE)
}
  