#! /bin/sh
# gets the user name
myName=`whoami`
# a little welcoming message
echo "Hello $myName, and welcome to italOS!"
echo "This script will guide you through the installation of italOS!"

# checks if the networkmanager packet is already installed, if it isn't installs it
# [ "`pacman -Qs networkmanager`" ] && echo "network manager is already installed" \
                                          # || "`doas pacman -S networkmanager`"

# adds all explicitly installed packages in pkglist.txt
pacman -Qe >> pkglist.txt

# checks if the packages are already installed and if they are not install them
for i in networkmanager xorg lightdm lightdm-gtk-greeter i3-wm git emacs firefox alacritty man-db picom
         do
             [ "`grep -e $i pkglist.txt`" ] && echo "$i is already installed" \
                                           || "`doas pacman -S $i`"
         done
