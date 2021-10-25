#!/bin/bash

# -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #

#                    Script for quick access to mail:                        #

#                    Change the formart as you like                          #

#                                                           By t.myrm        #

# -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #  -  #


echo -e  "\nEnter mail:"
echo """

#  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #

#                          Mails:                                 #

#                        1. x                                     #

#                        2. y                                     #

#                        3. z                                     #

#                        4. all                                   #

#  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #


""" ### You need to make pretty the sight!

mail1='urlx' ### Put any mail you want, and how many you want
mail2='urly'
mail3='urlz'

echo "number?: " # Insert after this
read mail # Read variable

case $mail in
  1 ) firefox $mail1 & ;; # mail x
  2 ) firefox $mail2 & ;; # mail y
  3 ) firefox $mail3 & ;; # mail z
  4 ) firefox $mail1 $mail2 $mail3 & ;; # all mails
  * ) exit 0 ;; # bye
esac
