#!/bin/bash

## Dependencies;
#  Edirect
#  imagemagick

# -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #

#                   Buscador / explorador de hormigas                        #

#       Script hecho con la finalidad de buscar hormigas por taxon           #

#       Y encontrar informacion genetica.                                    #

#                                                                            #

#                                                                   Tmyrm    #

# -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #


     #  -  -  #  -  -  #  -  -  Inicio script  -  -  #  -  -  #  -  -  #


# Presentacion: Texto que se imprime en pantalla
echo "# -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #

#  Hola, bienvenido a este buscador / explorador de hormigas. El objetivo    #

#  de este script es que, ya sea navegar a traves de las listas de hormigas  #

#  o al estar buscando una en particular, uno, desde terminal,  pueda tener  #

#  acceso a secuencias geneticas, descripciones, entre entre otras.          #

#  Disfruta.                                     Traido a todos por TMyrm    #

# -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #

"; sleep 2


## Variables a utilizar
D1=0   # Variable para determinar presencia ausencia de dependencia EDirect
D2=0   # Variable para determinar presencia ausencia de dependencia imagemagick
ans="" # Variable para almacenar query

echo "Revisando dependencias:
" && sleep 1

## Menu de opciones:
function menu() {
  echo "
  ¿Que funcion necesitas?:
        1 Explorador
        2 Buscador"
  read answ2
  case $answ2 in
    1 ) explorador ;;
    2 ) buscador ;;
  esac
}

## Revision de dependencias
function dependency() {

#  -  -  #  -  -  #  -  -  Seccion inspeccion  -  -  #  -  -  #  -  -  #

  # Revisar existencia de la dependencia Esearch
  if [ -x "$(command -v elink)" ]; then
      echo "eDirect encontrado" # No es necesario instalar
  else
      echo "No se encontro Edirect" # Es necesario instalar
      D1=1; return D1
  fi

  # Revisar existencia de la dependencia ImageMagick
  if [ -x "$(command -v convert)" ]; then
    echo 'ImageMagick encontrado'
  else
    echo 'No se encontro ImageMagick'
    D2=1; return D2
  fi

#  -  -  #  -  -  #  -  -  Seccion instalacion  -  -  #  -  -  #  -  -  #

# En caso no exista EDirect y si exista ImageMagick
  if [[ ${D1} == $((1))  &&  ${D2} == $((0)) ]]; then
    echo "Deseas installar Edirect? (y/n)"
    read answ1
    case $answ1 in
      # instala dependencia.
      y ) command  sh -c "$(wget -q ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh -O -)" &&
      echo "export PATH=\$PATH:\$HOME/edirect" >> $HOME/.bash_profile && export PATH=${PATH}:${HOME}/edirect && menu ;;
      # no instala dependencia
      n ) echo "El programa no puede funcionar sin este programa"  && exit 0 ;;
      # Cierra el programa
      * ) exit 0 ;;
    esac
  fi

  # En caso no exista EDirect y tampoco exista ImageMagick
    if [[ ${D1} == $((1))  &&  ${D2} == $((1)) ]]; then
      echo "Deseas installar Edirect y ImageMagick? (y/n)"
      echo "Aviso:(Se tiene estipulado que el usuario tiene una distribucion de linux
      basada en debian. Su este no es el caso, o su gestor de paquetes no es apt,
      se le agradece al usuario que instale la dependencia de forma manual.)"
      read answ1
      case $answ1 in
        # instala dependencia.
        y ) command  sh -c "$(wget -q ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh -O -)" &&
        echo "export PATH=\$PATH:\$HOME/edirect" >> $HOME/.bash_profile && export PATH=${PATH}:${HOME}/edirect&& sudo apt install imagemagick && menu ;;
        # no instala dependencias
        n ) echo "El programa no puede funcionar sin estos programas"  && exit 0 ;;
        # Cierra el programa
        * ) exit 0 ;;
      esac
    fi
    # En caso no exista ImageMagick
      if [[ ${D1} == $((0))  &&  ${D2} == $((1)) ]]; then
        echo "Deseas installar ImageMagick? (y/n)"
        echo "Aviso:(Se tiene estipulado que el usuario tiene una distribucion de linux
        basada en debian. Su este no es el caso, o su gestor de paquetes no es apt,
        se le agradece al usuario que instale la dependencia de forma manual.)"
        read answ1
        case $answ1 in
          # instala dependencia.
          y ) sudo apt install imagemagick && menu ;;
          # no instala dependencias
          n ) echo "El programa no puede funcionar sin estos programas"  && exit 0 ;;
          # Cierra el programa
          * ) exit 0 ;;
        esac
      fi

      if [[ ${D1} == $((0))  &&  ${D2} == $((0)) ]]; then ## En caso de que existan dependencias
                                                          ## simplemente seguira marchando
        menu
      fi
}
dependency ## <---- Inicio del script

## Funcion para carga de datos en R y __main__

