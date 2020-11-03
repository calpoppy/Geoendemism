#download and sort CCH data
rm(list=ls())
#connect to dataset on the internet and save to a .txt file
   ##location is "http://herbaria4.herb.berkeley.edu/CF_export.txt"

#download.file("http://herbaria4.herb.berkeley.edu/CF_export.txt", "E:/Still_GIS/R_working_directory/cch/CF_export.txt")
# download.file("http://herbaria4.herb.berkeley.edu/CF_export.txt", "CF_export_2014-11-03.txt")

#system.time(x <- readLines("E:/Still_GIS/R_working_directory/cch/CF_export.txt"))

#ncol <- max(count.fields("E:/Still_GIS/R_working_directory/cch/CF_export.txt", sep = "\t"))

# cch <- read.delim("E:/Still_GIS/R_working_directory/cch/CF_export.txt", header=TRUE, sep = "\t", quote="", as.is=1:19)
# cch <- readLines("CF_export_2014-11-03.txt")
cch <- read.delim("CF_export_2014-11-03_no3.txt", header=TRUE, sep = "\t", quote="", as.is=TRUE)
# cch <- read.delim("CF_export_2014-11-03.txt", header=TRUE, sep = "\t", quote="", as.is=TRUE)
	names(cch)
	nrow(cch)
	head(cch)

uids <- unique(cch$taxon_name)
	uids[1:100]

write.table(uids, "unique_cch_spp.txt", sep="\t", row.names=FALSE)

counts <- table(cch$taxon_name)

	counts[1:100]
	tail(counts)
			cch <- cch[,!colnames(cch)%in% c("extra1", "extra2")]
			(cnms <- colnames(cch))
				head(cch)
			
		beg <- c("km", "miles", "m", "mi.", "kilometers", "mi", "MI", "Mi", "meters", "yards", "M", "ni", "feet", 
							"ft", "mi. ", "mile", "meters radius", "m.", "f",  "ma", "ft.", "mi ", "ft USGS Quadrangle",
							"'",  "KM", "mk", "m radius", "mio", "mo", "ma")
		end <- c("km", "mi",    "m", "mi" , "km",         "mi", "mi", "mi", "m",      "yd"   , "m", "mi", "ft", 
							"ft", "mi",   "mi",   "m",             "m",  "ft", "ma", "ft",  "mi",  "ft",
							"ft", "km", "km", "m",        "mi",  "mi", "mi")
								# "pdop",  "3"
		
		error.subs <- cbind.data.frame(beg=beg, end=end)
		error.subs$beg <- as.character(error.subs$beg)
		error.subs$end <- as.character(error.subs$end)
		
		cch$error_radius_units_new <- cch$error_radius_units
		cch$error_radius_units_new <- error.subs$end[match(cch$error_radius_units_new, error.subs$beg, nomatch=cch$error_radius_units_new)]
		
		remaining.errors <- unique(cch$error_radius_units[!cch$error_radius_units %in% c(error.subs$beg, error.subs$end)])

##save the CCH data
	save(cch, uids, file="cch.RData")
############################################
load("cch.RData")
	names(cch)

##get those records where the names are only one word...to get at just Genus level names 
cch$my_name <- gsub("\xd7", "Xinter", cch$taxon_name)
# cch$my_name <- gsub("\xd7", "Xinter", cch$taxon_name)
# cch <- gsub("\xd7", "specialX", cch)
cch$my_name <- gsub(" ", "_", cch$my_name)
my.nms <- unique(cch$my_name)
only.gen <- my.nms[lapply(strsplit(my.nms, "_", fixed=TRUE), FUN=function(x) length(x)) == 1]
no.cch <- cch[cch$my_name %in% only.gen,]
# 	unique(no.cch$taxon_name)
cch    <- cch[!cch$my_name %in% only.gen,]
# 	uids <- unique(cch$taxon_name)
	names(cch)
uids <- unique(cch$taxon_name)
	uids[1:100]

write.table(uids, "unique_cch_spp.txt", sep="\t", row.names=FALSE, append=FALSE)
# no.gen <- uids2[uids2 %in% ""]
############################################
unique(cch$county)
cc  <- cch[cch$county != "unknown",]
ukn <- cch[cch$county == "unknown",]

#look at county records
counties <- sort(unique(cc$county))
#fix county records
   (counties <- sort(unique(cc$county)))

