#! /bin/sh
# gets the user name
myName=`whoami`
# a little welcoming message
echo "##############################################################"
echo "            Hello $myName, and welcome to italOS!"
echo "##############################################################"
echo "This script will guide you through the installation of italOS!"
echo "##############################################################"

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
    read userInput
    # if the user's input is other than n or N copies the config file without overwriting
    [ $userInput = "n" ] || [ $userInput = "N" ] || \
        cp config-files/italOS-alacritty.yml $HOME/.config/alacritty/italOS-alacritty.yml
else
    # if there isn't an $HOME/.config/alacritty folder, creates it
    [ `fd -HIg .config/alacritty $HOME` ] || \
        mkdir $HOME/.config/alacritty
    # copy italOS alacritty config file to $HOME/.config/alacritty/
    cp config-files/italOS-alacritty.yml $HOME/.config/alacritty/alacritty.yml
fi

# creates a folder in .config if necessary and copies there without overwriting a config file from italOS
# the first parameter must be the name of the folder created in .config
# the second parameter must be the name of the file
# the third parameter must be the extension without the dot (e.g: py)
function setConfigFile () {
    # if there isn't a config file already copies the one italOS to $HOME/.config/alacritty/
    if [ `fd -HIg $2.$3 $HOME` ];then
        echo "A config file was found, do you still want the italOS one? (it won't overwrite yours) [Y/n]"
        read userInput
        # if the user's input is other than n or N copies the config file without overwriting
        [ $userInput = "n" ] || [ $userInput = "N" ] || \
            cp config-files/italOS-$2.$3 $HOME/.config/$1/italOS-$2.$3
    else
        # if there isn't an $HOME/.config/$1 folder, creates it
        [ `fd -HIg .config/$1 $HOME` ] || \
            mkdir $HOME/.config/$1
        # copy italOS config file to $HOME/.config/$1/
        cp config-files/italOS-$2.$3 $HOME/.config/$1/$2.$3
    fi
}

setConfigFile awesome rc lua
setConfigFile awesome theme lua
