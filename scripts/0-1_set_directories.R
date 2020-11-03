########################################################################################################################

#0-1_set_directories.R
### Authors: Shannon Still & Jiahua Guo ### Date: 11/03/2020

### DESCRIPTION:
# This script sets the working environment for the computer on which you are working.

########################################################################################################################
# Set working environment depending on your computer
########################################################################################################################

# Use this to check your "nodename"
# Sys.info()[4]

## For Shannon Still:
if (Sys.info()[4] == "Still-MB-Pro-15.local") {
  # set main working directory
  main_dir <- "/Volumes/GoogleDrive/Shared drives/Geoendemism_Project/GeoEndemismR"
  # set location of scripts
  script_dir <- "scripts"
  # OPTIONAL: set local working directory, for trialing locally before saving
  #   to main working directory
  local_dir <- "/Users/aesculus/Box/Research/Active_Projects/GeoEndemism/Geoendemism"

  # set location for login information (e.g., for GBIF)
  # log_loc <- file.path(local_dir, "gbif.txt")
  # prints computer name, to let you know you're in the right spot
  print(paste("Working from the lovely", Sys.info()[4]))

## For Jiahua Guo:
} else if (Sys.info()[4] == "XXX.local") {
  # set main working directory
  main_dir <- "/Volumes/GoogleDrive/Shared drives/IMLS MFA/occurrence_points"
  # set location of scripts
  script_dir <- "./Documents/GitHub/OccurrencePoints/scripts"
  # OPTIONAL: set local working directory, for trialing locally before saving
  #   to main working directory
  local_dir <- "./Desktop"
  # set location for login information (e.g., for GBIF)
  # log_loc <- file.path(local_dir, "IMLS_passwords.txt")
  # prints computer name, to let you know you're in the right spot
  print(paste("Working from the lovely", Sys.info()[4]))

## For Shannon workstation:
} else if (Sys.info()[4] == "CAES-SSTILL") {
  # set main working directory
  main_dir <- "G:/Geoendemism_Project/GeoEndemismR/occurrence_points"
  # set location of scripts
  script_dir <- "scripts"
  # OPTIONAL: set local working directory, for trialing locally before saving
  #   to main working directory
  local_dir <- "C:/Users/aesculus/Box/Research/Active_Projects/GeoEndemism/Geoendemism"
  # set location for login information (e.g., for GBIF)
  # log_loc <- file.path(local_dir, "gbif.txt")
  # prints computer name, to let you know you're in the right spot
  print(paste("Working from the lovely", Sys.info()[4]))

## can add as many additional "else if" sections as needed to cover other
#   workstations

 } # else {
#   # default, which sets the working driectory as the folder from which you
#   #   opened the scripts/project
#   setwd(getwd())
# }
