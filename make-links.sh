#!/bin/bash

curdir="$PWD"
dotfiles_dir=$(readlink -f $(dirname $0))

cd $dotfiles_dir
files=$(ls -ad .[A-z]* | egrep -v '.git|.*.swp')

cd $HOME
for f in ${files[@]}; do
    fullf="${dotfiles_dir}/$f"

    printf "\e[1;33m%s\e[0m " $f
    if [ -e $f -a ! -L $f ]; then
        printf "exists and is not a link (\e[1;31mnot removed\e[0m)\n"
    else
        \rm -f $f
        ln -s $fullf $f
        printf -- "-> \e[1;32mdotfiles/$f\e[0m done\n"
    fi
done

cd - >> /dev/null
exit 0
