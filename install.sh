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

# tig
echo ln -sv ${BASEDIR}/tigrc ~/.tigrc
ln -sv ${BASEDIR}/tigrc ~/.tigrc

# make fonts folder if it doesn't exist already
LSFONTSDIR=$HOME/.local/share/fonts
mkdir -p $LSFONTSDIR 

# get preferred fonts
wget -nc https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S-DZ/complete/Meslo%20LG%20S%20DZ%20Regular%20Nerd%20Font%20Complete.otf $LSFONTSDIR 
wget -nc https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S-DZ/complete/Meslo%20LG%20S%20DZ%20Regular%20Nerd%20Font%20Complete%20Mono.otf $LSFONTSDIR
fc-cache -rv
xrdb ~/.Xresources

# TODO Brew setup
#
#


# Brew installations
brew install hh ; # https://github.com/dvorka/hstr.git