cc$collection_number_suffix <- gsub("-\xbd", "specialX", cc$collection_number_suffix)
cc$collection_number_suffix <- gsub("-A\xd0W", "specialX", cc$collection_number_suffix)
cc$collection_number_suffix <- gsub("\x87", "specialX", cc$collection_number_suffix)

names(cc)

library(data.table)
cc.dt <- data.table(cc)
  setkey(cc.dt, Accession_id)

cc.county <- cc.dt[, c(freq=length(Accession_id)), by=c(county)]
# cc.taxon  <- cc.dt[, c(freq=length(Accession_id)), by=list(taxon_name, county)]
cc.taxon  <- data.frame(cc.dt[, c(freq=length(Accession_id)), by=list(taxon_name)])
cc.taxon.cty  <- data.frame(cc.dt[, c(freq=length(Accession_id)), by=list(taxon_name, county)])
	head(cc.taxon)
names(cc.taxon) <- c("taxon_name", "freq")
	head(cc.taxon.cty)
names(cc.taxon.cty) <- c("taxon_name", "county", "freq")

##bring in the list of rare plants and subset the CCH data
rare <- read.delim("cnddb_spp.txt", sep="\t", header=TRUE, as.is=TRUE)
cc.cnps <- cc[cc$taxon_name %in% rare$SNAME,]
cc2 <- cc[!cc$taxon_name %in% rare$SNAME,]
length(unique(cc.cnps$taxon_name))
length(unique(cc2$taxon_name))

cc.taxon


library(data.table)
cc.dt <- data.table(cc)
  setkey(cc.dt, Accession_id)

cc.county <- cc.dt[, c(freq=length(Accession_id)), by=c(county)]
# cc.taxon  <- cc.dt[, c(freq=length(Accession_id)), by=list(taxon_name, county)]
cc.taxon  <- data.frame(cc.dt[, c(freq=length(Accession_id)), by=list(taxon_name)])
cc.taxon.cty  <- data.frame(cc.dt[, c(freq=length(Accession_id)), by=list(taxon_name, county)])
	head(cc.taxon)
names(cc.taxon) <- c("taxon_name", "freq")
	head(cc.taxon.cty)
names(cc.taxon.cty) <- c("taxon_name", "county", "freq")


# (suffix <- sort(unique(cc$collection_number_suffix)))
# 	
# names(cc)
# # Sys.setlocale()
# # 	Sys.setlocale('LC_ALL','C') 
# cc[1081700,]
# cc[cc$collection_number_suffix == "W. Wisura",]
# #Change the suffix to uniform for the suffix s.n.
# sans.nms <- c("s n", "s. n", "s.b.", "s.m.", "s.n .", "s.n.'", "s.n..", "s.nn.", "s.ns.", "s./n.", "s,b,", "s,n.", 
# 							"s,n,", "S,.N.", "sa.n.", "s..", "x.n.", "s.n. .", "s.n. -", "S. M.", "S. N.", "S.n.", "S.N", "S.N.", 
# 							"s/n", "sn", "sn.", "ss.n.", "sss.n.", "sw.n.")
# 
# cc$collection_number_suffix <- gsub("s n", "sans numero",   cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s. n", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.b.", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.m.", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.n", "sans numero",   cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.n .", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.n.'", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.n.", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.n..", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.nn.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.ns.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s./n.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s,b,", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s,n.", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s,n,", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("S,.N.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("sa.n.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s..", "sans numero",   cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.n.", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("x.n.", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.n. .", "sans numero",cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s.n. -", "s.n.-",      cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("S. M.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("S. N.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("S.n.", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("S.N", "sans numero",   cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("S.N.", "sans numero",  cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("s/n", "sans numero",   cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("sn", "sans numero",    cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("sn.", "sans numero",   cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("ss.n.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("sss.n.", "sans numero",cc$collection_number_suffix, fixed=TRUE)
# cc$collection_number_suffix <- gsub("sw.n.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# # cc$collection_number_suffix <- gsub("ssans numero.", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# # cc$collection_number_suffix <- gsub("sssans numero", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# #cc$collection_number_suffix <- gsub("SN", "sans numero",    cc$collection_number_suffix, fixed=TRUE)
# 
# cc$collection_number_suffix <- gsub("unnumbered", "sans numero", cc$collection_number_suffix, fixed=TRUE)
# 
#    cc$collection_number_suffix <- gsub("sans numero", "s.n.", cc$collection_number_suffix, fixed=TRUE)
#    cc$collection_number_suffix <- gsub(".. ", ".", cc$collection_number_suffix, fixed=TRUE)
#    cc$collection_number_suffix <- gsub("..", ".", cc$collection_number_suffix, fixed=TRUE)
#    cc$collection_number_suffix <- gsub("- ", "-", cc$collection_number_suffix, fixed=TRUE)


