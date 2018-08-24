#!/bin/bash          

# terminal colors and messeging {{{
# saw some things in spacevim install script and copied them over to my personal install script
Color_off='\033[0m'       # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

info() {
  msg "${Blue}[➭]${Color_off} ${1}${2}"
}

error() {
  msg "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

warn () {
  msg "${Red}[✘]${Color_off} ${1}${2}"
}

echo_with_color () {
  printf '%b\n' "$1$2$Color_off" >&2
}
# }}}

echo Setting up dotfiles

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "--------------------"
echo "  Linking Dotfiles  "
echo "--------------------"

link_dotfile () {
   if [[ -f "$HOME/.$1" ]]; then
      if [[ "$(readlink $HOME/.$1)" =~ ${BASEDIR}/$1 ]]; then
         info "File $HOME/.$1 already points to ${BASEDIR}/$1"
      else
         mv "$HOME/.$1" "$HOME/.$1_backup"
         success "Backed up $HOME/.$1 to $HOME/.$1_backup"
         ln -sv ${BASEDIR}/$1 $HOME/.$1
         success "Linked file $HOME/.$1 to ${BASEDIR}/$1"
      fi
   else
      ln -sv ${BASEDIR}/$1 $HOME/.$1
      success "Linked file $HOME/.$1 to ${BASEDIR}/$1"
   fi
}

link_user_dotfile () {
   if [[ -f "$HOME/.$1.${USER}" ]]; then
      if [[ "$(readlink $HOME/.$1.${USER})" =~ ${BASEDIR}/$1 ]]; then
         info "File $HOME/.$1.${USER} already points to ${BASEDIR}/$1"
      else
         mv "$HOME/.$1.${USER}" "$HOME/.$1_backup"
         success "Backed up $HOME/.$1.${USER} to $HOME/.$1_backup"
         ln -sv ${BASEDIR}/$1 $HOME/.$1.${USER}
         success "Linked file $HOME/.$1.${USER} to ${BASEDIR}/$1"
      fi
   else
      ln -sv ${BASEDIR}/$1 $HOME/.$1.${USER}
      success "Linked file $HOME/.$1.${USER} to ${BASEDIR}/$1"
   fi
}

# vim
link_dotfile "vimrc"

echo "TODO Map .vim folder to disk location"
#if [[ -d "$HOME/.vim" ]]; then
#   if [[ "$(readlink $HOME/.vim)" =~ \.SpaceVim$ ]]; then
#      success "Installed SpaceVim for vim"
#   else
#      mv "$HOME/.vim" "$HOME/.vim_back"
#      success "BackUp $HOME/.vim to $HOME/.vim_back"
#      ln -s "$HOME/.SpaceVim" "$HOME/.vim"
#      success "Installed SpaceVim for vim"
#   fi
#else
#   ln -s "$HOME/.SpaceVim" "$HOME/.vim"
#   success "Installed SpaceVim for vim"
#fi

# tmux 
link_dotfile "tmux.conf"
echo "TODO Map .tmux folder to disk location"

# bash
link_user_dotfile "bashrc"
echo "Add source ~/.bashrc.${USER} to your .bashrc file"

# Xresources 
link_dotfile "Xresources"

# tig
link_dotfile "tigrc"

# sc-im
link_dotfile "scimrc"

# if WSL, install the following packages
# sudo apt-get install x11-xserver-utils

echo "--------------------"
echo "     Font Setup     "
echo "--------------------"


# make fonts folder if it doesn't exist already
LSFONTSDIR=${HOME}/.local/share/fonts
mkdir -p $LSFONTSDIR 

# get preferred fonts
wget -nc --no-check-certificate -P ${LSFONTSDIR} https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf 
wget -nc --no-check-certificate -P ${LSFONTSDIR} https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf

fc-cache -rv
xrdb -merge ~/.Xresources


echo "--------------------"
echo "  TODO Brew Setup   "
echo "--------------------"


# TODO Brew setup
#
#


# Brew installations
#brew install hh ; # https://github.com/dvorka/hstr.git
