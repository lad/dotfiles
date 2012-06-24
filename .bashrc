[ -z "$PS1" ] && return

################################### HISTORY ###################################

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend

############################ MISC SHELL OPTS ##################################

shopt -s checkwinsize           # update LINES/COLUMNS after each command
shopt -s cdspell
shopt -s dirspell
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit
shopt -s extglob                # Necessary for programmable completion.
shopt -u mailwarn
unset MAILCHECK

set -o notify
set -o noclobber
set -o ignoreeof

# Use readline's ^W instead of the terminal driver's one
stty werase undef
bind '"\C-w": backward-kill-word'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
eval "$(dircolors -b ~/.dircolors)"

alias   ls='ls --color=auto'
alias   l='ls -alF --color=auto'
# ll() function is below
alias   lm=ll
alias   ..="cd .."
alias   cd..="cd .."
alias   h="history"
alias   j="jobs -l"
alias   rm="rm -i"
alias   more=less
alias   grep='grep --color'
alias   fgrep='fgrep --color'
alias   egrep='egrep --color'
alias   yyyymmddhhmm='date +%Y-%m-%d-%H-%M'

alias   daily="vim $HOME/Documents/todo/daily.txt"
alias   todo="vim $HOME/Documents/todo/todo.txt"
alias   qs="vim $HOME/Documents/todo/questions.txt"

# Completions
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
for f in ~/completion/*; do
    source $f
done

#export PS1='\e[1;31m\u@\h$(term-title.sh) \e[0;36m\w\e[1;32m$(__git_ps1 ": (%s)")\e[0m\n> '
export PS1='\e[1;31m\u@\h \e[1;36m\w\e[1;32m$(__git_ps1 ": (%s)")\e[0m\n> '
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto

export G=${HOME}/dev/git
export CDPATH=${HOME}:${G}
export LESS="-XRF -P?f%f:stdin. ?m(%i of %m) .?ltLine\: %lt. ?PB(%PB\%) ."
export IGNOREEOF=10
export PAGER="less"
export EDITOR="vim"
export HISTIGNORE="&:bg:fg:ll:h"

export red='\e[0;31m'
export RED='\e[1;31m'
export blue='\e[0;34m'
export BLUE='\e[1;34m'
export cyan='\e[0;36m'
export CYAN='\e[1;36m'
export NC='\e[0m'

function ff
{
    if [ -n "$1" ]; then d="$1"; else d="."; fi
    find "$d" | less
}

function ffn
{
    find . -name "*${1}*" | less
}

function ffnn
{
    find "$1" -name "*${2}*" | less
}

function ffc
{
    find . -type f -print0 | xargs -0 grep "$1"
}

function ffcc
{
    find "$1" -name "*${2}*" -print0 | xargs -0 grep "$3"
}

function ll
{
    if [ -n "$1" ]; then d="$1"; else d="."; fi
    \ls -AlF --color "$d" | less
}

function i
{
    if [ -z "$1" ]; then
        echo "Usage: i <name>"
        return 1
    fi

    f="$HOME/Documents/todo/issue-${1}.txt"
    if [ ! -f "$f" ]; then
        echo -e "Issue $1 - $(date)\n" >> "$f"
    fi
    vim "$f"
    if [ $(wc -l "$f" | cut -d " " -f 1) -eq 0 ]; then
        echo "Removed $f"
        \rm -f "$f"
    fi
}

HOSTNAME=`hostname`
test -f $HOME/.bashrc.env.$HOSTNAME && . $HOME/.bashrc.env.$HOSTNAME
