## geoendemism functions
find_term <- function(h, t=g.t){
					d <- unlist(lapply(strsplit(h, ' '), '[', ))
					e <- d[grepl(t, d, fixed=FALSE, ignore.case=TRUE)]
					return(paste(e, collapse='; '))
}
