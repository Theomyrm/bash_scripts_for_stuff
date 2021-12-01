## Get home WorkingDirectory
user <- Sys.info()[["user"]]
wdhome <- paste("//home//",user,sep = "")
wd <- paste(wdhome,"//Ants//DB//",sep = "")
setwd(wd) ## set DB as WorkingDirectory
getwd()
##

DB <- read.csv('ANTDB.csv', header = T, sep = ',')
genus <- data.frame(unique(DB$Raw.genus))
species <- data.frame(stringr::word(DB$Raw.species, -1))
species <- data.frame(species[!apply(species == "", 1, all),])

