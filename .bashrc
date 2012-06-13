
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s cdspell

shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit
shopt -s extglob        # Necessary for programmable completion.

shopt -u mailwarn
unset MAILCHECK         # Don't want my shell to warn me of incoming mail.

set -o notify
set -o noclobber
set -o ignoreeof

export red='\e[0;31m'
export RED='\e[1;31m'
export blue='\e[0;34m'
export BLUE='\e[1;34m'
export cyan='\e[0;36m'
export CYAN='\e[1;36m'
export NC='\e[0m'

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Fix for broken vim completion
complete -f -X '*.@(o|so|so.!(conf)|a|rpm|gif|GIF|jp?(e)g|JP?(E)G|mp3|MP3|mp?(e)g|MPG|avi|AVI|asf|ASF|ogg|OGG|class|CLASS)' vi vim gvim rvim view rview rgvim rgview gview emacs xemacs sxemacs kate kwrite

stty werase undef
bind '"\C-w": backward-kill-word'

alias   l="\ls -alF"
alias   ll="\ls -alF"
alias   lm="\ls -alF | less"
alias   ..="cd .."
alias   cd..="cd .."
alias   j..="jobs -l"
alias   h="history"
alias   g="git"
alias   rm="rm -i"
alias   more=less


export LESS="-XR -P?f%f:stdin. ?m(%i of %m) .?ltLine\: %lt. ?PB(%PB\%) ."

export CDPATH="$HOME"
export PAGER="less"
export EDITOR="vim"
export HISTIGNORE="&:bg:fg:ll:h"

export PS1="\e[1;31m\u \e[1;32m\w: > \e[0m"

# DIRS
export PD=~/Louis/Tracks/PD/pypd

function ff
{
    d="$1" || "."
    find $d | less
}

function ffn
{
    find "$1" -name "$2" | less
}

