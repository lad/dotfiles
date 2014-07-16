[ -z "$PS1" ] && return

export PATH=${HOME}/bin:/usr/local/bin:/usr/local/sbin:/opt/ImageMagick/bin:${PATH}
if [ -d ~/bin/ec2-api-tools ]; then
  export EC2_HOME=~/bin/ec2-api-tools
  export PATH=${PATH}:${EC2_HOME}/bin
fi

if [ -f /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

################################### HISTORY ###################################

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

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

alias   l='ls -GalhF'
# ll() function is below
alias   lm='ll | less'
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
alias   +=pushd
alias   -- -=popd

alias   daily="vim $HOME/Documents/daily.txt"

alias   openchrome='open -a Google\ Chrome $*'
alias   rre='rake ruby:reek'
alias   rru='rake ruby:rubocop'
alias   rrs='rake ruby:spec'
alias   rrc='rake ruby:cucumber'
#alias   ctags-ruby="ctags -R --languages=ruby"
alias   ctags-ruby="rdoc -f tags --tag-style=vim -a"
alias   ctags-python="ctags -R --languages=python"

alias   st='git st'
alias   stt='git stt'
alias   sts='echo -en $green; git sts; echo -en $NC'
alias   stm='echo -en $red; git stm; echo -en $NC'
alias   std='echo -en $red; git std; echo -en $NC'

alias   nscript='enscript -2Gr'

function sshvdcl
{
  silo=$1
  shift
  echo "ssh -F ~/.vdcl/vdcl-$silo/ssh/config $*"
  ssh -F ~/.vdcl/vdcl-$silo/ssh/config $*
}

complete -F _ssh sshvdcl

function scpvdcl
{
  silo=$1
  shift
  echo "scp -F ~/.vdcl/vdcl-$silo/ssh/config $*"
  scp -F ~/.vdcl/vdcl-$silo/ssh/config $*
}

complete -F _ssh scpvdcl

alias   gemquery="gem query --details --remote --name-matches $*"


# Completions
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -d ~/completion ] ; then
    for f in ~/completion/*; do
        source $f
    done
fi

export TERM=xterm-256color
export CDPATH=${HOME}:~/dev:~/dev/wd
export LESS="-XRF -P?f%f:stdin. ?m(%i of %m) .?ltLine\: %lt. ?PB(%PB\%) ."
export LESSOPEN="| /usr/local/bin/source-highlight --failsafe -f esc --infer-lang -i %s"
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

function rpm-extract
{
    rpm2cpio.pl $1 | cpio -idmv
}

function rpm-list
{
    rpm2cpio.pl $1 | cpio -vt | less
}

function ff
{
    if [ -n "$1" ]; then d="$1"; else d="."; fi
    find "$d" | less
}

function ffn
{
    if [ $# -gt 1 ]; then
        dir="$1"
        shift
    else
        dir=.
    fi
    find "$dir"  -name "*${*}*" | less
}

function ffc
{
    if [ $# -gt 1 ]; then
        dir="$1"
        shift
    else
        dir=.
    fi
    find "$dir" -path "$dir/.git" -prune -o -type f -print0 | xargs -0 grep "$*"
}

function ffci
{
    if [ $# -gt 1 ]; then
        dir="$1"
        shift
    else
        dir=.
    fi
    find "$dir" -path "$dir/.git" -prune -o -type f -print0 | xargs -0 grep -i "$*"
}

function ll
{
    if [ -n "$*" ]; then
      \ls -GAlF $*
    else
      \ls -GAlF
    fi
}

function lll
{
  ll | awk 'BEGIN { nd=nf=0 } \
    /^total/  { total=$0; next } \
    /^d/      { dirs[nd]=$0; nd += 1 } \
    /^[^d]/   { files[nf]=$0; nf += 1 } \
    END { \
    print total
    for (i = 0; i < nd; i ++) \
      print dirs[i]; \
    for (i = 0; i < nf; i ++) \
      print files[i]; \
  }'
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

function penv
{
    PYTHONPATH=$(python -c "import sys; print ':'.join(sys.path)") $*
}

function mkenv
{
    [ -z "$1" ] && echo "Usage: mkenv virtual-env-name" && return 1
    virtualenv ~/venv/$1
    chenv $1
}

function rmenv
{
    local FORCE

    if [ "$1" == "-f" ]; then
        FORCE=1
        shift
    fi

    [ -z "$1" ] && echo "Usage: rmenv [-f] virtual-env-name" && return 1

    if [ "$VIRTUAL_ENV" == ~/venv/$1 ]; then
        if [ "$FORCE" ]; then
            deactivate
        else
            echo "Currently in ${1}. Use "deactivate" or rmenv -f"
            return
        fi
    fi

    rm -rf ~/venv/$1
}

function chenv
{
    [ $# -ne 1 ] && echo "Usage: chenv virtual-env-name" && return 1

    if [ $(type -t deactivate)"" == "function" ]; then
        deactivate
    fi

    . ~/venv/$1/bin/activate
}

pman ()
{
      man -t "${1}" | open -f -a /Applications/Preview.app
}

# BASH COMPLETION: chenv, rmenv

function listenv
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local venvs=""
    for d in ~/venv/*; do
        venvs+=" $(basename $d)"
    done
    COMPREPLY=( $(compgen -W "$venvs" -- $cur) )
}

complete -F listenv rmenv
complete -F listenv chenv

# BASH COMPLETION: rake

function rake_comp
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local tasks=""
    TOP_LEVEL=$(git rev-parse --show-toplevel 2>> /dev/null)
    if [ -f "${TOP_LEVEL}/Rakefile" -o -f ./Rakefile ]; then
        for task in $(rake -T 2>> /dev/null | awk '{ print $2 }'); do
            tasks+=" $task"
        done
        COMPREPLY=( $(compgen -W "$tasks" -- $cur ) )
    fi
}

complete -F rake_comp rake

. /usr/local/Cellar/bash-completion/1.3/etc/profile.d/bash_completion.sh

# BASH COMPLETIONS:
if [ -d ~/completions ]; then
    for f in ~/completions/*; do
        . $f
    done
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
#. /usr/share/git-core/git-prompt.sh
export PS1='\e[1;36m\w:\e[1;33m$(__ruby_ver)\e[1;37m$(__ruby_gemset)\e[1;32m $(__git_ps1 "%s") \e[0m\n> '

HOSTNAME=`hostname`
test -f $HOME/.bashrc.env.$HOSTNAME && . $HOME/.bashrc.env.$HOSTNAME

export PATH=~/.rvm/scripts:$PATH
. ~/.rvm/scripts/rvm


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
