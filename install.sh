#!/bin/bash          
echo Setting up dotfiles

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
echo ln -sv ${BASEDIR}/vimrc ~/.vimrc
ln -sv ${BASEDIR}/vimrc ~/.vimrc
echo "TODO Map .vim folder to disk location"

# tmux 
echo ln -sv ${BASEDIR}/tmux.conf ~/.tmux.conf
ln -sv ${BASEDIR}/tmux.conf ~/.tmux.conf
echo "TODO Map .tmux folder to disk location"

# bash
echo ln -sv ${BASEDIR}/bashrc ~/.bashrc.${USER}
ln -sv ${BASEDIR}/bashrc ~/.bashrc.${USER}
echo "Add source ~/.bashrc.${USER} to your .bashrc file"

# Xresources 
echo ln -sv ${BASEDIR}/Xresources ~/.Xresources
ln -sv ${BASEDIR}/Xresources ~/.Xresources

# tig
echo ln -sv ${BASEDIR}/tigrc ~/.tigrc
ln -sv ${BASEDIR}/tigrc ~/.tigrc

# make fonts folder if it doesn't exist already
LSFONTSDIR="$HOME"/.local/share/fonts
mkdir -p $LSFONTSDIR 

# if WSL, install the following packages
# sudo apt-get install x11-xserver-utils

# get preferred fonts
wget -nc -O $LSFONTSDIR https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf 
wget -nc -O $LSFONTSDIR https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf

fc-cache -rv
xrdb ~/.Xresources

# TODO Brew setup
#
#


# Brew installations
#brew install hh ; # https://github.com/dvorka/hstr.git
