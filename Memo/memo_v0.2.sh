#!/bin/bash

#  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #
#                            Script para memo                                 #
# Este script tiene como funcion el que al iniciar el script memo.sh se       #
# registren en un archivo a manera de "memos" donde se puedan realizar tareas #
# laboriosas que requieren una serie de pasos. Asi quedan registrados y ademas#
# es posible dar separaciones de formato simple para que al momento de leer   #
# el archivo sea mas legible.                                                 #
#                                    Por tmyrm                                #
#  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #

################### INICIO ####################################################

echo -n "Nombre del memo (con extension): "
read memoname
echo -n "Guardar en: "
read userpath
cd $userpath
touch $memoname

###############################################################################

##### Variables esteticas para dar formato al documento

########################### Separadores #############################

sep1="###  ###  ###  ###  ###         Inicio         ###  ###  ###  ###  ###"

############################# Func Start ######################################

##### Funcion para iniciar a hacer el memo #####
start() {
# Insertar separador en $memoname
echo -e "                   ${memoname}                         \n" >> $memoname
echo -e $sep1 "\n" >> $memoname
echo insertando separador
}

###############################################################################

############################## Func Body #######################################
# Aqui se ejecutan los comandos y se realizan los apuntes para transmitir a $memoname


body() {
  echo -e "\n Inserta tu comando:"

read usermemo
# El lector de ordenes
    case $usermemo in
      # Detiene el script.
      stop ) stop ;;
      # inserta separador con titulo deseado
      sep ) echo "septitle:"  && read septitle && sleep 2 | echo -e '\n### ### ### ### ###' "$septitle"  '### ### ### ### ###' >> $memoname && body ;;
      # Ejecuta cualquier comando que se le indique y regista en memo la tarea
      * ) $usermemo && echo ${usermemo} >> $memoname && body ;;
    esac
}


stop() {

exit 0;

}

start

body
