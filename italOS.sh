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
# enable lightdm from the startup
systemctl enable lightdm

# creates a folder in .config if necessary and copies there without overwriting a config file from italOS
# the first parameter must be the name of the folder created in .config
# the second parameter must be the name of the file
# the third parameter must be the extension without the dot (e.g: py)
function setConfigFile () {
    echo "Copying $2.$3 to $HOME/.config/$1/"
    # if there isn't a config file already copies the one italOS to $HOME/.config/$1
    if [ `fd -HIg ${2}.$3 $HOME` ];then
        echo "An ${2}.$3 config file was found, do you still want the italOS one? (it won't overwrite yours) [Y/n]"
        read userInput
        # if the user's input is other than n or N copies the config file without overwriting
        [ $userInput = "n" ] || [ $userInput = "N" ] || \
            cp config-files/italOS-${2}.$3 $HOME/.config/$1/italOS-${2}.$3
    else
        # if there isn't an $HOME/.config/$1 folder, creates it
        [ `fd -HIgt d $1 $HOME/.config/` ] || \
            mkdir $HOME/.config/$1
        # copy italOS config file to $HOME/.config/$1/
        cp config-files/italOS-${2}.$3 $HOME/.config/$1/${2}.$3
    fi
}


# if there isn't a .config folder, creates it
[ `fd -HIgt d .config $HOME` ] || \
    mkdir $HOME/.config

setConfigFile awesome rc lua
setConfigFile awesome theme lua
setConfigFile alacritty alacritty yml

# if there isn't a $HOME/.themes folder creates it
[ `fd -gt d .themes $HOME` ] || \
    mkdir $home/.themes
# downloading the dracula theme for alacritty and spacemacs
git clone https://github.com/dracula/alacritty $HOME/.themes/dracula-alacritty
git clone https://github.com/dracula/spacemacs.git $HOME/.themes/dracula-spacemacs
