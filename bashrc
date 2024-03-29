#       AUTHOR: Nathan A Harward, nateharward@gmail.com
# ORGANIZATION: self, personal dot file
#      COMPANY: self, personal dot file

# exit if non-interactive
test "${-#*i}" != "$-" || return 0

nate_error_log=/tmp/nate-errors
echo "I: (.bashrc.naharwar) [entering] `/bin/date`" >> $nate_error_log

# # use this logfile for debugging
# ec_bashrc_error_log=/tmp/eclogin-errors.$USER
# echo "I: (.bashrc.$USER) [entering] `/bin/date`" >> $ec_env_error_log

export EDITOR="vim -p"

export DOTFILES=$HOME/repos/dotfiles

BASE16_SHELL=$DOTFILES/base16-shell/
[ -n "$PS1" ] && [[ $TERM_PROGRAM != 'vscode' ]] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

if   [ -e /usr/share/terminfo/x/xterm-24bit ]; then
   export TERM='xterm-24bit'
elif [ -e /usr/share/terminfo/x/xterm-256color ]; then
   export TERM='xterm-256color'
else
   export TERM='xterm-color'
fi

if [[ $TERM_PROGRAM != 'vscode' ]]; then # leave vscode to its own theme
   base16_flat
fi

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
elif [[ $NNTPSERVER =~ ^.*intel.*$ ]]; then # on work machine
   export ONWORKMACHINE=1
elif [ -z ${EC_ZONE+x} ]; then # on work machine
   export ONWORKMACHINE=1
else
   PATH="$DOTFILES/.linuxbrew/bin:$PATH"
   export MANPATH="$(brew --prefix)/share/man:$MANPATH"
   export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"
fi


# Fix for bashit slowness
# https://github.com/Bash-it/bash-it/issues/914
export THEME_CHECK_SUDO=FALSE

# Load Bash It Settings and Bashit itself
source $HOME/.bashrc.bashit

if [ -r $HOME/.aliases-personal ]; then
   source $HOME/.aliases-personal
fi

if [ -r $HOME/.aliases-work ]; then
   source $HOME/.aliases-work
fi

# Load machine specific files
source $HOME/.bashrc.work

echo "I: (.bashrc.naharwar) [leaving] `/bin/date`" >> $nate_error_log
unset nate_error_log
