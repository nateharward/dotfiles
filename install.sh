#!/bin/bash          
echo Setting up dotfiles

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# vim
ln -sv ${BASEDIR}/vimrc ~/.vimrc
echo "TODO Map .vim folder to disk location"

# tmux 
ln -sv ${BASEDIR}/tmux.conf ~/.tmux.conf
echo "TODO Map .tmux folder to disk location"

# bash
ln -sv ${BASEDIR}/bashrc ~/.bashrc.${USER}

echo "Add source ~/.bashrc.${USER} to your .bashrc file"
