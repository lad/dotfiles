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

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
    #xterm-color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
    #if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	#color_prompt=yes
    #else
	#color_prompt=
    #fi
#fi

#if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #;;
#*)
    #;;
#esac

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
export PS1='\e[1;31m\u@\h \e[0;36m\w\e[1;32m$(__git_ps1 ": (%s)")\e[0m\n> '
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
