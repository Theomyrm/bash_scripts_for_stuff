## Get home WorkingDirectory
user <- Sys.info()[["user"]]
wdhome <- paste("//home//",user,sep = "")
wd <- paste(wdhome,"//Ants//DB//",sep = "")
setwd(wd) ## set DB as WorkingDirectory
getwd()
##

DB <- read.csv('ANTDB.csv', header = T, sep = ',')
genus <- data.frame(unique(DB$Raw.genus))
species <- data.frame(unique(DB$Raw.species))