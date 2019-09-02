# exit if non-interactive
test "${-#*i}" != "$-" || return 0

export DOTFILES=$HOME/repos/dotfiles

BASE16_SHELL=$DOTFILES/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

base16_flat
set -o vi
bind '"jj":vi-movement-mode'

# WSL / Windows Bash specific stuffs
if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
  export DISPLAY=:0
  xrdb $HOME/.Xresources
#else
#  echo "Anything else"
fi

# I never need XOFF (freezes vim)
bind -r '\C-s'
stty -ixon

# History
export HISTSIZE=9000
export HISTCONTROL=ignoredups:erasedups #don't write duplicate entries.
shopt -s histappend # append to the history file, instead of the default which is to overwrite \

# Linuxbrew
if [[ $HOSTNAME =~ ^.*\.intel.com$ ]]; then # on work machine
   export ONWORKMACHINE=1
else
   PATH="$DOTFILES/brew/bin:$PATH"
   export MANPATH="$(brew --prefix)/share/man:$MANPATH"
   export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"
fi


# Fix for bashit slowness
# https://github.com/Bash-it/bash-it/issues/914
export THEME_CHECK_SUDO=FALSE

# Load Bash It Settings and Bashit itself
source "$HOME"/.bashrc.bashit

if [ -r $HOME/.aliases-bash-personal ]; then
  source $HOME/.aliases-bash-personal
fi

if [ -r $HOME/.aliases-bash-work ]; then
  source $HOME/.aliases-bash-work
fi

# Load machine specific files
source $HOME/.bashrc.work
