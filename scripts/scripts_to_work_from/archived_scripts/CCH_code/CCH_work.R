rm(list=ls())
library(data.table)
# setwd('/Users/sstill/Dropbox/CBG_private/cch')
  getwd()
cf.all <- read.delim("/Users/sstill/Dropbox/CBG_private/cch/CF_export.txt", header=TRUE, sep = '\t', as.is=TRUE)
  names(cf.all)

nms <- unique(cf.all$taxon_name)
nms[1:100]

cf.dt <- data.table(cf.all)
  setkey(cf.dt, Accession_id)

cf.esch <- cf.dt[grepl('Eschsch*', cf.dt$taxon_name),]
# cf.esch <- cf.all[grepl('Eschscholzia*', cf.all$taxon_name),]
#   head(cf.esch)

esch.county <- cf.esch[, c(freq=length(Accession_id)), by=c(county)]
esch.taxon <- cf.esch[, c(freq=length(Accession_id)), by=list(taxon_name, county)]
esch.taxon <- data.frame(cf.esch[, c(freq=length(Accession_id)), by=list(taxon_name, county)])

nms <- unique(cf.esch$taxon_name)
write.table(nms, 'esch_names.csv', sep=',')
esch.cf <- read.delim("/Users/sstill/Dropbox/CBG_private/cch/esch_names.txt", header=T, sep = '\t', as.is=TRUE)
  names(cf.all)

cf.esch$taxon_true <- esch.cf$my_name[match(cf.esch$taxon_name, esch.cf$cch_name)]

esch.taxon <- data.frame(cf.esch[, c(freq=length(Accession_id)), by=list(taxon_true, county)])
write.table(esch.taxon, 'esch_taxa_county.csv', sep=',')


