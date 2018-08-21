[ -z "$PS1" ] && return

export PATH=${HOME}/bin:/usr/local/bin:/usr/local/sbin:/opt/ImageMagick/bin:${PATH}
if [ -d ~/bin/ec2-api-tools ]; then
  export EC2_HOME=~/bin/ec2-api-tools
  export PATH=${PATH}:${EC2_HOME}/bin
fi
if [ -d /usr/local/go/bin ]; then
  export PATH=/usr/local/go/bin:${PATH}
fi

if [ -f /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

export GOPATH=$HOME/go
export PATH=${PATH}:${GOPATH}/bin

################################### HISTORY ###################################

export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
export HISTFILE=~/.history
export HISTFILESIZE=2000

shopt -s histappend

############################ MISC SHELL OPTS ##################################

shopt -s checkwinsize           # update LINES/COLUMNS after each command
shopt -s cdspell
#shopt -s dirspell
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

# Shows file and line number in set -x output
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

# Use readline's ^W instead of the terminal driver's one
stty werase undef
bind '"\C-w": backward-kill-word'

# List completions on first tab
bind "set show-all-if-ambiguous on"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
#eval "$(dircolors -b ~/.dircolors)"
export LSCOLORS=gxfxcxdxbxegedabagacad

alias   l='\ls -GalhF'
alias   ll='\ls -GAlF'
alias   lm='ll | less'

alias   ..="cd .."
alias   cd..="cd .."
alias   h="history"
alias   j="jobs -l"
alias   rm="rm -i"
alias   more=less
alias   yyyymmddhhmm='date +%Y-%m-%d-%H-%M'
alias   nscript='enscript -2Gr'
alias   gemquery="gem query --details --remote --name-matches $*"

alias   st='git st'
alias   stt='git stt'

alias   k=kubectl
alias   kc="kubectl --kubeconfig=$HOME/scylla/current/kubeconfig"



# Completions
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
#if [ -d ~/completion ] ; then
    #for f in ~/completion/*; do
        #source $f
    #done
#fi

export TERM=xterm-256color
export CDPATH=~/dev/wd:~/dev:${HOME}
export LESS="-XRF -P?f%f:stdin. ?m(%i of %m) .?ltLine\: %lt. ?PB(%PB\%) ."
#export LESSOPEN="| /usr/local/bin/source-highlight --failsafe -f esc --infer-lang -i %s"
export IGNOREEOF=10
export PAGER="less"
export EDITOR="vim"
export HISTIGNORE="&:bg:fg:ll:h"

if [ "$_system_name" == "OSX" ]; then
  export red='\033[0;31m'
  export RED='\033[1;31m'
  export green='\033[0;32m'
  export GREEN='\033[1;32m'
  export blue='\033[0;34m'
  export BLUE='\033[1;34m'
  export cyan='\033[0;36m'
  export CYAN='\033[1;36m'
  export NC='\033[0m'
else
  export red='\e[0;31m'
  export RED='\e[1;31m'
  export green='\e[0;32m'
  export GREEN='\e[1;32m'
  export blue='\e[0;34m'
  export BLUE='\e[1;34m'
  export cyan='\e[0;36m'
  export CYAN='\e[1;36m'
  export NC='\e[0m'
fi

function sedrm()
{
  NUM=$1
  sed -ie "${NUM}d" ~/.ssh/known_hosts
}

function rpm-extract
{
    rpm2cpio $1 | cpio -idmv
}

function rpm-script-extract
{
  rpm -qp --scripts $1 > $1.scripts
}

function rpm-list
{
    rpm2cpio $1 | cpio -vt | less
}


if [ -f /usr/local/Cellar/bash-completion/1.3/etc/profile.d/bash_completion.sh ]; then
  . /usr/local/Cellar/bash-completion/1.3/etc/profile.d/bash_completion.sh
fi

# PROMPT

function __ruby_ver
{
    if [ "$GEM_HOME" != "" ]; then
        echo " $(basename $GEM_HOME | awk -F@ '{ print $1 }'):"
    fi
}

function __ruby_gemset
{
    if [ "$GEM_HOME" != "" ]; then
        gemset="$(basename $GEM_HOME | awk -F@ '{ print $2 }')"
        if [ "$gemset" == "" ]; then
            echo " global:"
        else
            echo " ${gemset}:"
        fi
    fi
}

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto
[ -f ~/bin/git-prompt.sh ] && . ~/bin/git-prompt.sh
export PS1='\e[1;36m\w:\e[1;33m$(__ruby_ver)\e[1;37m$(__ruby_gemset)\e[1;32m $(__git_ps1 "%s") \e[0m\n> '
#export PS1='\e[1;36m\w:\e[1;32m $(__git_ps1 "%s") \e[0m\n> '
#export PS1='\e[1;36m\w: \e[0m\n> '

[ -f ~/.rvm/scripts/rvm ] && . ~/.rvm/scripts/rvm

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

HOSTNAME=`hostname`
test -f $HOME/.bashrc.env.$HOSTNAME && . $HOME/.bashrc.env.$HOSTNAME

