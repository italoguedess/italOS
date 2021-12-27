#! /bin/sh
# gets the user name
myName=`whoami`
# a little welcoming message
echo "#####################################"
echo "Hello $myName, and welcome to italOS!"
echo "#####################################"
echo "This script will guide you through the installation of italOS!"

# install all packages from pkglis.txt
doas pacman -S - < pkglist.txt
# enables network manager from the startup
systemctl enable NetworkManager.service
# enable lightdm from the startup
systemctl enable lightdm

# if there isn't a .config folder, creates it
[ `fd -HIgt d .config $HOME` ] || \
    mkdir $HOME/.config

# if there isn't an alacritty config file already copies the one italOS to $HOME/.config/alacritty/
if [ `fd -HIg alacritty.yml $HOME` ];then
    echo "An alacritty config file was found, do you still want the italOS one? (it won't overwrite yours) [Y/n]"
    read path
    [ path = "n" ] || [ path = "N" ] || \
        cp config-files/italOS-alacritty.yml $HOME/.config/alacritty/italOS-alacritty.yml
else
    # if there isn't an $HOME/.config/alacritty folder, creates it
    [ `fd -HIg .config/alacritty $HOME` ] || \
        mkdir $HOME/.config/alacritty
    # copy italOS alacritty config file to $HOME/.config/alacritty/
    cp config-files/italOS-alacritty.yml $HOME/.config/alacritty/alacritty.yml
fi
