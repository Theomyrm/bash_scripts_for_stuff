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

#  Hola, bienvenido a este buscador de hormigas. Aqui podras buscar ya sea   #

#  por nombre de especie o nombre de genero a hormigas, de las que uno       #

#  quisiera sacar informacion genetica o en su defecto, descripciones de     #

#  articulos.                                                                #

#  Disfruta.                                     Traido a todos por TMyrm    #

# -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #
"; sleep 2


## Variables a utilizar
D1=0    # Variable para determinar presencia ausencia de dependencia EDirect
D2=0    # Variable para determinar presencia ausencia de dependencia imagemagick
ans=""  # Variable para almacenar query
arr=(0) # Array para almacenar opciones

echo "Revisando dependencias:
" && sleep 1

function informacion(){
  echo -e "  ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ##
  ##                        Sobre script ANTS:                               ##
  ##                                                                         ##
  ##    Este script fue elaborado por Elrik Miralda como parte de la         ##
  ##    asignatura de bioinformatica, de la Universidad Autonoma de          ##
  ##    Yucatan. La intencion inicial era tener acceso tanto a fotografias   ##
  ##    como informacion genetica, pero la API de webant se encuentra abajo  ##
  ##    Asi que quedo simplemente como un buscador. Espero sea de su agrado  ##
  ##                                                                         ##
  ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ## - ##\n\n"
exit 0;
}

## Revision de dependencias
function dependency() {

#  -  -  #  -  -  #  -  -  Seccion inspeccion  -  -  #  -  -  #  -  -  #

  # Revisar existencia de la dependencia Esearch
  if [ -x "$(command -v elink)" ]; then
      echo "eDirect encontrado" # No es necesario instalar
  else
      echo "No se encontro Edirect" # Es necesario instalar
      D1=1;
  fi

  # Revisar existencia de la dependencia ImageMagick
  if [ -x "$(command -v convert)" ]; then
    echo 'ImageMagick encontrado'
  else
    echo 'No se encontro ImageMagick'
    D2=1;
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
## Funcion para carga de datos en R y __main__

###                                                                       ###
## Area de funciones de R y variables en general
  ## Funciones almacenadas en strings:
    ## Base; carga de archivo, creacion DB y seleccion:

#   #       #       #       Carga de datos a R       #       #        #   #

## Funcion para cargar los datos basicos de la base de datos de          ##
## hormigas. Tambien se encarga de generar las bases de datos utilizadas ##
## para realizar las busquedas y navegaciones.                           ##

#       #       #       #        #        #         #       #       #

## Funcion que da la opcion de buscar informacion de hormigas por genero o especie
function buscador() {
  echo -e "Procure ser lo mas preciso que pueda con sus busquedas:"; sleep 1;
  echo -e "Las busquedas deben utilizar o nombre de especie y genero (ej: Atta cephalotes)"; sleep 1;
  echo -e "O en su defecto, solo contener nombre de genero (ej: Acromyrmex)\n"; sleep 1;
  echo -e "inserte su busqueda"
  read que
  ry='"'
  query="${ry}^${que}${ry}" ## <-- Sirve para usar formato de busqueda de grep->R

  #       #       #       Variables de buscador       #       #       #

  ## Funcion para realizar busqueda por nombre puntual.Especie o genero ##
  ## Tambien determina si se esta realizando una busqueda por especie   ##
  ## o por genero. Donde, en caso de ser por especie, se realiza la     ##
  ## busqueda directa y en caso de ser por genero, se muestra una lista ##
  ## de posibilidades a elegir.                                         ##

  #       #       #       #        #        #         #       #       #

  #       #       #        Inicio de busqueda R       #       #       #
  R --slave <<EOF
      DB <- read.csv('~//Ants//DB//ANTDB.csv', header = T, sep = ',') ### Carga base de datos
      attach(DB)
      query <- unique(data.frame(species[grep(pattern= ${query}, species)]))
      names(query) <- NULL
      write.table(query, file="~//Ants//DB//result.txt", sep = "")
EOF
    ## Genera dataframe con query y wildcard de patron
    ## divide segun resultado sea especie o genero

  #       #       #       #        #        #         #       #       #
  #       #       #        Lector de Indices          #       #       #
  ## Lee, despliega resultados y los muestra como opciones a elegir  ##

  echo -e "Selecciona tu hormiga de eleccion (Por nombre completo)\n"; sleep 2

  i=1
  while IFS= read -r line; do
    dat="${line}"
    echo $dat >> ~/Ants/DB/BashOut ## OUT ----->
    arr+=(${line})
    i=$((i+1))
  done < ~/Ants/DB/result.txt | cut -d '"' -f4;
  more ~/Ants/DB/BashOut
  echo -e "\nNombre completo de especie:"
  sleep 2
  read ans ## Lee la respuesta
  rm ~/Ants/DB/BashOut
  rm ~/Ants/DB/result.txt
  Equery

}

function Equery() {
 ###                                                        ###
  ## Primero, despliega informacion taxonomica generica:
  echo -e "El organismo que escogiste fue:\n"
  esearch -db taxonomy -query "${ans}" | efetch -format abstract
  sleep 2 ## Para ajustar el ritmo del texto del programa

  ## Ahora, pregunta al usuario que es lo que necesita:
  echo -e "Que es lo que deseas encontrar sobre el organismo? (Inserte numero)\n"
  echo -e "
  1. Secuencias geneticas
  2. Encontrar articulos
  "
  read info

  case $info in
    # Muestra secuencias geneticas.
    1 ) echo -e "inserta el numero de lineas de texto que quieres ver" && read numQg &&
    esearch -db nucleotide -query "${ans}" | efetch -format fasta | head -n $numQg ;;
    # Muestra informacion sobre especie
    2 ) echo -e "inserta el numero de lineas de texto que quieres ver" && read numQa &&
    esearch -db pubmed -query "$ans" | efetch -format abstract | head -n ${numQa}  ;;
    # Cierra el programa
    * ) exit 0 ;;
  esac

  exit 0;}
 ###                                                        ###

 ## Menu de opciones:
function menu() {
 echo "
  ¿Que funcion necesitas? (Inserte numero):
       1 Buscador
       2 Informacion sobre script"
 read answ2
  case $answ2 in
   1 ) buscador ;;
   2 ) informacion ;;
  esac
 }
dependency ## <---- Inicio del script
exit 0;