function Rscr(){
  ## Area de funciones de R y variables en general
    ## Funciones almacenadas en strings:
      ## Base; carga de archivo, creacion DB y seleccion:

  #   #       #       #       Carga de datos a R       #       #        #   #

  ## Funcion para cargar los datos basicos de la base de datos de          ##
  ## hormigas. Tambien se encarga de generar las bases de datos utilizadas ##
  ## para realizar las busquedas y navegaciones.                           ##

  base="user <- Sys.info()[["user"]]      ## Lee usuario para nombre de home/user
  wdhome <- paste("//home//",user,sep = "")   ## Genera ~/
  wd <- paste(wdhome,"//Ants//DB//",sep = "") ## Genera ~/Ants/DB
  setwd(wd) ## set DB as WorkingDirectory -> /home/user/Ants/DB
  ##
  DB <- read.csv('ANTDB.csv', header = T, sep = ',') ## Carga base de datos
  "
  #       #       #       #        #        #         #       #       #

  ## Funcion que da la opcion de explorar las hormigas por genero y especie
  function explorador() {
    #       #       #       Variables de explorador       #       #       #

    ## Funcion para realizar exploraciones de generos y especies.         ##
    ## Una vez seleccionada la especie, se realizara query en eDirect     ##

    ## Comando de R para generar lista de generos
    giveNavList="query <- unique(data.frame(DB$Raw.genus))
    names(query) <- NULL
    write.table(query, file="//home//user//Ants//DB//result.txt", sep = "")"

    giveAlphList="query <- unique(data.frame(DB$Raw.genus[grep(pattern= "^${letra}", DB$Raw.genus)]))
    names(query) <- NULL
    write.table(query, file="//home//user//Ants//DB//result.txt", sep = "")"

    echo -e "Desea ver la lista completa de generos a elegir o prefiere por indice alfabetico?"
    echo -e "\n1. Lista completa\n2. Por Indice alfabetico"
    read nav1

    case $nav1 in
      # Muestra lista completa de generos.
      1. )  ;; R --slave <<EOF $base $giveNavList EOF && more ~/Ants/DB/result.txt
      # Muestra generos por letra escogida
      2. )  ;; echo -e "Inserte la letra deseada"&& read letra && R --slave <<EOF $base $giveAlphList EOF && more ~/Ants/DB/result.txt
      # Cierra el programa
      * ) exit 0 ;;
    esac

    #       #       #       #        #        #         #       #       #
    #       #       #        Lector de Indices          #       #       #
    ## Lee, despliega resultados y los muestra como opciones a elegir  ##

    if [ -s '~/Ants/DB/result.txt' ] then
      echo -e "Selecciona por numero tu eleccion\n"; sleep 2
      arr=(0)
      i=1
      while IFS= read -r line; do
        dat="${i}_${line}"
        echo $dat >> BashOut ## OUT ----->
        arr+=(${dat})
        i=$((i+1))
      done < "result.txt" | cut -d '"' -f4;
      more BashOut
      echo -e "\nNumero:"
      sleep 2
      read ans ## Lee la respuesta
      rm BashOut ## DEL <------
    fi
    Equery


  }

  ## Funcion que da la opcion de buscar informacion de hormigas por genero o especie
  function buscador() {
    echo -e "Procure ser lo mas preciso que pueda con sus busquedas:"; sleep 1;
    echo -e "Las busquedas deben utilizar o nombre de especie y genero (ej: Atta cephalotes)"; sleep 1;
    echo -e "O en su defecto, solo contener nombre de genero (ej: Acromyrmex\n)"; sleep 1;
    echo -e "inserte su busqueda"
    read query

    #       #       #       Variables de buscador       #       #       #

    ## Funcion para realizar busqueda por nombre puntual.Especie o genero ##
    ## Tambien determina si se esta realizando una busqueda por especie   ##
    ## o por genero. Donde, en caso de ser por especie, se realiza la     ##
    ## busqueda directa y en caso de ser por genero, se muestra una lista ##
    ## de posibilidades a elegir.                                         ##

    giveQueryList="query <- unique(data.frame(DB$Raw.species[grep(pattern= "^${query}", DB$Raw.species)]))
    names(query) <- NULL
    write.table(query, file="//home//user//Ants//DB//result.txt", sep = "")
    ## Genera dataframe con query y wildcard de patron
    ## divide segun resultado sea especie o genero"

    #       #       #       #        #        #         #       #       #

    #       #       #        Inicio de busqueda R       #       #       #
      R --slave <<EOF
        $base ### Carga base de datos
        $giveQueryList ### Realiza busqueda
        EOF
    #       #       #       #        #        #         #       #       #
    #       #       #        Lector de Indices          #       #       #
    ## Lee, despliega resultados y los muestra como opciones a elegir  ##

    if [ -s 'result.txt' ] then
  echo -e "Selecciona por numero tu eleccion\n"; sleep 2
  arr=(0)
  i=1
  while IFS= read -r line; do
   dat="${i}_${line}"
   echo $dat >> BashOut ## OUT ----->
   arr+=(${dat})
   i=$((i+1))
 done < "result.txt" | cut -d '"' -f4;
  more BashOut
  echo -e "\nNumero:"
  sleep 2
  read ans ## Lee la respuesta
  rm BashOut ## DEL <------
fi
Equery
  }
}

function Equery() {
  ## Primero, despliega informacion taxonomica generica:
  echo -e "El organismo que escogiste fue:"
  esearch -db taxonomy -query "$ans" | efetch -format abstract
  sleep 2 ## Para ajustar el ritmo del texto del programa

  ## Ahora, pregunta al usuario que es lo que necesita:
  echo -e "Que es lo que deseas encontrar sobre el organismo?\n"
  echo -e "
  1. Secuencias geneticas
  2. Encontrar articulos
  "
  read info

  case $info in
    # Muestra secuencias geneticas.
    1. ) echo -e "inserta el numero de lineas de texto que quieres ver" && read numQg &&
    esearch -db gene -blast "$ans" | efetch -format fasta | head -n $numQg ;;
    # Muestra informacion sobre especie
    2. ) echo -e "inserta el numero de lineas de texto que quieres ver" && read numQa &&
    esearch -db pubmed -query "$ans" | efetch -format abstract | head -n numQa  ;;
    # Cierra el programa
    * ) exit 0 ;;
  esac

  exit 0}
