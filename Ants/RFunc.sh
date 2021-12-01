#!/bin/bash

## Variables

query1=""

## Base
base="user <- Sys.info()[["user"]]      ## Lee usuario para nombre de home/user
wdhome <- paste("//home//",user,sep = "")   ## Genera ~/
wd <- paste(wdhome,"//Ants//DB//",sep = "") ## Genera ~/Ants/DB
setwd(wd) ## set DB as WorkingDirectory -> /home/user/Ants/DB
##
DB <- read.csv('ANTDB.csv', header = T, sep = ',') ## Carga base de datos
genus <- data.frame(unique(DB$Raw.genus)) ## lista de generos totales de hormigas
species <- data.frame(stringr::word(DB$Raw.species, -1)) ## Remover genero de lista de especie
species <- data.frame(species[!apply(species == "", 1, all),]) ## Remove NA elements on list
"
## Funciones


#  -  -  #  -  -  #  -  -  Busqueda normal  -  -  #  -  -  #  -  -  #

# String para R
giveQueryList="giveQueryList <- function() {
  query <- DB[grep("^${query1}", DB$species)] ## Genera dataframe con query
                                              ## y wildcard de patron
                                              ## divide segun resultado sea
                                              ## especie o genero

  if(DB[${query1} in DB$genus]){ ## Si resultado es genero
    queryresult <- query[grep("^${query1}", DB$Raw.species)] ## Busqueda por patron
    write.txt(queryresult, ..//Output//result.txt, sep = ",") ## OUT: result.txt

} else { ## Si resultado es especie
  queryresult <- query[grep("^${query1}", species)] ## Busqueda en especies
  write.txt(queryresult, ..//Output//result.txt) ## OUT: result.txt
}}
giveQueryList()"

#  -  -  #  -  -  #  -  -  Lector de indices  -  -  #  -  -  #  -  -  #

if [ -s 'result.txt' ] then

  echo "Selecciona por numero tu eleccion"
  arr=(0) ## Inicio de array indice
  while IFS= read -r line; do
    i=1
    echo "${i} ${line}" >> bashOUT.txt ## OUT
    arr+=(${line})
    i=$i+1
    indices=(${!arr[@]})
  done < "$1" ## Muestra en pantalla las opciones de busqueda
read ant
echo ${indices[i]}




## Navegacion
