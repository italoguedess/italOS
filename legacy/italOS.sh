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

# if there isn't a .emacs.d folder, creates it
[ `fd -HIg1t d .emacs.d $HOME` ] || \
    mkdir .emacs.d
# if $HOME/.emacs.d isn't empty
if [ "`ls -A $HOME/.emacs.d`" ]; then
    echo "$HOME/.emacs.d already exists, creating $HOME/italOS.emacs.d"
    # download the spacemacs without overwriting the user's files
    git clone https://github.com/syl20bnr/spacemacs ~/italOS.emacs.d 
# if #HOME.emacs.d is empty
else
    #clones it into $HOME/.emacs.d
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

# if there isn't a $HOME/.themes folder creates it
[ `fd -HIgt d .themes $HOME` ] || \
    mkdir $home/.themes
# downloading the dracula theme for alacritty, spacemacs and tty
git clone https://github.com/dracula/alacritty $HOME/.themes/dracula-alacritty
git clone https://github.com/dracula/spacemacs.git $HOME/.themes/dracula-spacemacs
git clone https://github.com/dracula/tty.git $HOME/.themes/dracula-tty

# if $HOME/.bashrc exists
if [ `fd -HI .bashrc $HOME` ]; then
    # creates a backup of .bashrc
    cp $HOME/.bashrc $HOME/.bashrc-backup
    # concatenate .bashrc and the theme fie and puts the result in .bashrc-dracula
    cat $HOME/.bashrc $HOME/.themes/dracula-tty/dracula-tty.sh > $HOME/.bashrc-dracula
    # copies .bashrc-dracula into .bashrc
    cp $HOME/.bashrc-dracula $HOME/.bashrc
# if $HOME/.bashrc doesn't exist
else
    # copies dracula-tty.sh omtp .bashrc
    cp $HOME/.themes/dracula-tty/dracula-tty.sh $HOME/.bashrc
fi
