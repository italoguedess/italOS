#! /bin/sh
# gets the user name
myName=`whoami`
# a little welcoming message
echo "#####################################"
echo "Hello $myName, and welcome to italOS!"
echo "#####################################
echo "This script will guide you through the installation of italOS!"

doas pacman -S - < pkglist.txt
doas systemctl enable NetworkManager.service
doas systemctl enable lightdm
