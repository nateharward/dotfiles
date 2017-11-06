#!/bin/bash          
echo Setting up dotfiles

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
ln -sv ${BASEDIR}/vimrc ~/.vimrc

# tmux 
ln -sv ${BASEDIR}/tmux.conf ~/.tmux.conf

# bash
ln -sv ${BASEDIR}/bashrc ~/.bashrc.${USER}

echo "Add source ~/.bashrc.${USER} to your .bashrc file"
