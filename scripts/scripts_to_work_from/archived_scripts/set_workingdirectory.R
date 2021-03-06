## set_workingdirectory.R

## set the working environment for the computer on which you are working.
	## here we are just setting the working directoary and maybe an output folder. But we could also add links specific to operating systems or other computers.
			## for instance, we could set the data folder to change depending on the location relative to this working directory.

####################################################################################################
##set the working environment depending on the computer on which working
####################################################################################################
## first is for Elizabeth Tokarz
  if (Sys.info()[4] == "MIA_ATLANTICA") { 
  	## if you want to set the absolute path within your computer, use the following command:
     setwd("/some/filepath/set/by/elizabeth/pointing/to/her/directory"); print(getwd())
  	
  	## if you want to set other directories, such as file output folders and such, then you can add them here:
  			## for instance, the output folder (defined by object 'f_out') would be set as 'SDM_output' and this would then typically be 
  					## a subfolder to the main working directory
      f_out <- "SDM_output"
      
      data_in <- "/main/data/directory/or/folder"

      ## this last command simply prints to the console the working directory that you have set. It's just to let you know that you're in the right spot.
		    print(paste0("Working from Elizabeth Tokarz's nice machine with the lovely name ", Sys.info()[4],"."))
		    
  } else if (Sys.info()[4] == "Still-MBPro.local") { 
## next is for Shannon Still
  	## if you want to set the absolute path within your computer, use the following command:
     setwd("/Users/sstill/Box/Research/Active_Projects/MortonArb_SDM/Tree_Distribution_Database"); print(getwd())
  	
  	## if you want to set other directories, such as file output folders and such, then you can add them here:
  			## for instance, the output folder (defined by object 'f_out') would be set as 'SDM_output' and this would then typically be 
  					## a subfolder to the main working directory
      f_out <- "SDM_output"
      data_in <- "/Users/sstill/Box/Research/Active_Projects/MortonArb_SDM"

      ## this last command simply prints to the console the working directory that you have set. It's just to let you know that you're in the right spot.
		    print(paste0("Working from Shannon Still's MacBook Pro ", Sys.info()[4],"."))
		} else if (Sys.info()[4] == "Beckman_computer") { 
## next is for Emily Beckman
  	## if you want to set the absolute path within your computer, use the following command:
     setwd("/some/filepath/set/by/emily/pointing/to/her/directory"); print(getwd())
  	
  	## if you want to set other directories, such as file output folders and such, then you can add them here:
  			## for instance, the output folder (defined by object 'f_out') would be set as 'SDM_output' and this would then typically be 
  					## a subfolder to the main working directory
      f_out <- "SDM_output"
      data_in <- "/main/data/directory/or/folder"

      ## this last command simply prints to the console the working directory that you have set. It's just to let you know that you're in the right spot.
		    print(paste0("Working from Emily Beckman's nice computer with a lovely name ", Sys.info()[4],"."))
		} else {
## last is the default which sets the working driectory as the folder from which you opened the scripts/project
  setwd(getwd()) 
  f_out <- "SDM_output"
  #   pypath <- "/Library/Frameworks/GDAL.framework/Versions/current/Programs/gdal_polygonize.py"
}

###
##Elizabeth Tokarz Sys.info ()
 #        sysname         release         version        nodename         machine           login            user 
 #      "Windows"      ">= 8 x64"    "build 9200" "MIA_ATLANTICA"        "x86-64"     "Elizabeth"     "Elizabeth" 
 # effective_user 
 #    "Elizabeth"

## shannon Still Sys.info()
#                                                                                           sysname 
#                                                                                          "Darwin" 
#                                                                                           release 
#                                                                                          "17.4.0" 
#                                                                                           version 
# "Darwin Kernel Version 17.4.0: Sun Dec 17 09:19:54 PST 2017; root:xnu-4570.41.2~1/RELEASE_X86_64" 
#                                                                                          nodename 
#                                                                               "Still-MBPro.local" 
#                                                                                           machine 
#                                                                                          "x86_64" 
#                                                                                             login 
#                                                                                          "sstill" 
#                                                                                              user 
#                                                                                          "sstill" 
#                                                                                    effective_user 
#                                                                                          "sstill" 


