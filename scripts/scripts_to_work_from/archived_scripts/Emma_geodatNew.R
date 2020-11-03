##########################################################################################
## import, clean CCH data
## from both Baldwin dataset and all CCH dataset
#########################################################################################

## set input, output and "EdaphicRestrictions_terms.csv" path, change if needed
inputPath <- 'data_out/term_files'
# inputPath <- '/Users/emma/Desktop/Input_Files'
outputPath <- 'Output_Files'
# outputPath <- '/Users/emma/Desktop/Copper/Output_Files'
blPath <- 'data_in/terms_data/EdaphicRestrictions_terms.csv'
# blPath <- '/Users/emma/Desktop/Copper/EdaphicRestrictions_terms.csv'
directory <- file.path(inputPath)

filesList <- list.files(directory) ## get all the filenames in the input folder
filesList ## print all the filenames in the input folder

tFileLen <- length(filesList) ## get the filesList's length
tFileLen 

## run through all the files
for(a in 1:tFileLen) {

  wordList <- unlist(lapply(filesList, function(x) gsub('.csv', '', strsplit(x, '_')[[1]][3]))) ## get the wordlist
  #wordList[2] ## return "chalk"
  writeFileName <- "Output.csv"
  ## declare the output_file name
  writeFileName <- paste(wordList[a], writeFileName, sep = "_")
  ## read the input file for specific word
  theFile <-file(file.path(inputPath, filesList[a]), "r")
  ## read "EdaphicRestrictions_terms.csv"
  blFile <- read.csv2(file = blPath, header = TRUE, sep = ",") 

  ## get the white list of the key word
  tempWhite <- subset(blFile, efloraSearch == wordList[a], select = c(vars_white_list))
  tempWhite <- sapply(tempWhite, as.character)
  if (grepl(",", tempWhite) == TRUE) {
  	whiteList <- unlist(strsplit(tempWhite, ","))
  } else
      whiteList <- tempWhite
  whiteLen <- length(whiteList)
  
  ## get the black list of the key word
  tempBlack <- subset(blFile, efloraSearch == wordList[a], select = c(vars_black_list))
  tempBlack <- sapply(tempBlack, as.character)
  if (grepl(",", tempBlack) == TRUE) {
  	blackList <- unlist(strsplit(tempBlack, ","))
  } else
  	blackList <- tempBlack
  #blackList <- unlist(strsplit(tempBlack, ","))
  blackList
  blackLen <- length(blackList)
  blackLen
 
  ## add a header to the output file
  line = readLines(theFile, n = 1)
  text = c(line)
  #t.list = strsplit(text, ",")
  
  if (blackLen != 0 && whiteLen != 0) {
  #if (blackLen != 0) { ## use this one if some search_words have black_list only
    fileConn <- file(file.path(outputPath, writeFileName), "w")
    
    ## compare the search_word with words in white list and black list
    while(length(line) != 0) {
   # while(TRUE) {
      
      if (length(line) == 0 ) {
        break
      }
      
      flag = FALSE
      text = c(line)
      
      if (is.na(text) || text == "" || grepl(",", text) == FALSE) {
        t.list <- text
      } else
        t.list = strsplit(text, ",")
      
      part <- sapply(t.list, "[", 2)
      
     ## check whether the search_words match the words in black list
     for(i in 1:blackLen) {
        
        if((blackList[i] != "") && grepl(blackList[i], part) == TRUE) {
          flag = TRUE
          #doubleCheck <- blackList[i]
        } #if
        
      } #for
      
      if (flag == TRUE) {
        part <- unlist(strsplit(part, ";"))
        partLen <- length(part)
    # if (flag == TRUE && whiteLen != 0) { ## use this one if some search_words have black_list only
        for (j in 1:whiteLen) {
          for (h in 1:partLen) {
            
            if (whiteList[j] == part[h]) {
              flag = FALSE
            } # if
            
          } # inner for
        } # outter for
      } #inner if
     
      ## append to the new .csv if the current row doesn't contain word(s) in black list
      if (flag == FALSE) {
        write(text, fileConn, append = TRUE)
        # cat(text, file = fileConn, append = TRUE, sep = "\n")
      } 
      
      ## get a new line
      line = readLines(theFile, n = 1)
      
    } # while loop
  } # big if
  
  
  #close(theFile)
  closeAllConnections() 
} # big for loop

  
  
