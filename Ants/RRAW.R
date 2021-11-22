library("tidyverse")
setwd('//home//tmyrm//Documents//GitHub//bash_scripts_for_stuff')
Raw <- read.csv('Ants//Species hormigas//Ant_list.csv'
                , header = T, sep = '\t', stringsAsFactors = T)

DBgenus <- data.frame(Raw$genus)
DBspecies <- data.frame(Raw$species)
DB <- cbind(DBgenus, DBspecies)

write.csv(DB, file = 'ANTDB.csv')