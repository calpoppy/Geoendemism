########################################################################################################################

#0-2_set_functions.R
### Authors: Shannon Still & Jiahua Guo ### Date: 11/03/2020

### DESCRIPTION:
# This script sets the working environment for the computer on which you are working.

########################################################################################################################
# find_term(h, t)
			## this function searches for a specific term in a list.
	# h = term to search
	# t = table from which term will be searched
########################################################################################################################
find_term <- function(h, t=g.t){
					d <- unlist(lapply(strsplit(h, ' '), '[', ))
					e <- d[grepl(t, d, fixed=FALSE, ignore.case=TRUE)]
					return(paste(e, collapse='; '))
}
########################################################################################################################
########################################################################################################################
# XXX
	# this function ...
########################################################################################################################
# XXX <- function(a, b){
# 					d <- unlist(lapply(strsplit(h, ' '), '[', ))
# 					e <- d[grepl(t, d, fixed=FALSE, ignore.case=TRUE)]
# 					return(paste(e, collapse='; '))
# }
########################################################################################################################