(suffix <- sort(unique(cc$collection_number_suffix)))
	head(suffix)

# #rows to remove
# to.rm <- c(81210:81212, 81252:81253, 93104:93105, 93115:93116, 109740:109742, 113928:113929, 216914:216915)
# cch[113928:113929,]
# 
# 81211   81212   81253   93105   93116   109741  109742  113929  114019  114065  115986  115998 
# 116012  118486  118487  118488  118489  118490  118491  118492  121814  121839  121840  121854 
# 121855  124388  124389  124479  124480  136755  136756  136757  136815  136825  136839  136853 
# 136864  136875  136889  136904  142738  160271  216911  216915  216927  216928  216929  216937 
# 216938  216953  216954  216971  221367  221368  221377  221383  221384  221401  221402  221403 
# 221421  221422  224924  224925  231780  231791  231792  231793  231794  231795  246362  246390 
# 246391  246455  246473  246474  246518  246519  251170  251171  251186  251202  251203  251216 
# 251226  251227  251241  251242  251257  251258  343721  343751  343776  343799  343821  343846 
# 343866  343891  343908  343926  355176  355196  355223  355249  355276  355300  355331  355431 
# 355454  363694  363725  363726  363748  363780  363811  363851  363873  363897  364057  364077 
# 380963  380983  381135  "381158"  "393002"  "393024"  "393048"  "393075"  "393120"  "393149"  "393150"  "393172" 
# "393197"  "393222"  "401629"  "401655"  "401684"  "401707"  "401732"  "401787"  "401877"  "401894"  "401895"  "410619" 
# "410666"  "410692"  "410713"  "410737"  "410764"  "410786"  "410892"  "410913"  "428533"  "428534"  "428581"  "428582" 
# "428583"  "428584"  "437964"  "441528"  "441551"  "441580"  "441605"  "441629"  "441654"  "441680"  "441701"  "441725" 
# "441750"  "453324"  "453355"  "453380"  "453408"  "453434"  "453460"  "453487"  "453518"  "575914"  "575938"  "588026" 
# "588324"  "588325"  "588351"  "596592"  "596735"  "596736"  "601344"  "605867"  "605868"  "605869"  "619589"  "619674" 
# "619675"  "619754"  "619933"  "619934"  "626381"  "626382"  "626428"  "628407"  "628425"  "628447"  "628468"  "628469" 
# [205] "628515"  "685046"  "691842"  "693702"  "693722"  "693742"  "693764"  "693781"  "693799"  "693824"  "693844"  "694011" 
# [217] "694037"  "711358"  "711375"  "711376"  "711500"  "711628"  "715321"  "715344"  "715364"  "715437"  "715467"  "715603" 
# [229] "723698"  "723727"  "723728"  "723729"  "723757"  "723780"  "723781"  "723804"  "723879"  "724020"  "724039"  "799502" 
# [241] "799503"  "799549"  "917115"  "917140"  "917306"  "917337"  "917365"  "917390"  "917417"  "917449"  "917474"  "917500" 
# [253] "926262"  "926286"  "926526"  "938327"  "938357"  "938386"  "938414"  "938443"  "938471"  "938533"  "946811"  "946835" 
# [265] "946867"  "946893"  "946920"  "946944"  "946988"  "962533"  "967809"  "967827"  "967845"  "967866"  "967890"  "1086494"
# [277] "1403599" "1409185" "1409186" "1417003" "1418949" "1454896" "1454907" "1454918" "1454919" "1454944" "1454945" "1454946"
# [289] "1454956" "1454957" "1459164" "1459165" "1459176" "1459177" "1459240" "1459283" "1459284" "1459285" "1463736" "1463804"
# [301] "1463805" "1463806" "1463916" "1469773" "1469774" "1484363" "1484372" "1484405" "1488894"
# 
# unk.rows <- row.names(unk)
# 
# 
# cch[to.rm,]
