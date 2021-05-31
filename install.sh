#!/bin/bash

#set install dir, script should be starting in the profile loader dir
mkdir ../.dots
INSTALL=$PWD/../.dots

apt update
#intall git and wget
if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y vim zsh git wget || sudo pacman -S vim zsh git wget || sudo dnf install -y vim zsh git wget || sudo yum install -y vim zsh git wget || sudo brew install vim git zsh wget || pkg install vim git zsh wget ; then
        echo -e "vim zsh wget and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi



############################# ZSH ################################
#install ohmyzsh
echo -e "Installing oh-my-zsh\n"
if [ -d $INSTALL/.oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
else
    git clone https://github.com/ohmyzsh/ohmyzsh.git $INSTALL/.oh-my-zsh
fi

#install plugins
if [ -d $INSTALL/.oh-my-zsh/plugins/zsh-autosuggestions ]; then
    cd $INSTALL/.oh-my-zsh/plugins/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $INSTALL/.oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -d $INSTALL/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    cd $INSTALL/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $INSTALL/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ -d $INSTALL/.oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd $INSTALL/.oh-my-zsh/custom/plugins/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions $INSTALL/.oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d $INSTALL/.oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
    cd $INSTALL/.oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search $INSTALL/.oh-my-zsh/custom/plugins/zsh-history-substring-search
fi

#set zsh as default shell
echo -e "\nSudo access is needed to change default shell\n"

if chsh -s /bin/zsh $USER; then
    echo -e "Installation Successful, exit terminal and enter a new session"
else
    echo -e "Something is wrong"
fi

#ZSHRC
FILE=$INSTALL/.zshrc
if test -f "$FILE"; then
    echo "$FILE exists."
else
    # if the .zshrc doesnt exist pull it from PWD else pull it from the
    # template file
    if test -f "$PWD/.zshrc"; then
        cp .zshrc $INSTALL/.zshrc
    else
        cp $INSTALL/.oh-my-zsh/templates/zshrc.zsh-template $INSTALL/.zshrc
    fi
fi

######################## VIM ############################



echo -e "\n++++ RESTART SHELL NOW +++\n"

exit
