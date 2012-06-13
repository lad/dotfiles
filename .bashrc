# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize       # update LINES/COLUMNS after each command
shopt -s cdspell
shopt -s dirspell
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


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color'
    alias fgrep='fgrep --color'
    alias egrep='egrep --color'
fi

# some more ls aliases
alias   l='ls -alF'
alias   ..="cd .."
alias   cd..="cd .."
alias   h="history"
alias   j="jobs -l"
alias   rm="rm -i"
alias   more=less

alias   daily="vim $HOME/Documents/todo/daily.txt"
alias   todo="vim $HOME/Documents/todo/todo.txt"
alias   qs="vim $HOME/Documents/todo/questions.txt"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PS1='\e[1;31m\u@\h$(term-title.sh) \e[0;36m\w\e[1;32m$(__git_ps1 ": (%s)")\e[0m\n> '
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

# Use readline's ^W instead of the terminal driver's one
stty werase undef
bind '"\C-w": backward-kill-word'

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

alias lm=ll

# Run all local completions
for f in ~/completion/*; do
    source $f
done
